import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          print(userController.isLoggedIn);
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
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0C187A), Color(0xFF030F56), Color(0xFF019CDF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
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
