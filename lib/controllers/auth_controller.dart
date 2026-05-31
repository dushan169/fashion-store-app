import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxBool isFirstTime = true.obs;
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;

  // Current user data
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userPhone = ''.obs;
  final RxString userPhotoUrl = ''.obs;

  User? get currentUser => _auth.currentUser;
  String? get userId => _auth.currentUser?.uid;

  bool get firstTime => isFirstTime.value;
  bool get loggedIn => isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    isFirstTime.value = _storage.read('isFirstTime') ?? true;

    // Listen to Firebase auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isLoggedIn.value = true;
        _loadUserData(user.uid);
      } else {
        isLoggedIn.value = false;
        _clearUserData();
      }
    });
  }

  void setFirstTimeDone() {
    isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  // ─── REGISTER ───────────────────────────────────────────────
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      // Create Firebase Auth user
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Update display name
      await credential.user!.updateDisplayName(name.trim());

      // Save user to Firestore
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'name': name.trim(),
        'email': email.trim(),
        'phone': '',
        'photoUrl': '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      isLoggedIn.value = true;
      Get.snackbar('Success', 'Account created successfully!');
      return true;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      Get.snackbar('Error', message);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ─── LOGIN ───────────────────────────────────────────────────
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      isLoggedIn.value = true;
      Get.snackbar('Welcome back!', 'Signed in successfully.');
      return true;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      Get.snackbar('Error', message);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ─── LOGOUT ──────────────────────────────────────────────────
  Future<void> logout() async {
    await _auth.signOut();
    isLoggedIn.value = false;
    _clearUserData();
  }

  // ─── FORGOT PASSWORD ─────────────────────────────────────────
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar('Email Sent', 'Password reset email sent to $email');
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', _getAuthErrorMessage(e.code));
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ─── UPDATE PROFILE ──────────────────────────────────────────
  Future<bool> updateProfile({
    required String name,
    required String phone,
    String? photoUrl,
  }) async {
    try {
      isLoading.value = true;
      final uid = userId;
      if (uid == null) return false;

      Map<String, dynamic> updates = {
        'name': name.trim(),
        'phone': phone.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      if (photoUrl != null) updates['photoUrl'] = photoUrl;

      await _firestore.collection('users').doc(uid).update(updates);
      await currentUser!.updateDisplayName(name.trim());

      userName.value = name.trim();
      userPhone.value = phone.trim();
      if (photoUrl != null) userPhotoUrl.value = photoUrl;

      Get.snackbar('Success', 'Profile updated successfully!');
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ─── LOAD USER DATA ──────────────────────────────────────────
  Future<void> _loadUserData(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        userName.value = data['name'] ?? '';
        userEmail.value = data['email'] ?? '';
        userPhone.value = data['phone'] ?? '';
        userPhotoUrl.value = data['photoUrl'] ?? '';
      }
    } catch (e) {
      // Silently fail
    }
  }

  void _clearUserData() {
    userName.value = '';
    userEmail.value = '';
    userPhone.value = '';
    userPhotoUrl.value = '';
  }

  // ─── ERROR MESSAGES ──────────────────────────────────────────
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
