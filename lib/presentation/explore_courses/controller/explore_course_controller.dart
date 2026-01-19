import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/explore_courses/model/explore_course_model.dart';
import 'package:get/get.dart';
import '../../../http/http_request.dart';

class ExploreCourseController extends GetxController {
  var exploreCoursesList = <ExploreCoursesModel>[].obs;
  var displayedCourses = <ExploreCoursesModel>[].obs;
  var isLoading = true.obs;

  getAllExploreCourses() async {
    isLoading(true);
    exploreCoursesList.clear();
    displayedCourses.clear();
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getExploreCourses}',
    ).then((value) {
      if (value != null) {
        List data = value.data;
        print('explore course details $value');
        exploreCoursesList.value =
            data.map((e) => ExploreCoursesModel.fromJson(e)).toList();
        displayedCourses.value = List.from(exploreCoursesList);
      }
    });
    isLoading(false);
  }

  void filterCourses(String query) {
    if (query.isEmpty) {
      displayedCourses.value = List.from(exploreCoursesList);
    } else {
      displayedCourses.value = exploreCoursesList.where((course) {
        return course.courseName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void resetSearch() {
    displayedCourses.value = List.from(exploreCoursesList);
  }

  @override
  void onClose() {
    resetSearch();
    super.onClose();
  }
}
