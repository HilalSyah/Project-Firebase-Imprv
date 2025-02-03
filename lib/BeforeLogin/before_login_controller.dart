import 'package:get/get.dart';

class BeforeLoginController extends GetxController {
  // Contoh metode untuk menanggapi tombol tekan
  void onEmailPressed() {
    Get.offAllNamed('/login');
  }



  void onFacebookPressed() {
    print("Facebook button pressed");
  }

  void onSignInPressed() {
    Get.offAllNamed('/login');
  }
}
