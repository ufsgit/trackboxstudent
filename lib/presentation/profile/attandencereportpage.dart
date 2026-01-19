import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  DateTime selectedMonth = DateTime.now();

  /// Dummy data (later filter by month)
  final attendanceList = [
    {"date": "01 Sep 2024", "status": "Present"},
    {"date": "02 Sep 2024", "status": "Absent"},
    {"date": "03 Sep 2024", "status": "Present"},
    {"date": "04 Sep 2024", "status": "Present"},
    {"date": "05 Sep 2024", "status": "Absent"},
  ];

  /// ================= MONTH PICKER =================
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
            Row(
              children: [
                _statCard(
                  title: "Present",
                  value: "3",
                  color: appTheme.green800,
                ),
                SizedBox(width: 12.v),
                _statCard(
                  title: "Absent",
                  value: "2",
                  color: appTheme.red400,
                ),
                SizedBox(width: 12.v),
                _statCard(
                  title: "Total",
                  value: "5",
                  color: appTheme.blue800,
                ),
              ],
            ),

            SizedBox(height: 20.v),

            /// ================= LIST TITLE =================
            Text(
              "Attendance Details",
              style: theme.textTheme.titleSmall,
            ),

            SizedBox(height: 12.v),

            /// ================= ATTENDANCE LIST =================
            ListView.builder(
              itemCount: attendanceList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = attendanceList[index];
                final isPresent = item["status"] == "Present";

                return Container(
                  margin: EdgeInsets.only(bottom: 8.v),
                  padding: EdgeInsets.all(12.v),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                    borderRadius: BorderRadius.circular(12.v),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.gray5005e,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPresent ? Icons.check_circle : Icons.cancel,
                        color: isPresent ? appTheme.green800 : appTheme.red400,
                      ),
                      SizedBox(width: 12.v),
                      Expanded(
                        child: Text(
                          item["date"]!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.v,
                          vertical: 6.v,
                        ),
                        decoration: BoxDecoration(
                          color: isPresent
                              ? appTheme.green800.withOpacity(0.1)
                              : appTheme.red400.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.v),
                        ),
                        child: Text(
                          item["status"]!,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color:
                                isPresent ? appTheme.green800 : appTheme.red400,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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
