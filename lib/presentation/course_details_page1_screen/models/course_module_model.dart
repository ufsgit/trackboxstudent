class CourseModuleModel {
  int moduleId;
  String moduleName;
  int deleteStatus;
  int enabledStatus;
  int lockedStatus;

  CourseModuleModel({
    required this.moduleId,
    required this.moduleName,
    required this.deleteStatus,
    required this.enabledStatus,
    required this.lockedStatus,
  });

  factory CourseModuleModel.fromJson(Map<String, dynamic> json) =>
      CourseModuleModel(
        moduleId: json["Module_ID"],
        moduleName: json["Module_Name"],
        deleteStatus: json["Delete_Status"],
        enabledStatus: json["Enabled_Status"],
        lockedStatus: json["locked_Status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "Module_ID": moduleId,
        "Module_Name": moduleName,
        "Delete_Status": deleteStatus,
        "Enabled_Status": enabledStatus,
        "locked_Status": lockedStatus,
      };
}
