import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'Add/AddBinding.dart';
import 'Add/AddScreen.dart';
import 'BeforeLogin/before_Binding.dart';
import 'BeforeLogin/before_login.dart';
import 'BottomNav/BottomNav.dart';
import 'BottomNav/BottomNavBinding.dart';
import 'Home/card/card_controller.dart';
import 'Home/home_binding.dart';
import 'Home/home_screen.dart';
import 'Login/Login_Binding.dart';
import 'Login/login_screen.dart';
import 'Profile/profile_binding.dart';
import 'Profile/profile_controller.dart';
import 'Profile/profile_screen.dart';
import 'Service/firebase_api.dart';
import 'SignUp/SignUp_Binding.dart';
import 'SignUp/signup_screen.dart';
import 'Splash/SplashScreen_Binding.dart';
import 'Splash/splash_screen.dart';
import 'firebase_options.dart'; // Import this for full screen mode

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ProfileControllerFB());
  Get.put(CartController());

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Firebase API
  await FirebaseApi().initNotifications();

  // Set screen to full screen (optional)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'WorkSans', // Menambahkan font default 'Roboto'
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => SplashScreen(),
            binding: SplashScreenBinding()),
        GetPage(
            name: '/login',
            page: () => LoginScreen(),
            binding: LoginBinding()),
        GetPage(
            name: '/before',
            page: () => BeforeLogin(),
            binding: BeforeLoginBinding()),
        GetPage(
            name: '/signup',
            page: () => SignUpScreen(),
            binding: SignUpBinding()),
        GetPage(name: '/home',
            page: () => HomeScreen(),
            binding: HomeBinding()),
        GetPage(
          name: '/profile',
          page: () => ProfileScreen(),
          binding: ProfileBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/add',
          page: () => AddScreen(),
          binding: AddBinding(), // Bind AddController ke AddScreen
        ),
        GetPage(
          name: '/bottomnav',
          page: () => BottomNavScreen(),
          binding: BottomNavBinding(), // Bind AddController ke AddScreen
        ),

      ],
    );
  }
}
