import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_project/Sign_Up_Page.dart';
import 'package:login_project/Splash_Screen.dart';
import 'package:login_project/dashboard_screen.dart';
import 'package:login_project/home_screen.dart';

import 'Sign_in_page.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      defaultTransition: Transition.leftToRight,
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/a", page: () => const HomeScreen()),
        GetPage(name: "/b", page: () => const SignUp()),
        GetPage(name: "/c", page: () => SignIn()),
        GetPage(name: "/d", page: () => const Dashboard()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}