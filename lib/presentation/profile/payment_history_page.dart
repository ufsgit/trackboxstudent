import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/payment_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/payment_history_details_page.dart';
import 'package:anandhu_s_application4/presentation/profile/widgets/custom_appbar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentHistoryPage extends StatelessWidget {
  PaymentHistoryPage({super.key});

  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomBar(
          onChanged: (value) {
            paymentController.searchPaymentHistory(value);
          },
          title: "Payment history",
          controller: paymentController.searchController,
        ),
        body: GetBuilder<PaymentController>(
          init: paymentController,
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    if (controller.isSearchEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: Get.height / 3,
                          ),
                          Center(
                            child: Text(
                              "No results found",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Plus Jakarta Sans',
                                color: ColorResources.colorgrey700,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 24.v);
                        },
                        itemCount: controller.searchController.text.isNotEmpty
                            ? controller.paymentSearchList.length
                            : controller.paymentHistoryList.length,
                        itemBuilder: (context, index) {
                          final payment =
                              controller.searchController.text.isNotEmpty
                                  ? controller.paymentSearchList[index]
                                  : controller.paymentHistoryList[index];
                          return InkWell(
                            onTap: () async {
                              Get.to(() => PaymentHistoryDetailsPage(
                                    model: payment,
                                  ));
                            },
                            child: Container(
                              color: ColorResources.colorwhite,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 80.h,
                                          width: 110.v,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.v),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.v),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${HttpUrls.imgBaseUrl}${payment.thumbanailPath}',
                                              fit: BoxFit.contain,
                                              placeholder:
                                                  (BuildContext context,
                                                      String url) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: ColorResources
                                                      .colorBlue500,
                                                ));
                                              },
                                              errorWidget:
                                                  (BuildContext context,
                                                      String url,
                                                      dynamic error) {
                                                return Center(
                                                  child: Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    color: ColorResources
                                                        .colorBlue100,
                                                    size: 40,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 8),
                                                SizedBox(
                                                  width: 180.h,
                                                  child: Text(
                                                    payment.courseName,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: theme
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                      height: 1.43,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2.v),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: SizedBox(
                                                width: 180.h,
                                                child: Text(
                                                  '\u{20B9} ${payment.price.toString()}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: theme
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                    height: 1.43,
                                                    color: ColorResources
                                                        .colorgrey500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    SizedBox(
                                      width: Get.width,
                                      height: 32,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          side: BorderSide(
                                              color:
                                                  ColorResources.colorgrey500),
                                          backgroundColor:
                                              ColorResources.colorwhite,
                                        ),
                                        onPressed: () {
                                          Get.to(
                                              () => PaymentHistoryDetailsPage(
                                                    model: payment,
                                                  ));
                                        },
                                        child: Text(
                                          'View details',
                                          style: TextStyle(
                                              color: ColorResources.colorBlack),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
