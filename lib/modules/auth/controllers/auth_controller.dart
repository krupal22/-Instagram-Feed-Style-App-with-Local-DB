import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    if (savedUsername != null && savedUsername.isNotEmpty) {
      username.value = savedUsername;
      isLoggedIn.value = true;
    }
    print("User Login : ${isLoggedIn.value}");
    return isLoggedIn.value;
  }

  Future<void> login(String inputUsername) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', inputUsername);
    username.value = inputUsername;
    isLoggedIn.value = true;
    Get.offAllNamed('/feed');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    username.value = '';
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
