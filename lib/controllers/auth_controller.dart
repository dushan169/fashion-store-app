import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final _storage = GetStorage();

  final RxBool isFirstTime = true.obs;
  final RxBool isLoggedIn = false.obs;

  bool get firstTime => isFirstTime.value;
  bool get loggedIn => isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
  }

  void _loadInitialState() {
    isFirstTime.value = _storage.read('isFirstTime') ?? true;
    isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
  }

  void setFirstTimeDone() {
    isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  void login() {
    isLoggedIn.value = true;
    _storage.write('isLoggedIn', true);
  }

  void logout() {
    isLoggedIn.value = false;
    _storage.write('isLoggedIn', false);
  }
}