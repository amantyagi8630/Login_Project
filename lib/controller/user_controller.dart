import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  var registeredUsers = <Map<String, String>>[].obs;
  bool isLoggedIn = false;

  void addUser(Map<String, String> user) {
    registeredUsers.add(user);
  }

  void checkLoggedInStatus() {
    final box = GetStorage();
    isLoggedIn = box.read('isLoggedIn') ?? false;
  }
}
