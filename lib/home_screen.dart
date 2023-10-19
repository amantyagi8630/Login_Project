import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
          child: Container(
            height: screenHeight,
            width: double.infinity,
            // width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0C187A), Color(0xFF030F56), Color(0xFF019CDF)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Column(
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          elevation: 10,
                          minimumSize: const Size(370, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () {
                          Get.toNamed('/b');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Roboto-Black',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade500,
                          elevation: 10,
                          minimumSize: const Size(370, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () {
                          Get.toNamed('/c');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Roboto-Black',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
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
