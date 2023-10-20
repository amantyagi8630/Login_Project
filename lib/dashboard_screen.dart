import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/user_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final box = GetStorage();
  var userController = Get.put(UserController());

  void updateRegisteredUsersList(List<Map<String, String>> updatedList) {
    box.write('registered_users', updatedList);
    userController.registeredUsers.value = updatedList;
  }

  void deleteAccount(Map<String, String> userData) {
    List<Map<String, String>> updatedList =
        List<Map<String, String>>.from(userController.registeredUsers);
    updatedList.remove(userData);
    updateRegisteredUsersList(updatedList);
  }

  void clearCredentials(BuildContext context,
      {required bool deleteAccount}) async {
    final String currentUserEmail = box.read('email') ?? '';
    final List<Map<String, String>> registeredUsersData =
        List<Map<String, String>>.from(
            box.read<List>('registered_users') ?? []);

    if (deleteAccount) {
      box.remove('name');
      box.remove('email');
      final updatedRegisteredUsers = registeredUsersData
          .where((user) => user['email'] != currentUserEmail)
          .toList();
      box.write('registered_users', updatedRegisteredUsers);
      userController.registeredUsers.value = updatedRegisteredUsers;
    }
    Get.offAllNamed('/a');
  }

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    loadRegisteredUsers();
  }

  Future<void> logOut(BuildContext context) async {
    Get.offNamed('/a');
  }

  void showDeleteConfirmationDialog(
    Function(Map<String, String> userData) deleteFunction,
    Map<String, String> userData,
  ) {
    String enteredPassword = '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0C187A),
                        Color(0xFF030F56),
                        Color(0xFF019CDF),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 250,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Confirm Deletion',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                          ),
                          obscureText: false,
                          onChanged: (value) {
                            enteredPassword = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(5),
                                  side: MaterialStateProperty.resolveWith<
                                      BorderSide>(
                                    (Set<MaterialState> states) {
                                      return const BorderSide(
                                          color: Colors.blue, width: 2);
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                                        (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      );
                                    },
                                  ),
                                ),

                                onPressed: () {
                                  if (enteredPassword == userData['password']) {
                                    deleteFunction(userData);
                                    Navigator.of(context).pop();
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
                                            'Account removed',
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
                                            'Please enter correct password',
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
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  void showRegisteredUsersDialog(BuildContext context) {
    String currentEmail = box.read('email') ?? '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0C187A),
                      Color(0xFF030F56),
                      Color(0xFF019CDF),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 300,
                child: ListView.builder(
                  itemCount: userController.registeredUsers.length,
                  itemBuilder: (context, index) {
                    final user = userController.registeredUsers[index];
                    if (user['email'] != currentEmail) {
                      return ListTile(
                        title: Text(
                          user['name'] ?? 'No Name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Roboto-Black',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Adjust the alignment as needed
                            children: [
                              Text(
                                user['email'] ?? 'No Email',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 16,
                                  fontFamily: 'Roboto-Black',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 27,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDeleteConfirmationDialog(
                                    (userData) {
                                      deleteAccount(userData);
                                      Get.back();
                                      setState(() {
                                        userController.registeredUsers
                                            .remove(userData);
                                      });
                                    },
                                    userController.registeredUsers[index],
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(); // return an empty container if it's the current user
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'My Da',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 28,
                  fontFamily: 'Roboto-Black',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'shb',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Roboto-Black',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'oard',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 28,
                  fontFamily: 'Roboto-Black',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: AssetImage('Images/rocket-launch.png'),
            ),
            onPressed: () {
              showRegisteredUsersDialog(context);
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0C187A),
                Color(0xFF030F56),
                Color(0xFF019CDF),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  box.read('name') ?? 'Your Name',
                  style: const TextStyle(fontSize: 20),
                ),
                accountEmail: Text(
                  box.read('email') ?? 'your@gmail.com',
                  style: const TextStyle(fontSize: 18),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('Images/rocket-launch.png'),
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: const Text('Dashboard',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto-Black',
                        fontWeight: FontWeight.w600,
                        color: Colors.green)),
                onTap: () {
                  Get.back();
                },
              ),
              Expanded(
                child: Container(),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto-Black',
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
                onTap: () {
                  userController.isLoggedIn = false;
                  box.write('isLoggedIn', userController.isLoggedIn);
                  logOut(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                title: const Text(
                  'Delete Account',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto-Black',
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
                onTap: () {
                  userController.isLoggedIn = false;
                  box.write('isLoggedIn', userController.isLoggedIn);
                  clearCredentials(context, deleteAccount: true);
                },
              ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0C187A),
              Color(0xFF030F56),
              Color(0xFF019CDF),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }

  void loadRegisteredUsers() {
    final registeredUsersData = box.read<List>('registered_users');
    if (registeredUsersData != null) {
      List<Map<String, String>> registeredUsers = [];
      for (var item in registeredUsersData) {
        Map<String, String> userMap = {};
        item.forEach((key, value) {
          userMap[key] = value.toString();
        });
        registeredUsers.add(userMap);
      }
      print('Registered users data: $registeredUsers');
      userController.registeredUsers.value = registeredUsers;
    }
  }
}
