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
    videoAttendanceId = int.tryParse(json['VideoAttendance_ID']?.toString() ??
            json['videoAttendance_id']?.toString() ??
            json['id']?.toString() ??
            '') ??
        0;
    studentId = int.tryParse(json['Student_ID']?.toString() ??
            json['student_id']?.toString() ??
            '') ??
        0;
    courseId = int.tryParse(json['Course_ID']?.toString() ??
            json['course_id']?.toString() ??
            '') ??
        0;
    courseName =
        json['Course_Name'] ?? json['course_name'] ?? json['courseName'];
    contentId = int.tryParse(json['Content_ID']?.toString() ??
            json['content_id']?.toString() ??
            '') ??
        0;
    contentName =
        json['Content_Name'] ?? json['content_name'] ?? json['contentName'];
    watchedDate =
        json['Watched_Date'] ?? json['watched_date'] ?? json['watchedDate'];
    updateTime =
        json['Update_Time'] ?? json['update_time'] ?? json['updateTime'];
    deleteStatus = int.tryParse(json['Delete_Status']?.toString() ??
            json['delete_status']?.toString() ??
            '') ??
        0;
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
      final date = DateTime.parse(watchedDate!).toLocal();
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
