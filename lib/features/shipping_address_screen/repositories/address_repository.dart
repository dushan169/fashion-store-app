import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_store_app/features/shipping_address_screen/models/address.dart';

class AddressRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Address>> getUserAddresses(String userId) {
    return _firestore
        .collection('addresses')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((s) => s.docs.map((d) => Address.fromFirestore(d)).toList());
  }

  Future<bool> addAddress(Address address) async {
    try {
      if (address.isDefault) await _unsetDefaultAddresses(address.userId);
      await _firestore.collection('addresses').add(address.toFirestore());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAddress(String addressId) async {
    try {
      await _firestore.collection('addresses').doc(addressId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setDefaultAddress(String userId, String addressId) async {
    try {
      await _unsetDefaultAddresses(userId);
      await _firestore.collection('addresses').doc(addressId).update({'isDefault': true});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Address?> getDefaultAddress(String userId) async {
    final snapshot = await _firestore
        .collection('addresses')
        .where('userId', isEqualTo: userId)
        .where('isDefault', isEqualTo: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) return Address.fromFirestore(snapshot.docs.first);
    return null;
  }

  // Keep old sync method for backward compat
  List<Address> getAddresses() => [];

  Future<void> _unsetDefaultAddresses(String userId) async {
    final snapshot = await _firestore
        .collection('addresses')
        .where('userId', isEqualTo: userId)
        .where('isDefault', isEqualTo: true)
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.update({'isDefault': false});
    }
  }
}
