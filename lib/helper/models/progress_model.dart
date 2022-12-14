class ProgressModel {
  double? conveyorStation;
  double? assemblyStation;
  // double? testingStation;
  double? packagingStation;
  double? overall;

  ProgressModel({
    this.conveyorStation,
    this.assemblyStation,
    // this.testingStation,
    this.packagingStation,
    this.overall,
  });

  ProgressModel.fromJson(Map<String, dynamic> json) {
    conveyorStation = double.parse("${json['conveyor_station']}");
    assemblyStation = double.parse("${json['assembly_station']}");
    // testingStation = double.parse("${json['testing_station']}");
    packagingStation = double.parse("${json['packaging_station']}");
    overall = double.parse("${json['overall']}");
    // overall = ((conveyorStation ?? 0) +
    //         (assemblyStation ?? 0) +
    //         (packagingStation ?? 0)) /
    //     3;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conveyor_station'] = conveyorStation;
    data['assembly_station'] = assemblyStation;
    // data['testing_station'] = testingStation;
    data['packaging_station'] = packagingStation;
    data['overall'] = overall;
    return data;
  }
}
