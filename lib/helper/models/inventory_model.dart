class InventoryModel {
  String? robotStatus;
  String? toolChanger;
  int? tray1 = 1;
  int? tray2;
  int? tray3;
  int? tray4;
  int? powerStatus;

  InventoryModel({
    this.robotStatus,
    this.toolChanger,
    this.tray1 = 1,
    this.tray2,
    this.tray3,
    this.tray4,
    this.powerStatus,
  });

  InventoryModel.fromJson(Map<dynamic, dynamic> json) {
    robotStatus = json['robot_status'];
    toolChanger = json['tool_changer'];
    powerStatus = json['MPRC_power_on'];
    if (json['tray_1'] != null) tray1 = int.parse("${json['tray_1']}");
    if (json['tray_2'] != null) tray2 = int.parse("${json['tray_2']}");
    if (json['tray_3'] != null) tray3 = int.parse("${json['tray_3']}");
    if (json['tray_4'] != null) tray4 = int.parse("${json['tray_4']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['robot_status'] = robotStatus;
    data['tool_changer'] = toolChanger;
    data['MPRC_power_on'] = powerStatus;
    data['tray_1'] = tray1;
    data['tray_2'] = tray2;
    data['tray_3'] = tray3;
    data['tray_4'] = tray4;
    return data;
  }
}
