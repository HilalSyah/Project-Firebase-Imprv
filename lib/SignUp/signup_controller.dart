import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final errorType = 'none'.obs;

  Color get errorColor =>
      errorType.value == 'empty' ? Colors.orange : Colors.red;

  Color get errorBackgroundColor => errorType.value == 'empty'
      ? Colors.orange.withOpacity(0.1)
      : Colors.red.withOpacity(0.1);

  Color get errorBorderColor => errorType.value == 'empty'
      ? Colors.orange.withOpacity(0.3)
      : Colors.red.withOpacity(0.3);

  IconData get errorIcon => errorType.value == 'empty'
      ? Icons.warning_amber_rounded
      : Icons.error_outline;

  bool validateEmptyFields(String username, String email, String password) {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Semua harus diisi';
      errorType.value = 'empty';
      return false;
    }
    return true;
  }

  bool validateUsername(String username) {
    if (username.isEmpty) return true;
    if (username.length < 6) {
      errorMessage.value = 'Username minimal 6 karakter';
      errorType.value = 'validation';
      return false;
    }
    return true;
  }

  bool validateEmail(String email) {
    if (email.isEmpty) return true;
    if (!email.endsWith('@gmail.com')) {
      errorMessage.value = 'Email harus menggunakan @gmail.com';
      errorType.value = 'validation';
      return false;
    }
    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) return true;

    if (password.length < 8) {
      errorMessage.value = 'Password minimal 8 karakter';
      errorType.value = 'validation';
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      errorMessage.value = 'Password harus mengandung huruf kapital';
      errorType.value = 'validation';
      return false;
    }


    return true;
  }

  void signUp(String username, String email, String password) {
    errorMessage.value = '';
    errorType.value = 'none';

    if (!validateEmptyFields(username, email, password)) return;
    if (!validateUsername(username)) return;
    if (!validateEmail(email)) return;
    if (!validatePassword(password)) return;

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.offAllNamed('/login');
    });
  }
}
