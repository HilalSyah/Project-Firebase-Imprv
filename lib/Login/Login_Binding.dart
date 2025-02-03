import 'package:get/get.dart';

import '../Profile/profile_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileControllerFB>(() => ProfileControllerFB());
  }
}
