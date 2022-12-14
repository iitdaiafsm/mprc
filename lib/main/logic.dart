import 'dart:convert';

import 'package:get/get.dart';
import 'package:mprc/app_drawer/controller.dart';
import 'package:mprc/helper/firebase_helper.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MainController extends GetxController {
  late AppDrawerController appDrawerController;
  String broker = '10.226.52.169';
  int port = 1883;
  String username = 'test';
  String passwd = 'test';
  String topic = '#';
  String clientIdentifier = 'web';
  late MqttServerClient client;

  Map<String, dynamic> operationsMap = {
    "conveyor_step_1": "",
    "conveyor_step_2": "",
    "conveyor_step_3": "",
    "conveyor_step_4": "",
    "conveyor_step_5": "",
    "conveyor_step_6": "",
    "assembly_step_1": "",
    "assembly_step_2": "",
    "assembly_step_3": "",
    "assembly_step_4": "",
    "assembly_step_5": "",
    "assembly_step_6": "",
    "assembly_step_7": "",
    "assembly_step_8": "",
    "testing_step_1": "",
    "testing_step_2": "",
    "testing_step_3": "",
    "testing_step_4": "",
    "testing_step_5": "",
    "testing_step_6": "",
    "packaging_step_1": "",
    "packaging_step_2": "",
    "packaging_step_3": "",
    "packaging_step_4": "",
    "packaging_step_5": ""
  };

  @override
  void onInit() {
    appDrawerController = Get.put(AppDrawerController());
    FirebaseHelper.streamOperations().listen((event) {
      Get.log("Data Changed : ${jsonEncode(event)}");
    });
    connect();
    super.onInit();
  }

  Future<int> connect() async {
    client = MqttServerClient(broker, clientIdentifier);
    client.websocketProtocols = ['mqtt'];
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.port = port;

    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;
    final connMess = MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    /*Get.log('EXAMPLE::Mosquitto client connecting....');*/
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
      return -1;
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      /*Get.log('EXAMPLE::Mosquitto client connected');*/
    } else {
      /// Use status here rather than state if you also want the broker return code.
      /*Get.log(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');*/
      client.disconnect();
      return -1;
    }

    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      /// The above may seem a little convoluted for users only interested in the
      /// payload, some users however may be interested in the received publish message,
      /// lets not constrain ourselves yet until the package has been in the wild
      /// for a while.
      /// The payload is a byte buffer, this will be specific to the topic
      /* Get.log(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      */

      var filteredStr = pt
              .replaceAll(
                  "SIMATIC/S7-1500/OPC-UA/Application:PLC_1|Objects|DeviceSet|PLC_1|DataBlocksGlobal|string|",
                  '')
              .replaceAll('|', '')
              .replaceAll('/', '')
              .replaceAll(
                  "SIMATICS7-1500OPC-UAApplication:PLC_1ObjectsDeviceSetPLC_1Memory",
                  '')
              .replaceAll(
                  "SIMATICS7-1500OPC-UAApplication:PLC_1ObjectsDeviceSetPLC_1Inputs",
                  '')
              .replaceAll("(RFID)", '')
          /*.replaceAll(':', ': "')
          .replaceAll('}', '"}')
          .replaceAll('""', '')
          .removeAllWhitespace
          .toLowerCase()*/
          ;

      /*if (filteredStr.contains("idle")) {

      }*/
      Map<String, dynamic> myMap;
      try {
        myMap = jsonDecode(filteredStr);
      } catch (e) {
        filteredStr = filteredStr
            .replaceAll(': ', ': "')
            .replaceAll('}', '"}')
            .replaceAll('""', '')
            .removeAllWhitespace
            .toLowerCase();
        myMap = jsonDecode(filteredStr);
      }

      if (operationsMap[myMap.keys.first] != myMap[myMap.keys.first]) {
        operationsMap[myMap.keys.first] = myMap[myMap.keys.first];
        FirebaseHelper.addStreamOperation(
            {"current_operation": myMap.keys.first}, myMap);
      }
    });

    client.published!.listen((MqttPublishMessage message) {
      /*Get.log(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');*/
    });
    return 0;
  }

  void onSubscribed(String topic) {
    /*Get.log('EXAMPLE::Subscription confirmed for topic $topic');*/
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    /*Get.log('EXAMPLE::OnDisconnected client callback - Client disconnection');*/
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      /*Get.log('EXAMPLE::OnDisconnected callback is solicited, this is correct');*/
    }
  }

  /// The successful connect callback
  void onConnected() {
    /*Get.log(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');*/
  }

  /// Pong callback
  void pong() {
    /*Get.log('EXAMPLE::Ping response client callback invoked');*/
  }
}
