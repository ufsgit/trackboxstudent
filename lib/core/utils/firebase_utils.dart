import 'dart:async';

import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/FirebaseCallModel.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/notification_service.dart';
import 'package:anandhu_s_application4/core/utils/pref_utils.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/current_call_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/save_student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../presentation/android_large_5_page/incoming_call_page.dart';
import '../../presentation/chat_screen/controller/chat_firebase_controller.dart';

class FirebaseUtils {
  static String callAccepted = "accepted";
  static String callRinging = "ringing";
  static StreamSubscription<DocumentSnapshot>? _callListener;
  static StreamSubscription<QuerySnapshot>?
      _callsSubscription; // Store subscription

  static String getDocId(String teacherId) {
    String docId =
        "STD-" + PrefUtils().getStudentId() + "-" + "TCR-" + teacherId;

    return docId;
  }

  static saveCall(String teacherId, String teacherName, String callId,
      SaveStudentCallModel saveStudentCallModel) async {
    // String docId="STD-"+PrefUtils().getStudentId()+"/"+"TCR-"+teacherId;
    await FirebaseFirestore.instance
        .collection('calls')
        .doc(getDocId(teacherId))
        .set({
      "id": callId,
      "teacher_id": teacherId,
      "teacher_name": teacherName,
      "student_id": PrefUtils().getStudentId(),
      "student_name": PrefUtils().getStudentName(),
      "call_start": DateTime.now().toUtc().toString(),
      "call_end": saveStudentCallModel.callEnd,
      "call_duration": null,
      "call_type": saveStudentCallModel.callType,
      "Is_Student_Called": 1,
      "Live_Link": saveStudentCallModel.liveLink,
      "profile_url": saveStudentCallModel.profileUrl,
      "call_status": callRinging,
      "updated_on": DateTime.now().toUtc(),
      "type": "new_call",
    });
    // await FirebaseFirestore.instance
    //     .collection('calls').doc("TCR-"+teacherId)
    //     .set({
    //   "id": callId,
    //   "teacher_id": teacherId,
    //   "teacher_name": teacherName,
    //   "student_id": PrefUtils().getStudentId(),
    //   "student_name": PrefUtils().getStudentName(),
    //   "call_start": DateTime.now().toString(),
    //   "call_end": saveStudentCallModel.callEnd,
    //   "call_duration": null,
    //   "call_type": saveStudentCallModel.callType,
    //   "Is_Student_Called": 1,
    //   "Live_Link": saveStudentCallModel.liveLink,
    //   "profile_url": saveStudentCallModel.profileUrl
    // });
  }

  static updateCallStatus(String teacherId, String callStatus) async {
    // String docId="STD-"+PrefUtils().getStudentId()+"/"+"TCR-"+teacherId;
    await FirebaseFirestore.instance
        .collection('calls')
        .doc(getDocId(teacherId))
        .update(
            {"call_status": callStatus, "updated_on": DateTime.now().toUtc()});
  }

  // static deleteStudentTeacherCalls(String callId) async {
  //   // String docId="STD-"+studentId+"/"+"TCR-"+teacherId;
  //
  //   // deleting calls which is started from teacher and teacher not ended or app closed (which is not delete from firebase )
  //   await FirebaseFirestore.instance
  //       .collection("calls")
  //       .doc(callId)
  //       .delete();
  //
  // }
  static Future<bool> isAnyCallExists() async {
    try {
      final CallandChatController callandChatController =
          Get.find<CallandChatController>();

      // Query the collection for documents where student_id matches
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('calls')
          .where('student_id', isEqualTo: PrefUtils().getStudentId())
          .limit(1) // Limit to 1 since we only need to know if it exists
          .get();

      if (result.docs.isEmpty) {
        callandChatController.currentCallModel.value = CurrentCallModel();
      }
      // If there are any documents in the result, the student_id exists
      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error checking student ID: $e');
      return false; // Return false in case of error
    }
  }

