import 'dart:developer';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/exam_inner_screen.dart';

import '../../../http/http_request.dart';
import '../../../http/http_urls.dart';
import '../models/specific_exam_details_model.dart';

class ExamDetailsScreenController extends GetxController {
  RxInt audioPlayerLoopTime = 0.obs;
  RxBool isPlaying = false.obs;
  List<SpecificExamDetailsModel> specificExamDetailsList = [];

  getExamDetails({required int examId}) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getSpecificExamDetailsStudent}/$examId',
    ).then((value) async {
      if (value != null) {
        log('examDetails details data $value');

        List data = value.data;

        specificExamDetailsList =
            data.map((e) => SpecificExamDetailsModel.fromJson(e)).toList();

        log(specificExamDetailsList[0].examDetails.mainQuestion);
        if (specificExamDetailsList.isNotEmpty) {
          await Get.to(() => ExamInnerPageScreen());
        }

        // Get.toNamed(AppRoutes.writingTestQuestionScreen);
      }
    });

    update();
  }
}
