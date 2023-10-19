import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Sign_Up_Page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final box = GetStorage();
  var userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
  }

  Future<void> logOut(BuildContext context) async {
    Get.offNamed('/a');
  }

  Future<void> clearCredentials(BuildContext context,
      {required bool deleteAccount}) async {
    final String currentUserEmail = box.read('email');
    final List<Map<String, String>> registeredUsersData =
    List<Map<String, String>>.from(box.read<List>('registered_users') ?? []);

    if (deleteAccount) {
      box.remove('name');
      box.remove('email');
      final updatedRegisteredUsers = registeredUsersData
          .where((user) => user['email'] != currentUserEmail)
          .toList();
      box.write('registered_users', updatedRegisteredUsers);
      final updatedUserList = userController.registeredUsers.value
          .where((user) => user['email'] != currentUserEmail)
          .toList();
      userController.registeredUsers.value = updatedUserList;
    }
    print(userController.registeredUsers);
    Get.offAllNamed('/a');
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
            onPressed: () {},
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
    print('Registered users data: $registeredUsersData');
    userController.registeredUsers.value = List<Map<String, String>>.from(
      registeredUsersData.map((item) => Map<String, String>.from(item)),
    );
  }
}
}