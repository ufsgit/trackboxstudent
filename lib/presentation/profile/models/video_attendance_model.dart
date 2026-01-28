class VideoAttendanceModel {
  int? videoAttendanceId;
  int? studentId;
  int? courseId;
  String? courseName;
  int? contentId;
  String? contentName;
  String? watchedDate;
  String? updateTime;
  int? deleteStatus;

  VideoAttendanceModel({
    this.videoAttendanceId,
    this.studentId,
    this.courseId,
    this.courseName,
    this.contentId,
    this.contentName,
    this.watchedDate,
    this.updateTime,
    this.deleteStatus,
  });

  VideoAttendanceModel.fromJson(Map<String, dynamic> json) {
    videoAttendanceId = json['VideoAttendance_ID'];
    studentId = json['Student_ID'];
    courseId = json['Course_ID'];
    courseName = json['Course_Name'];
    contentId = json['Content_ID'];
    contentName = json['Content_Name'];
    watchedDate = json['Watched_Date'];
    updateTime = json['Update_Time'];
    deleteStatus = json['Delete_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VideoAttendance_ID'] = videoAttendanceId;
    data['Student_ID'] = studentId;
    data['Course_ID'] = courseId;
    data['Course_Name'] = courseName;
    data['Content_ID'] = contentId;
    data['Content_Name'] = contentName;
    data['Watched_Date'] = watchedDate;
    data['Update_Time'] = updateTime;
    data['Delete_Status'] = deleteStatus;
    return data;
  }

  // Helper to get formatted date
  String get formattedDate {
    if (watchedDate == null) return '';
    try {
      final date = DateTime.parse(watchedDate!);
      return '${date.day.toString().padLeft(2, '0')} ${_getMonthName(date.month)} ${date.year}';
    } catch (e) {
      return watchedDate!;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  // Status is always "Present" if record exists
  String get status => 'Present';
}
