import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      // Login dengan Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Login ke Firebase
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(facebookAuthCredential);
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
            '/home',
            (route) => false,
          );
        }
      } else {
        print("Login dengan Facebook dibatalkan oleh pengguna.");
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 3,
            channelKey: 'basic_channel',
            title: 'Login Gagal',
            body: 'Login dengan Facebook dibatalkan.',
            notificationLayout: NotificationLayout.Default,
          ),
        );
      }
    } catch (e) {
      print("Error saat login dengan Facebook: $e");

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
