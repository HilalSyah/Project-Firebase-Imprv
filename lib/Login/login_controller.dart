import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_firebase_imprv/Service/firebase_api.dart';

import '../Profile/profile_controller.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final _firebaseApi = FirebaseApi();
  final ProfileControllerFB profileController = Get.put(ProfileControllerFB());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void login(String name, String email, String password) async {
    isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        // Data ditemukan, update profile controller
        String name = userDoc['name'] ?? 'Nama tidak tersedia';
        String email = userDoc['email'] ?? 'Email tidak tersedia';

        // Update profile controller dengan data pengguna

        // Tampilkan notifikasi setelah login berhasil
        await _firebaseApi.showNotification(
          title: 'Login Berhasil',
          body: 'Selamat datang kembali, $name!',
        );

        if (userCredential.user!.providerData[0].providerId == 'google.com') {
          // User logged in with Google
          String profilePicture = userDoc['profilePicture'] ?? '';
          profileController.updateProfile(name, email, '', profilePicture);
        } else {
          // User logged in with email/password
          profileController.updateProfile(name, email, password, '');
        }

        await Future.delayed(const Duration(seconds: 1));
        // Navigasikan ke halaman home
        Get.offAllNamed('/bottomnav');
      } else {
        // Data pengguna tidak ditemukan di Firestore
        Fluttertoast.showToast(
          msg: 'Akun tidak ditemukan. Silakan daftar terlebih dahulu.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login gagal. Silakan coba lagi.';
      if (e.code == 'user-not-found') {
        errorMessage = 'Email tidak ditemukan.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password salah.';
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
