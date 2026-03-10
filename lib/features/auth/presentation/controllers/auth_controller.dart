import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hre/core/services/auth_service.dart';
import 'package:hre/core/utils/snackbar_utils.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  Rx<User?> get userRx => _user;
  
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_authService.authStateChanges);
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.signIn(email, password);
    } catch (e) {
      SnackbarUtils.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      await _authService.signInWithGoogle();
    } catch (e) {
      SnackbarUtils.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.signUp(email, password);
      Get.back(); // Go back to login after signup
    } catch (e) {
      SnackbarUtils.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
