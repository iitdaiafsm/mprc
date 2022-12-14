import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mprc/helper/models/inventory_model.dart';
import 'package:mprc/helper/models/progress_model.dart';

class FirebaseHelper {
  static String _COLLECTION = "MPRC";
  static final StreamController<ProgressModel> _progressStreamController =
      StreamController<ProgressModel>.broadcast();
  static final StreamController<InventoryModel> _inventoryStreamController =
      StreamController<InventoryModel>.broadcast();
  static final StreamController<Map<String, dynamic>>
      _operationsStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  static Map<String, dynamic> operationsMap = {
    "current_operation": "",
    "operations": {}
  };

  static Future<User?> googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId:
      //     '878248303999-dpcs51g9o0qbu10nvr0qfpdoaic89vco.apps.googleusercontent.com',
      scopes: <String>[
        'email',
      ],
    );

    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return authResult.user;
    }
    return null;
  }

  static Stream<ProgressModel> mprcProgress() {
    FirebaseFirestore.instance
        .collection(_COLLECTION)
        .doc("progress")
        .snapshots()
        .listen((event) {
      if (!_progressStreamController.isClosed) {
        _progressStreamController.sink
            .add(ProgressModel.fromJson(event.data() ?? {}));
      }
    });
    return _progressStreamController.stream;
  }

  /*



  static Stream<Map<String, dynamic>> operationsStream() {
    FirebaseFirestore.instance
        .collection(_COLLECTION)
        .doc("current_operation")
        .snapshots()
        .listen((event) {
      if (!_operationsStreamController.isClosed) {
        if (event.data() != null &&
            event.data()!["current_operation"] != null) {
          operationsMap["current_operation"] =
              event.data()!["current_operation"];
          _operationsStreamController.sink.add(operationsMap);
        }
        */ /*_operationsStreamController.sink
            .add({"current_operation": event.data()!["current_operation"]});*/ /*
      }
    });
    FirebaseFirestore.instance
        .collection(_COLLECTION)
        .doc("operations")
        .snapshots()
        .listen((event) {
      if (!_operationsStreamController.isClosed) {
        if (event.data() != null) {
          operationsMap["operations"] = event.data();
          _operationsStreamController.sink.add(operationsMap);
        }
        */ /*_operationsStreamController.sink
            .add({"operations": event.data() ?? {}});*/ /*
      }
    });
    return _operationsStreamController.stream;
  }*/
  static Stream<InventoryModel> inventoryStream() {
    return _inventoryStreamController.stream;
  }

  /*static Future<void> addDummyData() {
    var operations = {
      "conveyor_step_1": "2022-08-24 11:01:56.834474",
      "conveyor_step_2": "2022-08-24 11:01:57.846974",
      "conveyor_step_3": "2022-08-24 11:01:58.847450",
      "conveyor_step_4": "2022-08-24 11:01:59.847795",
      "conveyor_step_5": "2022-08-24 11:02:00.847795",
      "conveyor_step_6": "2022-08-24 11:02:02.847795",
      "assembly_step_1": "2022-08-24 11:02:03.847795",
      "assembly_step_2": "2022-08-24 11:02:05.847795",
      "assembly_step_3": "2022-08-24 11:02:08.847795",
      "assembly_step_4": "2022-08-24 11:02:10.847795",
      "assembly_step_5": "2022-08-24 11:02:11.847795",
      "assembly_step_6": "2022-08-24 11:02:12.847795",
      "assembly_step_7": "2022-08-24 11:02:13.847795",
      "assembly_step_8": "2022-08-24 11:02:14.847795",
      "testing_step_1": "2022-08-24 11:02:14.847795",
      "testing_step_2": "2022-08-24 11:02:15.847795",
      "testing_step_3": "2022-08-24 11:02:16.847795",
      "testing_step_4": "2022-08-24 11:02:17.847795",
      "testing_step_5": "2022-08-24 11:02:17.847795",
      "testing_step_6": "2022-08-24 11:02:18.847795",
      "packaging_step_1": "2022-08-24 11:02:18.847795",
      "packaging_step_2": "2022-08-24 11:02:19.847795",
      "packaging_step_3": "2022-08-24 11:02:20.847795",
      "packaging_step_4": "2022-08-24 11:02:22.847795",
      "packaging_step_5": "2022-08-24 11:02:24.847795",
    };

    var map = {
      "OrderID${DateTime.parse("2022-08-24 11:02:27.847795").millisecondsSinceEpoch}":
          operations
    };
    return FirebaseFirestore.instance
        .collection(_COLLECTION)
        .doc("orders")
        .set(map, SetOptions(merge: true));
  }*/

  static Stream<Map<String, dynamic>> streamOperations() {
    return _operationsStreamController.stream;
  }

  static void addStreamOperation(
      Map<String, dynamic> updatedMap, Map<String, dynamic> valueMap) {
    operationsMap["current_operation"] = updatedMap["current_operation"];
    if (valueMap[valueMap.keys.first].toString().contains("1970-01")) {
      valueMap[valueMap.keys.first] = "";
    }
    operationsMap["operations"][valueMap.keys.first] =
        valueMap[valueMap.keys.first];
    // Get.log("------ ${jsonEncode(operationsMap)}");
    _operationsStreamController.sink.add(operationsMap);
    _inventoryStreamController.sink
        .add(InventoryModel.fromJson(operationsMap["operations"]));
    calculateProgress(operationsMap["operations"]);
  }

  static Future<Map<String, dynamic>> readOrder() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection(_COLLECTION)
            .doc("orders")
            .get();

    return documentSnapshot.data() ?? <String, dynamic>{};
  }

  static void calculateProgress(Map<dynamic, dynamic> operationsMap) {
    double conveyorProgress = 0;
    double assemblyProgress = 0;
    double packageProgress = 0;
    List<int> conveyorList = [
      0,
      0,
      0,
      0,
      0,
      0,
    ];
    List<int> assemblyList = [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ];
    List<int> packageList = [
      0,
      0,
      0,
      0,
      0,
    ];

    var allKeys = operationsMap.keys;
    var conveyorKeys = allKeys
        .where((element) => element.toString().startsWith("conveyor_step_"));

    for (var i = 0; i < conveyorKeys.length; i++) {
      if (operationsMap["conveyor_step_${i + 1}"] != null &&
          operationsMap["conveyor_step_${i + 1}"].toString().isNotEmpty) {
        conveyorList[i] = 1;
      } else {
        conveyorList[i] = 0;
      }
    }
    var assemblyKeys = allKeys
        .where((element) => element.toString().startsWith("assembly_step_"));

    for (var i = 0; i < assemblyKeys.length; i++) {
      if (operationsMap["assembly_step_${i + 1}"] != null &&
          operationsMap["assembly_step_${i + 1}"].toString().isNotEmpty) {
        assemblyList[i] = 1;
      } else {
        assemblyList[i] = 0;
      }
    }
    var packageKeys = allKeys
        .where((element) => element.toString().startsWith("packaging_step_"));

    for (var i = 0; i < packageKeys.length; i++) {
      if (operationsMap["packaging_step_${i + 1}"] != null &&
          operationsMap["packaging_step_${i + 1}"].toString().isNotEmpty) {
        packageList[i] = 1;
      } else {
        packageList[i] = 0;
      }
    }

    var conveyorPro = conveyorList.where((element) => element == 1).length;
    var assemblyPro = assemblyList.where((element) => element == 1).length;
    var packagePro = packageList.where((element) => element == 1).length;
    conveyorProgress =
        conveyorProgress + ((conveyorPro / conveyorList.length) * 100);
    assemblyProgress =
        assemblyProgress + ((assemblyPro / assemblyList.length) * 100);
    packageProgress =
        packageProgress + ((packagePro / packageList.length) * 100);
    ProgressModel progressModel = ProgressModel(
        conveyorStation: conveyorProgress,
        assemblyStation: assemblyProgress,
        packagingStation: packageProgress,
        overall: ((conveyorProgress + assemblyProgress + packageProgress) / 3));

    _progressStreamController.sink.add(progressModel);
  }
}
