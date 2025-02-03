import 'package:get/get.dart';
import 'AddController.dart';

class AddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddController>(() => AddController());
  }
}
