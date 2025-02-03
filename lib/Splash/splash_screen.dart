import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_firebase_imprv/Splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menambahkan gambar
            Image.asset(
              'assets/images/login.png', // Ganti dengan path gambar kamu
              height: 150, // Sesuaikan ukuran gambar
              width: 150, // Sesuaikan ukuran gambar
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
