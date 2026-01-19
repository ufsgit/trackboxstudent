class TimeSlotModel {
  int? slotId;
  String? startTime;
  String? endTime;

  TimeSlotModel({this.slotId, this.startTime, this.endTime});

  TimeSlotModel.fromJson(Map<String, dynamic> json) {
    slotId = json['Slot_Id'] ?? 0;
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Slot_Id'] = this.slotId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
