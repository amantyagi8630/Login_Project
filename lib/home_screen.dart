import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:login_project/custom_widgets/custom_app_background/app_background.dart';
import 'package:login_project/custom_widgets/custom_button_widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'On Boarding',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto-Black',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Center(
                child: AppBackground(
                  conHeight: screenHeight,
                  conWidth: double.infinity,
                  widget: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            const Text(
                              "Hello There!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 40,
                                  fontFamily: 'Roboto-Black'),
                            ),
                            Image.asset(
                              'Images/rocket-launch.png',
                              height: 450,
                              width: 300,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomElevatedButton(
                              btnName: 'Sign Up',
                              bgColor: Colors.blue.shade900,
                              callback: () {
                                Get.toNamed('/b');
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomElevatedButton(
                              btnName: 'Login',
                              bgColor: Colors.red.shade500,
                              callback: () {
                                Get.toNamed('/c');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
