import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CaroselWidget extends StatelessWidget {
  final List<CarouselItem> items;
  final double height;
  final double viewportFraction;
  final Duration autoPlayInterval;
  final Duration animationDuration;

  const CaroselWidget({
    Key? key,
    required this.items,
    this.height = 200,
    this.viewportFraction = 0.8,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: CarouselSlider.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: InteractiveViewer(
                                panEnabled: true,
                                minScale: 0.5,
                                maxScale: 4,
                                child: items[index].isAsset
                                    ? Image.asset(items[index].imageUrl)
                                    : CachedNetworkImage(
                                        imageUrl: items[index].imageUrl,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error,
                                                color: Colors.white),
                                      ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: items[index].isAsset
                        ? Image.asset(
                            items[index].imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : CachedNetworkImage(
                            imageUrl: items[index].imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                  ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //       // gradient: LinearGradient(
                  //       //   begin: Alignment.topCenter,
                  //       //   end: Alignment.bottomCenter,
                  //       //   colors: [
                  //       //     ColorResources.colorBlue400,
                  //       //     ColorResources.colorBlue800,
                  //       //   ],
                  //       // ),
                  //       ),
                  // ),
                  // Text content
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        // Text(
                        //   items[index].description,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 14,
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  // if (items[index].onTap != null)
                  //   Positioned.fill(
                  //     child: Material(
                  //       color: Colors.transparent,
                  //       child: InkWell(
                  //         onTap: items[index].onTap,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: height,
          viewportFraction: viewportFraction,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: autoPlayInterval,
          autoPlayAnimationDuration: animationDuration,
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class CarouselItem {
  final String imageUrl;

  //final String description;
  final bool isAsset;
  final VoidCallback? onTap;

  CarouselItem({
    required this.imageUrl,
    // required this.description,
    this.isAsset = true,
    this.onTap,
  });
}
