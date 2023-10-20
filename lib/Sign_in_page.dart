import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/user_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String registeredUserName = '';
  bool _obscurePassword = true;
  bool isLoggedIn = false;

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/a');
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
              colors: [Color(0xFF0C187A), Color(0xFF030F56), Color(0xFF019CDF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                          letterSpacing: 0.8,
                          fontFamily: 'Roboto-Black',
                          fontWeight: FontWeight.w800,
                          fontSize: 35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Welcome back! Login with your credentials',
                      style: TextStyle(
                        fontFamily: 'Roboto-Black',
                        fontSize: 15,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: myTextStyle,
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        labelStyle: myTextStyle,
                        hintStyle: myTextStyle,
                        enabledBorder: myEnabledBorder,
                        focusedBorder: myFocusedBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!value.endsWith('@gmail.com')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: myTextStyle,
                      obscureText: _obscurePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          color: Colors.white,
                          Icons.lock,
                          size: 25,
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
                        enabledBorder: myEnabledBorder,
                        focusedBorder: myFocusedBorder,
                        labelStyle: myTextStyle,
                        hintStyle: myTextStyle,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 8) {
                          return 'Minimum length required is 8 characters';
                        } else if (value.length > 14) {
                          return 'Maximum length allowed is 14 characters';
                        } else if (!RegExp(
                                r'^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          elevation: 10,
                          minimumSize: const Size(370, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            final enteredEmail = emailController.text;
                            final enteredPassword = passwordController.text;
                            bool isAuthenticated = await authenticateUser(
                                enteredEmail, enteredPassword);

                            if (isAuthenticated) {
                              Get.offAllNamed('/d');
                              userController.isLoggedIn = true;
                              box.write('isLoggedIn', userController.isLoggedIn);
                              Get.snackbar(
                                '',
                                '',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                borderRadius: 50.0,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                duration: const Duration(seconds: 3),
                                padding: const EdgeInsets.only(bottom: 25),
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                forwardAnimationCurve: Curves.easeOutBack,
                                reverseAnimationCurve: Curves.easeInBack,
                                messageText: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Welcome Back $registeredUserName',
                                      style: const TextStyle(
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
                              Get.snackbar(
                                '',
                                '',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                borderRadius: 50.0,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
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
                                      'Account not found',
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
                          'Login',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              letterSpacing: 0.8,
                              fontFamily: 'Roboto-Black'),
                        ),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "'Don't have an account'",
                          style: TextStyle(
                            fontFamily: 'Roboto-Black',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed('/b');
                          },
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.zero,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.zero,
                            child: Text(
                              '  Sign Up',
                              style: TextStyle(fontSize: 18),
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
    );
  }

  Future<bool> authenticateUser(String email, String password) async {
    for (var userData in userController.registeredUsers) {
      final storedEmail = userData['email'];
      final storedPassword = userData['password'];
      final storedName = userData['name'];

      if (storedEmail == email && storedPassword == password) {
        setState(() {
          registeredUserName = storedName ?? "";
        });

        box.write('name', registeredUserName);
        box.write('email', email);

        return true;
      }
    }
    return false;
  }


  void loadRegisteredUsers() {
    final registeredUsersData = box.read<List>('registered_users');
    if (registeredUsersData != null) {
      print('Registered users data: $registeredUsersData');
      userController.registeredUsers.value = List<Map<String, String>>.from(
        registeredUsersData.map((item) => Map<String, String>.from(item)),
      );
    }
  }
}
