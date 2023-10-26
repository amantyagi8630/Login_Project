import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_project/custom_widgets/custom_app_background/app_background.dart';
import 'controller/user_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  int _charCount = 0;
  String _welcomeText = '';

  var userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    userController.checkLoggedInStatus();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_charCount < 7) {
        setState(() {
          _welcomeText += 'Welcome'[_charCount];
          _charCount++;
        });
      } else {
        _timer.cancel();
        if (userController.isLoggedIn == true) {
          Get.offAllNamed('/d');
        } else {
          Get.offAllNamed('/a');
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppBackground(
          conHeight: double.infinity,
          conWidth: double.infinity,
          widget: Center(
            child: Text(
              _welcomeText,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto-Black',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
