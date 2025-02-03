import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_firebase_imprv/Service/GogleAuth.dart';

class SplashController extends GetxController {
  final Gogleauth _googleAuth = Gogleauth();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  void checkAuth() async {
    await Future.delayed(
        const Duration(seconds: 5)); // Delay untuk splash screen

    // Cek apakah ada user yang sedang login
    final currentUser = _auth.currentUser ?? _googleAuth.getCurrentUser();

    if (currentUser != null) {
      // User sudah login, langsung ke home
      Get.offAllNamed('/bottomnav');
    } else {
      // User belum login, ke login screen
      Get.offAllNamed('/before');
    }
  }
}
