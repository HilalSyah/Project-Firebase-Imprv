import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/custom_button_before.dart';
import '../Service/GogleAuth.dart';
import 'dart:math';
import 'component/custom_text_before.dart';
import 'before_login_controller.dart'; // Import untuk menggunakan min

class BeforeLogin extends StatelessWidget {
  const BeforeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BeforeLoginController());

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;

            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.05), // Responsive height
                      Text(
                        "Explore now",
                        style: TextStyle(
                          fontSize:
                              min(screenWidth * 0.1, 40), // Batas maksimum 40
                          fontWeight: FontWeight.bold,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Join SO today.",
                        style: TextStyle(
                          fontSize:
                              min(screenWidth * 0.05, 20), // Batas maksimum 20
                          fontWeight: FontWeight.bold,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
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
                        textSize:
                            min(screenWidth * 0.045, 18), // Batas maksimum 18
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomButton(
                        text: "Continue with Facebook",
                        onPressed: controller.onFacebookPressed,
                        imagePath: 'assets/images/facebooklogo.png',
                        textSize:
                            min(screenWidth * 0.045, 18), // Batas maksimum 18
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02),
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
                      CustomButton(
                        text: "Create account",
                        onPressed: () {
                          Get.offAllNamed('/signup');
                        },
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        height:
                            min(screenHeight * 0.08, 60), // Batas maksimum 60
                        textSize:
                            min(screenWidth * 0.05, 20), // Batas maksimum 20
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize:
                              min(screenWidth * 0.04, 16), // Batas maksimum 16
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomButton(
                        text: "Login",
                        onPressed: () {
                          Get.offAllNamed('/login');
                        },
                        backgroundColor: Colors.white,
                        textColor: Colors.blue,
                        height:
                            min(screenHeight * 0.08, 60), // Batas maksimum 60
                        textSize:
                            min(screenWidth * 0.05, 20), // Batas maksimum 20
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                    child: CustomText(
                      text: 'By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            min(screenWidth * 0.03, 12), // Batas maksimum 12
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
