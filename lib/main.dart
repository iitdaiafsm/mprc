import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mprc/helper/prefs.dart';
import 'package:mprc/helper/theme_controller.dart';
import 'package:mprc/helper/theme_data.dart';

import 'firebase_options.dart';
import 'helper/routes.dart';

late Prefs prefs;
var currentRoute = Routes.DASHBOARD_PAGE;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  prefs = Prefs();
  var user = await prefs.getUser();
  if (user.email != null) {
    currentRoute = Routes.DASHBOARD_PAGE;
  } else {
    currentRoute = Routes.INITIAL_ROUTE;
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // FirebaseHelper.addDummyData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  ThemeController controller = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MPRC',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.DASHBOARD_PAGE,
      getPages: Routes.routes,
      theme: darkTheme,
      // home: DashboardPage(),
    );
  }
}
