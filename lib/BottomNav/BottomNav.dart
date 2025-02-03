import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_firebase/Add/AddScreen.dart';
import 'package:project_firebase/Home/home_screen.dart';
import 'package:project_firebase/Profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'BottomNavController.dart';

class BottomNavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil controller menggunakan GetX
    final BottomNavController controller = Get.find();

    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        AddScreen(),
        ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.add),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
          iconSize: 30.0,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle),
          title: ("Profile"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: controller.navBarController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        navBarStyle: NavBarStyle.style1,
        navBarHeight: 80.0,  // Menambah tinggi navbar
      ),
    );
  }
}
