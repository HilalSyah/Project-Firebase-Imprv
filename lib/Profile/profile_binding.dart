import 'package:get/get.dart';
import 'package:project_firebase/Profile/profile_controller.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileControllerFB>(() => ProfileControllerFB());
  }
}
