import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/profile/model/payment_history_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class PaymentHistoryDetailsPage extends StatelessWidget {
  final PaymentHistoryModel model;
  const PaymentHistoryDetailsPage({super.key, required this.model});

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: ColorResources.colorBlue100,
                child: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                    color: ColorResources.colorBlack.withOpacity(.8),
                  ),
                ),
              ),
            ),
          ),
          titleSpacing: 0,
          title: Text(
            'Course details',
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey700,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {},
                  child: Container(
                    color: ColorResources.colorwhite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80.h,
                                width: 110.v,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.v),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.v),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${HttpUrls.imgBaseUrl}${model.thumbanailPath}',
                                      fit: BoxFit.contain,
                                      placeholder:
                                          (BuildContext context, String url) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: ColorResources.colorBlue500,
                                        ));
                                      },
                                      errorWidget: (BuildContext context,
                                          String url, dynamic error) {
                                        return Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: ColorResources.colorBlue100,
                                            size: 40,
                                          ),
                                        );
                                      },
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                        width: 180.h,
                                        child: Text(
                                          model.courseName,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleSmall!
                                              .copyWith(
                                            height: 1.43,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.v),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SizedBox(
                                      width: 180.h,
                                      child: Text(
                                        '\u{20B9} ${model.price}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleSmall!
                                            .copyWith(
                                                height: 1.43,
                                                color: ColorResources
                                                    .colorgrey500),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 190.h,
                  width: Get.width,
                  decoration: BoxDecoration(color: ColorResources.colorwhite),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Bill ID',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorResources.colorgrey500,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans'),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${model.transactionId}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorResources.colorgrey700,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans'),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Date & time',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorResources.colorgrey500,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans'),
                            ),
                            Expanded(child: SizedBox()),
                            Expanded(
                              child: Text(
                                formatDate(model.paymentDate),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: ColorResources.colorgrey700,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Plus Jakarta Sans'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Payment method',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorResources.colorgrey500,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans'),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${model.paymentMethod}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorResources.colorgrey700,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans'),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Amount',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorResources.colorgrey500,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans'),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '\u{20B9} ${model.price}',
                              style: TextStyle(
                                  fontSize:
                                      model.paymentMethod != 'admin' ? 18 : 14,
                                  color: ColorResources.colorgrey700,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Plus Jakarta Sans'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
