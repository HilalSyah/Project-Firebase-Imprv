import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class Gogleauth {
  final FirebaseAuth firebaseGoogleAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return firebaseGoogleAuth.currentUser;
  }

  Future<void> signInGoogle(BuildContext context) async {
    try {
      // Login dengan Google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Login ke Firebase
      final UserCredential userCredential =
      await firebaseGoogleAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Simpan data pengguna ke Firestore
        await firebaseFirestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          'lastSignInTime': DateTime.now(),
        });

        print("Data pengguna berhasil disimpan ke Firestore.");

        // Tampilkan notifikasi berhasil login
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'Login Berhasil',
            body: 'Selamat datang, ${user.displayName}!',
            notificationLayout: NotificationLayout.Default,
          ),
        );

        // Navigasi ke HomeScreen setelah login berhasil
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/bottomnav',
              (route) => false,
        );
      }
    } catch (e) {
      print("Error saat login dengan Google: $e");

      // Tampilkan notifikasi error
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 2,
          channelKey: 'basic_channel',
          title: 'Login Gagal',
          body: 'Terjadi kesalahan: $e',
          notificationLayout: NotificationLayout.Default,
        ),
      );
    }
  }
}
