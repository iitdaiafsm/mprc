class AppConfig {
  static double DEFAULT_PADDING = 5;

  static List<Map<String, dynamic>> ConveyorOperations = [
    {"key": "conveyor_step_1", "value": "Tray present"},
    {"key": "conveyor_step_2", "value": "Conveyor started"},
    {"key": "conveyor_step_3", "value": "Stopper down"},
    {"key": "conveyor_step_4", "value": "Tray identified(RFID)"},
    {"key": "conveyor_step_5", "value": "Tray at the pickup point"},
    {"key": "conveyor_step_6", "value": "Conveyor stopped"}
  ];
  static List<Map<String, dynamic>> AssemblyOperations = [
    {"key": "assembly_step_1", "value": "Part picked from the tray"},
    {
      "key": "assembly_step_2",
      "value": "Part placed between clamping cylinders"
    },
    {"key": "assembly_step_3", "value": "Base Part clamped"},
    {"key": "assembly_step_4", "value": "Inspection done"},
    {"key": "assembly_step_5", "value": "First part placed"},
    {"key": "assembly_step_6", "value": "Second part placed"},
    {"key": "assembly_step_7", "value": "Screwing the parts"},
    {"key": "assembly_step_8", "value": "Screwing done"}
  ];
  static List<Map<String, dynamic>> TestingOperations = [
    {"key": "testing_step_1", "value": "Part placed"},
    {"key": "testing_step_2", "value": "Part clamped"},
    {"key": "testing_step_3", "value": "Testing cylinders extended"},
    {"key": "testing_step_4", "value": "Pneumatics On"},
    {"key": "testing_step_5", "value": "Part ok/Not ok"},
    {"key": "testing_step_6", "value": "Pneumatics off"}
  ];
  static List<Map<String, dynamic>> PackagingOperations = [
    {"key": "packaging_step_1", "value": "Part placed in the box"},
    {"key": "packaging_step_2", "value": "Box picked by the robot"},
    {"key": "packaging_step_3", "value": "Box flaps closed"},
    {"key": "packaging_step_4", "value": "Taping done"},
    {"key": "packaging_step_5", "value": "Printing done"}
  ];
}
