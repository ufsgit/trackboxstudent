import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/profile/model/payment_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController extends GetxController {
  var paymentSearchList = <PaymentHistoryModel>[].obs;
  bool isSearchEmpty = false;
  TextEditingController searchController = TextEditingController();

  var paymentHistoryList = <PaymentHistoryModel>[].obs;
  void searchPaymentHistory(String query) {
    if (query.isEmpty) {
      paymentSearchList.clear();
      isSearchEmpty = false;
    } else {
      paymentSearchList.value = paymentHistoryList
          .where((course) =>
              course.courseName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      isSearchEmpty = paymentSearchList.isEmpty;
    }
    update();
  }

  getPaymentHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    await HttpRequest.httpGetRequest(
            endPoint: '${HttpUrls.getPaymentHistory}/$studentId',
            showLoader: true)
        .then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final paymentDetails = responseData;
          paymentHistoryList.value = paymentDetails
              .map((result) => PaymentHistoryModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final paymentDetails = [responseData];
          paymentHistoryList.value = paymentDetails
              .map((result) => PaymentHistoryModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load calls data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }
}
