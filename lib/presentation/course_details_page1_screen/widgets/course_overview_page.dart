import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:flutter/material.dart';

class CourseOverviewPage extends StatefulWidget {
  final String description;
  CourseOverviewPage({super.key, required this.description});

  @override
  State<CourseOverviewPage> createState() => _CourseOverviewPageState();
}

HomeController controllerCourseDetailsController =
    Get.put(HomeController(HomeModel().obs));

class _CourseOverviewPageState extends State<CourseOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return widget.description != ''
        ? SingleChildScrollView(child: _buildLearningOutcomesColumn())
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height / 4.5),
                Text('No overview'),
              ],
            ),
          );
  }

  Widget _buildLearningOutcomesColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "msg_what_you_ll_learn".tr,
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
        SizedBox(height: 6.v),
        Text(widget.description),
      ],
    );
  }

  Widget _buildCourseOverviewRow() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(right: 36.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_4".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_weeks".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Spacer(flex: 53),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_56".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_classes".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Spacer(flex: 46),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_56".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "Resources".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 26.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lbl_14".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 1.v),
                  Text(
                    "lbl_tests".tr,
                    style: CustomTextStyles.labelLargeBluegray500Medium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
