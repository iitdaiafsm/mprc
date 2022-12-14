import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mprc/helper/models/user_model.dart';
import 'package:mprc/helper/routes.dart';

import '../main.dart';

class AppDrawerController extends GetxController {
  UserModel userModel = UserModel();
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getUserData() async {
    userModel = await prefs.getUser();
    update();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    await prefs.clearUser();
    Get.offAllNamed(Routes.INITIAL_ROUTE);
  }
}
