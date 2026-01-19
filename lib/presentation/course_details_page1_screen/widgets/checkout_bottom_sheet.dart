import 'dart:convert';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../home_page/controller/home_controller.dart';
import '../../home_page/models/home_model.dart';

// ignore: must_be_immutable
class CheckoutBottomSheetWidget extends StatelessWidget {
  final String slotId;
  final String amount;
  final String courseName;
  final String courseId;
  final String thumbNailPath;
  final String description;
  final String price;
  HyperSDK hyperSdk;
  CheckoutBottomSheetWidget(
      {Key? key,
      // required this.courseDetails,
      required this.slotId,
      required this.amount,
      required this.courseId,
      required this.thumbNailPath,
      required this.description,
      required this.price,
      required this.courseName,
      required this.hyperSdk})
      : super(key: key);

  // final CourseDetailsListModel? courseDetails;
  HomeController controllerCourseDetailsController =
      Get.put(HomeController(HomeModel().obs));
  final profileController = Get.find<ProfileController>();

  bool isLoadingBuyBtn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 401.v,
      padding: EdgeInsets.all(15.v),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.v)),
      child: StatefulBuilder(builder: (_context, setState) {
        return PopScope(
          canPop: !isLoadingBuyBtn,
          onPopInvokedWithResult: (isPop, reason) {
            print("sfd");
          },
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    'Item',
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: ColorResources.colorgrey700),
                  ),
                ),
                Container(
                  child: Text(
                    '1 item',
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: ColorResources.colorgrey700),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24.v,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 105.v,
                    height: 65.v,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.v),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '${HttpUrls.imgBaseUrl}${thumbNailPath}'))),
                  ),
                  SizedBox(
                    width: 12.v,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 230.v,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/img_books.svg',
                              color: ColorResources.colorgrey800,
                            ),
                            Expanded(
                              child: Text(
                                '${courseName}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorResources.colorgrey700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 22.v,
                      // ),
                      // SizedBox(
                      //   width: 228.v,
                      //   child: Row(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           SvgPicture.asset('assets/images/img_books.svg'),
                      //           Text('',
                      //               style: TextStyle(
                      //                   fontFamily: 'Plus Jakarta Sans',
                      //                   fontWeight: FontWeight.w700,
                      //                   fontSize: 16,
                      //                   color: ColorResources.colorgrey700)),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         width: 18.v,
                      //       ),
                      //       // Row(
                      //       //   children: [
                      //       //     SvgPicture.asset('assets/images/img_books.svg'),
                      //       //     Text(''),
                      //       //   ],
                      //       // ),
                      //       // SizedBox(
                      //       //   width: 18.v,
                      //       // ),
                      //       // Row(
                      //       //   children: [
                      //       //     SvgPicture.asset('assets/images/img_books.svg'),
                      //       //     Text(''),
                      //       //   ],
                      //       // ),
                      //     ],
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.v,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total items',
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: ColorResources.colorgrey700)),
                Text(
                  'x1',
                  style: TextStyle(fontSize: 16.v, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 12.v,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: ColorResources.colorgrey700)),
                Text(
                  price == "0.00" ? 'Free' : '₹ ${price}',
                  style: TextStyle(fontSize: 16.v, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(),
            ),
            price == "0.00"
                ? InkWell(
                    onTap: () async {
                      await controllerCourseDetailsController
                          .enrollNowApi(
                              slotId: 0,
                              context: Get.context!,
                              courseId: int.parse(courseId),
                              totalPrice: '0',
                              txnId: "ABC123",
                              paymentMethod: "Credit Card")
                          .then((value) {
                        if (value) {
                          showAlertDialog(
                                  Get.context!,
                                  "Enroll Successful",
                                  "",
                                  Icon(Icons.verified,
                                      color: Colors.green, size: 40),
                                  isDismissible: false)
                              .then((value) {
                            profileController.getProfileStudent();

                            Get.toNamed(AppRoutes.homePageContainerScreen);
                          });
                        } else {
                          showAlertDialog(
                              Get.context!,
                              "Enroll Failed",
                              "",
                              Icon(Icons.report_gmailerrorred,
                                  color: Colors.red, size: 40));
                          // Get.back();
                        }
                      });
                    },
                    child: Container(
                      width: 328.v,
                      height: 40.v,
                      decoration: BoxDecoration(
                          color: Color(0xff1863D3),
                          borderRadius: BorderRadius.circular(42.v)),
                      child: Center(
                        child: Text(
                          'Enroll Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : isLoadingBuyBtn
                    ? CircularProgressIndicator()
                    : InkWell(
                        onTap: () async {
                          isLoadingBuyBtn = true;
                          setState(() {});
                          double doubleAmount = double.parse(amount);
                          // Convert to int
                          int parsedAmount = doubleAmount.toInt();
                          bool status = await controllerCourseDetailsController
                              .startPayment(hyperSdk, doubleAmount,
                                  (MethodCall methodCall) {
                            switch (methodCall.method) {
                              case "hide_loader":
                                break;
                              case "process_result":
                                var args = {};

                                try {
                                  args = json.decode(methodCall.arguments);
                                } catch (e) {
                                  print(e);
                                }
                                bool isError = args["error"];
                                if (isError) {
                                  setState(() {
                                    isLoadingBuyBtn = false;
                                  });
                                  String errorMessage = args["errorMessage"];
                                  showAlertDialog(
                                      Get.context!,
                                      "Payment Failed",
                                      "Reason: ${errorMessage.toString()}",
                                      Icon(Icons.report_gmailerrorred,
                                          color: Colors.red, size: 40));
                                } else {
                                  var innerPayload = args["payload"] ?? {};
                                  var status = innerPayload["status"] ?? " ";
                                  var paymentInstrumentGroup =
                                      innerPayload["paymentInstrumentGroup"] ??
                                          " ";
                                  var orderId = args['orderId'];

                                  controllerCourseDetailsController
                                      .enrollNowApi(
                                          courseId: int.parse(courseId),
                                          totalPrice: doubleAmount.toString(),
                                          slotId: 0,
                                          context: context,
                                          txnId: orderId,
                                          paymentMethod: paymentInstrumentGroup)
                                      .then((value) {
                                    if (value) {
                                      showAlertDialog(
                                              Get.context!,
                                              "Enroll Successful",
                                              "Payment ID: ${orderId.toString()}",
                                              Icon(Icons.verified,
                                                  color: Colors.green,
                                                  size: 40),
                                              isDismissible: false)
                                          .then((value) {
                                        Get.toNamed(
                                            AppRoutes.homePageContainerScreen);
                                      });
                                      // Future.delayed(const Duration(seconds: 5)).then((value) {
                                      //   Get.toNamed(AppRoutes
                                      //       .homePageContainerScreen);
                                      // });
                                    } else {
                                      showAlertDialog(
                                          Get.context!,
                                          "Enroll Failed",
                                          "",
                                          Icon(Icons.report_gmailerrorred,
                                              color: Colors.red, size: 40));
                                      // Get.back();
                                    }
                                  });
                                }
                            }
                          });
                          if (!status) {
                            setState(() {
                              isLoadingBuyBtn = false;
                            });
                          }
                          // Razorpay razorpay = Razorpay();
                          // var options = {
                          //   'key': 'rzp_test_BqVRVH2RFDHuty',
                          //   'amount': parsedAmount * 100,
                          //   'name': '${courseName}',
                          //   'description': '${description}',
                          //   'retry': {'enabled': true, 'max_count': 1},
                          //   'send_sms_hash': true,
                          //   'prefill': {
                          //     'contact': '777777777',
                          //     'email': 'test@razorpay.com'
                          //   },
                          //   'external': {
                          //     'wallets': ['paytm']
                          //   }
                          // };
                          // razorpay.on(
                          //     Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                          // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                          //     handlePaymentSuccessResponse);
                          // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                          //     handleExternalWalletSelected);
                          // razorpay.open(options);
                        },
                        child: Container(
                          width: 328.v,
                          height: 40.v,
                          decoration: BoxDecoration(
                              color: Color(0xff1863D3),
                              borderRadius: BorderRadius.circular(42.v)),
                          child: Center(
                            child: Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
            SizedBox(
              height: 10.v,
            ),
            if (!isLoadingBuyBtn)
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 328.v,
                  height: 40.v,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(42.v),
                      border: Border.all()),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
          ]),
        );
      }),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    Get.showSnackbar(GetSnackBar(
      message: "Payment failed, We've processed your cancellation",
      backgroundColor: Color.fromARGB(255, 231, 25, 25),
      duration: Duration(milliseconds: 2000),
    ));
  }

  // void handlePaymentSuccessResponse(String txnId, String paymentMethod) {
  //   showAlertDialog(Get.context!, "Payment Successful", "Payment ID: ${txnId}");
  //
  //   Get.back();
  //   controllerCourseDetailsController.enrollNowApi(
  //       slotId: int.parse(slotId),
  //       context: Get.context!,
  //       courseId: int.parse(courseId),
  //       totalPrice: amount,
  //       txnId: txnId,
  //       paymentMethod: paymentMethod);
  // }
  // void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
  //   showAlertDialog(Get.context!, "Payment Successful",
  //       "Payment ID: ${response.paymentId}");
  //
  //   print('payment response   ${response.data}');
  //   Get.back();
  //   controllerCourseDetailsController.enrollNowApi(
  //       slotId: int.parse(slotId),
  //       context: Get.context!,
  //       courseId: int.parse(courseId),
  //       totalPrice: amount,txnId: );
  // }

  // void handleExternalWalletSelected(ExternalWalletResponse response) {
  //   showAlertDialog(
  //       Get.context!, "External Wallet Selected", "${response.walletName}");
  // }
}
