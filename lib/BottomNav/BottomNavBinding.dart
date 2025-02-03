import 'package:get/get.dart';
import 'BottomNavController.dart';


class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController()); // Menginisialisasi controller
  }
}
