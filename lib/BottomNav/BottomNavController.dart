import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavController extends GetxController {
  // Deklarasikan PersistentTabController untuk mengontrol navbar
  late PersistentTabController navBarController;

  @override
  void onInit() {
    super.onInit();
    navBarController = PersistentTabController(initialIndex: 0); // Set initial index sesuai kebutuhan
  }

// Jika diperlukan, bisa menambahkan logika tambahan di sini
}
