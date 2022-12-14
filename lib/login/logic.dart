import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mprc/helper/firebase_helper.dart';
import 'package:mprc/helper/models/user_model.dart';
import 'package:mprc/helper/routes.dart';
import 'package:mprc/main.dart';

class LoginController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    prefs.getUser().then((value) {
      if (value.email != null) {
        Get.offAllNamed(Routes.DASHBOARD_PAGE);
      }
    });
    super.onInit();
  }

  Future<void> googleSignIn() async {
    isLoading = true;
    update();
    User? user = await FirebaseHelper.googleSignIn();
    if (user != null) {
      UserModel userModel = UserModel(
        email: user.email,
        name: user.displayName,
        lastLogin: DateTime.now().toString(),
      );
      await prefs.setUser(userModel);
      Get.offAllNamed(Routes.DASHBOARD_PAGE);
    }
    isLoading = false;
    update();
  }
}
