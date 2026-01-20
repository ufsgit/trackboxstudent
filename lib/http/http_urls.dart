class HttpUrls {
  // static String baseUrl = 'http://DESKTOP-IK6ME8M:3520';
  // static String baseUrl = 'https://2766-103-141-56-75.ngrok-free.app';
  static String baseUrl = 'https://rw4vb3zj-3520.inc1.devtunnels.ms'; //og
//   static String baseUrl = 'https://igmapi.ufstech.co.in'; //og
  // static String baseUrl = 'https://funny-nicely-rodent.ngrok-free.app';
  static String chatBaseUrl = baseUrl + "/chatbot";
  static String imgBaseUrl =
      'https://ufsnabeelphotoalbum.s3.us-east-2.amazonaws.com/';

  // static String imgUploadBaseUrl =
  //     'https://darlsco-files.s3.ap-south-1.amazonaws.com';

  // static String baseUrl = 'https://brifni`api.ufstech.in';
  // static String baseUrl = 'http://13.232.244.184:3520';
  // static String baseUrl = 'https://54s06fdp-3520.inc1.devtunnels.ms';
  // static String tokenTwo =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTQ2MzkwMDl9.61ZUMX6zMu470Yn7UMACN1vjPOmsKxX_70l7ii6TJks';
  // static String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTQ2NDE4ODB9.njRYMm1dx4dba-YawBt2P9X51no5YcuXGEI_IXbZOQU";

  //endpoints

  static String userLogin = '/Student_Login_Check';

  static String googleSignIn = '/Login/Google_SignIn';

  static String checkOtp = '/Login/Check_OTP';

  static String saveProfile = '/student/Save_student';

  static String getOccupations = '/student/Search_Occupations';

  static String getSpecificCourseDetails = '/student/GetAllCourses';

  static String saveOccupation = '/student/Save_Occupation';
  static String getCourseDetails = '/course/Get_course';

  //get all explore courses
  static String getExploreCourses = '/Search_course';
  //search explore courses
  static String getSearchExploreCourses = '/Search_course?course_Name=';

  static String enrollCourse = '/student/enroleCourse';
  static getCourseTimeSlots(courseID) => '/course/Get_All_Time_Slot/$courseID';
  static String getCourseReviews = '/course/Get_Course_Reviews';

  static String getStudent = '/student/Get_student';
  static String getSpecificExamDetailsStudent =
      '/course/Get_Specific_Exam_Details';

//Student my courses
  static String getMyCourseDetails(String studentId) =>
      '/student/Get_Courses_By_StudentId/$studentId';
  static String getMyCourseSearchByName = '?course_Name=';
  //live class for my courses
  static String checkMyCourseLiveNow = '/student/Get_Live_Classes_By_CourseId/';
  static String startStudentLiveClass = '/user/Save_StudentLiveClass';

  static String getCourseTeachers = '/teacher/Get_courses/';
  static String getCourseStudent = '/user/get_chat_call_history';
  static String editTeacher = '/teacher/Edit_profile';
  static String gettAllCourses = '/student/GetAllCourses/';
  static String getCourseEachStudent = '/user/get_chat_call_history';

  static String getItemCart = '/cart';
  static String chatCallModel = '/user/Get_Calls_And_Chats_List';
  static String saveStudentCall = '/user/Save_Call_History';
  static String getTeacher = '/user/Search_User/';
  static String getHod = "/student/Get_Available_Hod";
  static String getAvailableMentors = "/student/Get_Available_Mentors";
  static String getStudentChatLog =
      "/user/Get_Calls_And_Chats_List?type=chat&sender=student&studentId=";
  static String getOngoingCalls = "/user/Get_Ongoing_Calls";
  static String getPaymentHistory = "/student/Get_Courses_By_StudentId";
  static String checkStudentEnrolnment = "/student/CheckStudentEnrollment";
  // static String courseContent = "/course/Get_course";
  static String courseContent = "/course/Get_course_content_By_Module/";
  static String courseContentLibrary = '/course/Get_course_content';
  static String getCourseModules = '/course/Get_Course_Module';
  static String getCourseInfo = '/course/Get_Course_Info';
  static String getBatchDays = "/Batch/Get_Batch_Days";
  static String getCoursesModules = '/course/Get_Module_Of_Course';
  static String getSecttionsByCourse = "/course/Get_Sections_By_Course";
  static String getCourseContentByDay = '/course/Get_course_content_By_Day';
  static String checkVersion = "/Check_App_Version";
  static String getRecordings = "/course/Get_Student_ClassRecords";
  static String getExamDays = "/course/Get_Exam_Days_By_Module";
  static String getModulesofMockTests = "/course/Get_Exam_Modules_By_CourseId";
  static String deleteAccount = "/student/Delete_Student_Account";
  static String getExamResult = '/student/Get_Student_Exam_Results/';
  static String saveStudentLiveData = '/user/Save_StudentLiveClass';
  static String checkCallAvailability = '/user/Check_Call_Availability';
  static String submitFeedBack = '/course/review_course';
  static String Update_LastAccessed_Content =
      '/course/Update_LastAccessed_Content';
  static String Update_Call_Status_Accept =
      '/user/Update_Call_Status?newStatus=1&type=connect&callId=';
  static String Update_Call_Status_Failed =
      '/user/Update_Call_Status?newStatus=1&type=call&callId=';
  static String initiateJuspayPayment = '/payment/initiateJuspayPayment';

// GET exams by course ID
// ================= EXAMS =================

  static String getStudentExamsByCourse(String courseId) =>
      '/course/Student_GetExams/$courseId';

  static String getStudentQuestionsByCourseExam(String courseExamId) =>
      '/course/Student_GetQuestions/$courseExamId';
}
