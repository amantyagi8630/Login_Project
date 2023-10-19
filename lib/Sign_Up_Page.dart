import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  var registeredUsers = <Map<String, String>>[].obs;

  void addUser(Map<String, String> user) {
    registeredUsers.add(user);
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool passwordsMatch = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final box = GetStorage();

  var userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    loadRegisteredUsers();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle myTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      decoration: TextDecoration.none,
      decorationThickness: 0,
      fontFamily: 'Roboto-Black',
      fontWeight: FontWeight.w800,
      letterSpacing: 0.8,
    );

    OutlineInputBorder myEnabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 2.5),
      borderRadius: BorderRadius.circular(25),
    );

    OutlineInputBorder myFocusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blue, width: 2.5),
      borderRadius: BorderRadius.circular(25),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.toNamed('/a');
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0C187A),
                  Color(0xFF030F56),
                  Color(0xFF019CDF)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Roboto-Black',
                            fontWeight: FontWeight.w800,
                            fontSize: 35,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Create an Account, It's free",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto-Black',
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        TextFormField(
                          style: myTextStyle,
                          controller: usernameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              color: Colors.white,
                              Icons.person,
                              size: 25,
                            ),
                            labelText: 'Username',
                            hintText: 'Enter Your Name',
                            labelStyle: myTextStyle,
                            hintStyle: myTextStyle,
                            enabledBorder: myEnabledBorder,
                            focusedBorder: myFocusedBorder,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: myTextStyle,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(
                              color: Colors.white,
                              Icons.email,
                              size: 25,
                            ),
                            hintText: 'Enter Your Email',
                            labelStyle: myTextStyle,
                            hintStyle: myTextStyle,
                            enabledBorder: myEnabledBorder,
                            focusedBorder: myFocusedBorder,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            } else if (!value.endsWith('@gmail.com') ||
                                value.length < 10) {
                              return 'Please enter a valid username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: myTextStyle,
                          obscureText: _obscurePassword,
                          obscuringCharacter: "*",
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 25,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                            labelStyle: myTextStyle,
                            hintStyle: myTextStyle,
                            enabledBorder: myEnabledBorder,
                            focusedBorder: myFocusedBorder,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 8) {
                              return 'minimum length required 8 characters';
                            } else if (value.length > 14) {
                              return 'maximum length required 14 characters';
                            } else if (!RegExp(
                                    r'^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).+$')
                                .hasMatch(value)) {
                              return 'Please enter a valid password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: myTextStyle,
                          controller: confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              color: Colors.white,
                              Icons.lock,
                              size: 25,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                color: Colors.white,
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: myTextStyle,
                            hintStyle: myTextStyle,
                            hintText: 'Enter Your Password',
                            enabledBorder: myEnabledBorder,
                            focusedBorder: myFocusedBorder,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Builder(builder: (context) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade800,
                              elevation: 10,
                              minimumSize: const Size(370, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  final email = emailController.text;
                                  final password = passwordController.text;
                                  final name = usernameController.text;
                                  if (isEmailRegistered(email)) {
                                    Get.snackbar(
                                      '',
                                      '',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      borderRadius: 50.0,
                                      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                      duration: const Duration(seconds: 3),
                                      padding: const EdgeInsets.only(bottom: 25),
                                      isDismissible: true,
                                      dismissDirection: DismissDirection.horizontal,
                                      forwardAnimationCurve: Curves.easeOutBack,
                                      reverseAnimationCurve: Curves.easeInBack,
                                      messageText: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Account already registered',
                                            style: TextStyle(
                                              fontFamily: "Roboto-Black",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              letterSpacing: 0.8,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    userController.addUser({
                                      'name': name,
                                      'email': email,
                                      'password': password,
                                    });
                                    saveRegisteredUsers();
                                    saveUserDetails(name, email, password);
                                    // Get.offAllNamed('/c');
                                    print(userController.registeredUsers);
                                    Get.snackbar(
                                      '',
                                      '',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      borderRadius: 50.0,
                                      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                      duration: const Duration(seconds: 3),
                                      padding: const EdgeInsets.only(bottom: 25),
                                      isDismissible: true,
                                      dismissDirection: DismissDirection.horizontal,
                                      forwardAnimationCurve: Curves.easeOutBack,
                                      reverseAnimationCurve: Curves.easeInBack,
                                      messageText: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Account registration successful',
                                            style: TextStyle(
                                              fontFamily: "Roboto-Black",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              letterSpacing: 0.8,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    '',
                                    '',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.orange,
                                    borderRadius: 50.0,
                                    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    duration: const Duration(seconds: 3),
                                    padding: const EdgeInsets.only(bottom: 25),
                                    isDismissible: true,
                                    dismissDirection: DismissDirection.horizontal,
                                    forwardAnimationCurve: Curves.easeOutBack,
                                    reverseAnimationCurve: Curves.easeInBack,
                                    messageText: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Password not same as confirm password',
                                          style: TextStyle(
                                            fontFamily: "Roboto-Black",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: 0.8,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 27,
                                  fontFamily: 'Roboto-Black',
                                  fontWeight: FontWeight.w800),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto-Black',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/c');
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.zero,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.zero,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      letterSpacing: 0.8,
                                      fontSize: 18,
                                      fontFamily: 'Roboto-Black',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isEmailRegistered(String email) {
    return userController.registeredUsers.any((user) => user['email'] == email);
  }

  void saveRegisteredUsers() {
    box.write('registered_users', userController.registeredUsers);
  }

  void saveUserDetails(String name, String email, String password) {
    box.write('name', name);
    box.write('email', email);
    box.write('password', password);
  }

  void loadRegisteredUsers() {
    final registeredUsersData = box.read<List>('registered_users');
    if (registeredUsersData != null) {
      userController.registeredUsers = List<Map<String, String>>.from(
        registeredUsersData.map(
          (item) => Map<String, String>.from(item),
        ),
      ).obs;
    }
  }
}
