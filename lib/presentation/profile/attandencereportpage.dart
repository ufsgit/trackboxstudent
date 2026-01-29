import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/utils/pref_utils.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/video_attendance_controller.dart';
import 'package:anandhu_s_application4/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  DateTime selectedMonth = DateTime.now();
  final VideoAttendanceController _controller =
      Get.put(VideoAttendanceController());

  @override
  void initState() {
    super.initState();
    _loadAttendance();
  }

  /// Load attendance data for selected month
  Future<void> _loadAttendance() async {
    final studentId = int.parse(PrefUtils().getStudentId());
    final monthStr =
        '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';
    await _controller.getVideoAttendanceByStudentId(studentId, month: monthStr);
  }

  /// Month picker
  Future<void> _pickMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: "Select Month",
    );

    if (picked != null) {
      setState(() {
        selectedMonth = DateTime(picked.year, picked.month);
      });
      _loadAttendance();
    }
  }

  String get monthText =>
      "${_monthName(selectedMonth.month)} ${selectedMonth.year}";

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Attendance Report",
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= MONTH SELECTOR =================
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.v, vertical: 12.v),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(12.v),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.gray5005e,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    monthText,
                    style: theme.textTheme.titleSmall,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: appTheme.blue800,
                    ),
                    onPressed: _pickMonth,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.v),

            /// ================= ATTENDANCE STATS =================
            // Obx(() {
            //   final attendanceList = _controller.videoAttendanceList;
            //   final presentCount =
            //       attendanceList.where((a) => a.status == "Present").length;
            //   final totalCount = attendanceList.length;

            //   return Row(
            //     children: [
            //       _statCard(
            //         title: "Present",
            //         value: "$presentCount",
            //         color: appTheme.green800,
            //       ),
            //       SizedBox(width: 12.v),
            //       _statCard(
            //         title: "Absent",
            //         value: "0",
            //         color: appTheme.red400,
            //       ),
            //       SizedBox(width: 12.v),
            //       _statCard(
            //         title: "Total",
            //         value: "$totalCount",
            //         color: appTheme.blue800,
            //       ),
            //     ],
            //   );
            // }),

            // SizedBox(height: 20.v),

            /// ================= LIST TITLE =================
            Text(
              "Attendance Details",
              style: theme.textTheme.titleSmall,
            ),

            SizedBox(height: 12.v),

            /// ================= ATTENDANCE LIST =================
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: appTheme.blue800,
                  ),
                );
              }

              if (_controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.v),
                    child: Text(
                      _controller.errorMessage.value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (_controller.videoAttendanceList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.v),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48.v,
                          color: appTheme.gray100,
                        ),
                        SizedBox(height: 16.v),
                        Text(
                          "No attendance records for this month",
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.v),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  borderRadius: BorderRadius.circular(12.v),
                  border: Border.all(
                    color: appTheme.gray10002,
                    width: 1,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      appTheme.gray10002,
                    ),
                    headingTextStyle: theme.textTheme.titleSmall,
                    dataTextStyle: theme.textTheme.bodySmall,
                    columnSpacing: 24,
                    columns: const [
                      DataColumn(label: Text('Content Name')),
                      DataColumn(label: Text('Course')),
                      DataColumn(label: Text('Date')),
                    ],
                    rows: _controller.videoAttendanceList.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              item.contentName ?? 'Video Content',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Text(
                              item.courseName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Text(item.formattedDate),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// ================= STAT CARD =================
  Widget _statCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.v),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.v),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.titleMedium!.copyWith(
                color: color,
              ),
            ),
            SizedBox(height: 4.v),
            Text(
              title,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