  static Future<bool> checkForRecentCallWithSameTeacher(
      String teacherId) async {
    // Calculate timestamp from 20 seconds ago
    DateTime twentySecondsAgo =
        DateTime.now().toUtc().subtract(Duration(seconds: 30));

    try {
      // Get the specific document
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('calls')
          .doc(getDocId(teacherId))
          .get();

      // Check if document exists and meets our conditions
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        DateTime updatedOn = (data['updated_on'] as Timestamp).toDate();

        return updatedOn.isAfter(twentySecondsAgo);
      }

      return false;
    } catch (e) {
      print('Error checking for recent calls: $e');
      return false;
    }
  }

  static deleteStudentInactiveCalls() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String studentId = preferences.getString('breffini_student_id') ?? '';

    try {
      // Query all documents where id = 50
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("calls")
          .where('student_id', isEqualTo: studentId)
          .get();

      // Delete each matching document
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        print('Deleted document with ID: ${doc.id}');
      }

      // print('Successfully deleted ${querySnapshot.docs.length} documents with id 50');
    } catch (e) {
      print('Error deleting documents: $e');
    }
  }

  static deleteCall(String teacherId, String sss) async {
    String docId = getDocId(teacherId);

    try {
      await FirebaseFirestore.instance.collection("calls").doc(docId).delete();
    } catch (e) {
      print('Error deleting documents: $e');
    }
    Get.put(ChatFireBaseController()).updateLog(
        "Deleted call" +
            "_STD" +
            PrefUtils().getStudentId() +
            "_route=" +
            Get.currentRoute,
        sss);
    // await FirebaseFirestore.instance
    //     .collection("calls")
    //     .doc("STD-"+PrefUtils().getStudentId())
    //     .delete();
    // await FirebaseFirestore.instance
    //     .collection("calls")
    //     .doc("TCR-"+teacherId)
    //     .delete();
  }

  static Future<bool> checkIfCallExists(String teacherId, String callId) async {
    // Create the document reference with the dynamic ID
    final documentReference =
        FirebaseFirestore.instance.collection("calls").doc(getDocId(teacherId));

    try {
      // Fetch the document once
      final documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // DocumentSnapshot data = documentSnapshot.data() as Map<String, dynamic>;
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Use fromMap instead of fromSnapshot
        FirebaseCallModel callModel = FirebaseCallModel.fromMap(data);

        print("Document exists with data: ${documentSnapshot.data()}");
        return callModel.id == callId;
      } else {
        print("Document does not exist.");
        return false;
      }
    } catch (e) {
      print("Error checking document existence: $e");
      return false;
    }
  }

  static listenCalls() async {
    if (null != _callsSubscription) {
      _callsSubscription?.cancel();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String studentId = preferences.getString('breffini_student_id') ?? '';
    CallandChatController callChatController = getCallChatController();

    _callsSubscription = FirebaseFirestore.instance
        .collection("calls")
        .where('student_id', isEqualTo: studentId)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) async {
      List<dynamic> activeCalls = await FlutterCallkitIncoming.activeCalls();

      // Check if there are any documents in the snapshot
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>;

        List<FirebaseCallModel> fireBaseCallList = querySnapshot.docs
            .map((doc) =>
                FirebaseCallModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        // FirebaseCallModel callModel = FirebaseCallModel.fromMap(data);

        // Check for active calls
        bool showCall = true;

        for (FirebaseCallModel model in fireBaseCallList) {
          // case whn new call and ring not shown

          if (model.callStatus == FirebaseUtils.callRinging &&
              !model.isStudentCalled!) {
            bool hasAlreadyRinging =
                activeCalls.any((call) => call["id"] == model.id);
            bool isLocalAccepted = activeCalls
                .any((call) => call["id"] == model.id && call['accepted']);
            if (!hasAlreadyRinging && !isLocalAccepted) {
              Future.delayed(Duration(seconds: 1), () async {
                // added this delay to handle (when app killed and firebase default notification arrive.
                //so default notification showing over call ring dialog fix// )
                if (callChatController.currentCallModel.value.callId
                        .isNullOrEmpty() ||
                    callChatController.currentCallModel.value.callId !=
                        model.id) {
                  DateTime sendTime = DateTime.parse(model.callStart!).toUtc();
                  DateTime arrivalTime = DateTime.now().toUtc();

                  int delayInSeconds =
                      arrivalTime.difference(sendTime).inSeconds;

                  if (delayInSeconds <= 50) {
                    await showCallkitIncoming(
                        model.id ?? '',
                        model.teacherName ?? '',
                        model.profileUrl ?? '',
                        model.callType ?? '',
                        model.toJson(),
                        false);
                  } else {
                    await showCallkitIncoming(
                        model.id ?? '',
                        model.studentName ?? '',
                        model.profileUrl ?? '',
                        model.callType ?? '',
                        model.toJson(),
                        true);
                  }
                }
              });
              // final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
              // List<ActiveNotification> active=await notificationsPlugin.getActiveNotifications();
              // if(active.length>0) {
              //   notificationsPlugin. cancel(0);
              // }        });
              // List<ActiveNotification>  dfdf=await flutterLocalNotificationsPlugin.getActiveNotifications();
              //
              // flutterLocalNotificationsPlugin.cancel(dfdf[0].id!);
            } else {}
          }
        }
        for (var call in activeCalls) {
          int index = fireBaseCallList
              .indexWhere((element) => element.id == call["id"]);
          if (index == -1) {
            final String callId = call['id'] ?? '';
            final Map<String, dynamic> extraData =
                Map<String, dynamic>.from(call['extra']);
            if (extraData["type"] == "new_call") {
              FlutterCallkitIncoming.endCall(callId);
            }
          }
        }
        // int hasAlreadyRinging = activeCalls.indexWhere((call) => call["accepted"] && call["id"]==callModel.id );

        // if (activeCalls.isNotEmpty) {
        //   for (var call in activeCalls) {
        //     // if (call is Map<String, dynamic>) {
        //     final bool isAccepted = call['accepted'] ?? false;
        //     final String callId = call['id'] ?? '';
        //     // case when a and b on call and c calls b then c disconnect call then remove call ringing from b phone
        //     int existIndex=fireBaseCallList.indexWhere((element)=> element.id==callId);
        //     if(existIndex==-1){
        //       await FlutterCallkitIncoming.endCall(callId);
        //     }
        //
        //     // Don't show call if it's already accepted
        //     if (isAccepted && callId == callModel.id) {
        //       showCall = false;
        //       // break;
        //     }
        //     // }
        //   }
        // }

        // // Show incoming call if conditions are met
        // if (!callModel.isStudentCalled! && callModel.callStatus==FirebaseUtils.callRinging) {
        //   await showCallkitIncoming(
        //     callModel.id ?? '',
        //     callModel.teacherName ?? '',
        //     callModel.profileUrl ?? '',
        //     callModel.callType ?? '',
        //     callModel.toJson(),
        //   );
        // }
      } else {
        for (var call in activeCalls) {
          final String callId = call['id'] ?? '';
          final Map<String, dynamic> extraData =
              Map<String, dynamic>.from(call['extra']);
          if (extraData["type"] == "new_call") {
            FlutterCallkitIncoming.endCall(callId);
          }
        }
        // End all calls if no documents exist
        // await FlutterCallkitIncoming.endAllCalls();
      }
    }, onError: (error) {
      print("Error listening to document: $error");
    });
  }

  // static listenCalls() async {
  //
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String studentId = preferences.getString('breffini_student_id') ?? '';
  //   FirebaseFirestore.instance
  //       .collection("calls")
  //       .doc("STD-"+studentId)
  //       .snapshots()
  //       .listen((DocumentSnapshot snapshot) async {
  //     if (snapshot.exists) {
  //       final data = snapshot.data() as Map<String, dynamic>;
  //
  //       FirebaseCallModel callModel = FirebaseCallModel.fromMap(data);
  //       var calls = await FlutterCallkitIncoming.activeCalls();
  //       bool showCall=true;
  //       if (calls is List && calls.isNotEmpty) {
  //         if (calls[0].length > 0) {
  //           bool isAccepted = calls[0]["accepted"];
  //           String callId = calls[0]['id'] ?? '';
  //
  //           if(isAccepted && callId==callModel.id){  // case when call accepted from ring screen
  //             showCall=false;
  //           }
  //         }
  //       }
  //
  //       if(!callModel.isStudentCalled! && showCall){
  //         showCallkitIncoming(callModel.id??"", callModel.teacherName??"",callModel.profileUrl??"", callModel.callType??"", callModel.toJson());
  //       }
  //     } else {
  //       await FlutterCallkitIncoming.endAllCalls();
  //     }
  //   }, onError: (error) {
  //     print("Error listening to document: $error");
  //   });
  // }

  static listeningToCurrentCall(String teacherId, String callId) {
    _callListener = FirebaseFirestore.instance
        .collection("calls")
        .doc(getDocId(
            teacherId)) // Directly access the document with the specified ID
        .snapshots()
        .listen((DocumentSnapshot snapshot) async {
      if (snapshot.exists) {
        // Document found, handle the data
        var callData = snapshot.data();
        print("Call data with id 50: $callData");

        // Use setState to update the UI or perform other actions here
      } else {
        if (null != _callListener) {
          _callListener?.cancel();
        }
        CallandChatController callandChatController = Get.find();

        if (Get.currentRoute == "/IncomingCallPage") {
          safeBack();
          Get.showSnackbar(const GetSnackBar(
            message: 'Call Ended',
            duration: Duration(milliseconds: 2000),
          ));
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: 'Call Ended',
            duration: Duration(milliseconds: 2000),
          ));
          FlutterCallkitIncoming.endAllCalls();
        }
        if (!callandChatController.currentCallModel.value.callId
            .isNullOrEmpty()) {
          // added this because when already disconnectCall called then call
          // this function may create call reject true by checking callandChatController.enteredUserList.isEmpty(callandChatController.enteredUserList.isEmpty cleared in first api call)
          callandChatController.disconnectCall(true, false, teacherId, callId);
        }
      }
    });
  }

  static cancelCallListening() {
    if (null != _callListener) {
      _callListener?.cancel();
    }
  }
}
