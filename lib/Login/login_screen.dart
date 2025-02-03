import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_firebase_imprv/Service/FacebookAuth.dart';
import '../Service/GogleAuth.dart';
import '../BeforeLogin/component/custom_button_before.dart';
import 'component/CustomTextButton.dart';
import '../BeforeLogin/component/custom_text_before.dart';
import 'component/custom_textfield.dart';
import 'dart:math';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        // Memungkinkan scroll pada layar kecil
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar di atas
            Container(
              width: double.infinity,
              height: min(screenHeight * 0.15, 300), // Batas maksimum 300
              child: Image.asset(
                'assets/images/nobg.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                children: [
                  // Judul di atas form
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Let's Connect With Us!",
                          style: TextStyle(
                            fontSize: min(
                                screenWidth * 0.08, 30), // Batas maksimum 30
                            fontWeight: FontWeight.bold,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Form input
                  CustomTextField(
                    hintText: '',
                    controller: emailController,
                    obscureText: false,
                    labelText: 'Email',
                  ),
                  CustomTextField(
                    hintText: '',
                    controller: passwordController,
                    obscureText: true,
                    labelText: 'Password',
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Tombol login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        loginController.login(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 15.0,
                        ),
                        minimumSize: Size(double.infinity, 40), // Ukuran penuh
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize:
                              min(screenWidth * 0.07, 25), // Batas maksimum 25
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Separator
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomText(
                          text: 'or',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Tombol sign up dengan Google
                  CustomButton(
                    text: "Sign up with Google",
                    onPressed: () async {
                      try {
                        await Gogleauth().signInGoogle(context);
                      } catch (e) {
                        print("Error during Google Sign-In: $e");
                      }
                    },
                    imagePath: 'assets/images/logogoogle.png',
                    textSize: min(screenWidth * 0.05, 22), // Batas maksimum 22
                  ),
                  CustomButton(
                    text: "Continue Facebook",
                    onPressed: () async {
                      try {
                        await FacebookAuthService().signInWithFacebook(context);
                      } catch (e) {
                        print("Error during Google Sign-In: $e");
                      }
                    },
                    imagePath: 'assets/images/facebooklogo.png',
                    textSize: min(screenWidth * 0.06, 22), // Batas maksimum 22
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CustomRichTextButton(
                firstText: "Don't have an account? ",
                secondText: 'Sign up',
                onPressed: () {
                  Get.offAllNamed('/signup');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
