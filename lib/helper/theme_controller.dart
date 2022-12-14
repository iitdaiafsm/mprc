import 'package:get/get.dart';
import 'package:mprc/helper/theme_data.dart';
import 'package:mprc/main.dart';

class ThemeController extends GetxController {
  bool isLightTheme = false;
  @override
  void onInit() {
    getTheme();
    super.onInit();
  }

  void getTheme() async {
    isLightTheme = await prefs.getTheme();
    Get.changeTheme(isLightTheme ? lightTheme : darkTheme);
    update();
  }

  void setTheme(bool value) async {
    isLightTheme = value;
    prefs.setTheme(isLightTheme);
    Get.changeTheme(isLightTheme ? lightTheme : darkTheme);
    update();
  }
}
