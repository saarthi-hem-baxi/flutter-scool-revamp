import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/widgets/common_app_image.dart';

class MostTrendingAmongLearner extends StatefulWidget {
  const MostTrendingAmongLearner({super.key});

  @override
  State<MostTrendingAmongLearner> createState() =>
      _MostTrendingAmongLearnerState();
}

class _MostTrendingAmongLearnerState extends State<MostTrendingAmongLearner> {
  // final CarouselController _controller = CarouselController();
  int _current = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    addScollListener();
    super.initState();
  }

  void _scrollToNextItem() {
    if (_current < [1, 2, 3, 4, 5, 6, 7, 8].length - 1) {
      setState(() {
        _current++;
      });
      _scrollController.animateTo(
        (_current * (Utils.getScreenWidth + 8.w)),
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToPreviousItem() {
    if (_current > 0) {
      setState(() {
        _current--;
      });
      _scrollController.animateTo((_current * (Utils.getScreenWidth + 8.w)),
          duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 205.h,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: [1, 2, 3, 4, 5, 6, 7, 8].length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  // return CarouselSlider(
                  //   carouselController: _controller,
                  //   options: CarouselOptions(
                  //       // aspectRatio: 2.0,
                  //       enlargeCenterPage: false,
                  //       viewportFraction: 1.1,
                  //       // autoPlayInterval: const Duration(seconds: 5),
                  //       // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  //       // autoPlayCurve: Curves.fastOutSlowIn,
                  //       enableInfiniteScroll: false,
                  //       height: 205.h,
                  //       onPageChanged: (index, reason) {
                  //         setState(() {
                  //           _current = index;
                  //         });
                  //       }),
                  //   items: [1, 2, 3, 4, 5, 6, 7, 8].map((i) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: Container(
                      width: Utils.getScreenWidth,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CommonAppImage(
                            imagePath: HomeImageAssets.demoImage,
                            fit: BoxFit.cover,
                            width: Utils.getScreenWidth,
                          ),
                          Container(
                            color: AppColors.color1B2F6E.withOpacity(0.6),
                            height: 24.h,
                            padding: EdgeInsets.only(left: 28.w, right: 8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CommonAppImage(
                                  imagePath: HomeImageAssets.playerIcon,
                                  height: 14.h,
                                  width: 14.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Two Digit Addition',
                                  style: AppTextStyle.readexTextStyle12Regular(
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  //   }).toList(),
                  // );
                },
              ),
            ),
            Positioned(
              left: -5.0,
              top: -8.h,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity: _current == 0 ? 0 : 1,
                child: InkWell(
                  onTap: () {
                    _scrollToPreviousItem();
                  },
                  child: SizedBox(
                    width: 35.w,
                    height: 220.h,
                    child: Container(
                      // color: AppColors.color13214D,
                      width: 30.w,
                      height: 210.h,
                      padding: EdgeInsets.only(
                        left: 5.w,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.color13214D.withOpacity(0.6),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.colorWhite,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -5.0,
              top: -8.h,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity:
                    _current == [1, 2, 3, 4, 5, 6, 7, 8].length - 1 ? 0 : 1,
                child: InkWell(
                  onTap: () {
                    _scrollToNextItem();
                  },
                  child: SizedBox(
                    width: 35.w,
                    height: 220.h,
                    child: Container(
                      width: 30.w,
                      height: 210.h,
                      padding: EdgeInsets.only(right: 5.w),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.color13214D.withOpacity(0.6),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.colorWhite,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3, 4, 5, 6, 7, 8].map((image) {
            int index = [1, 2, 3, 4, 5, 6, 7, 8].indexOf(image);
            return AnimatedContainer(
              duration: Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              width: 10.h,
              height: 10.h,
              margin: EdgeInsets.only(top: 12.h, right: 8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? AppColors.colorWhite
                    : AppColors.color465481,
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  void addScollListener() {
    _scrollController.addListener(() {
      // Get the current visible item index
      _current = (_scrollController.offset / Utils.getScreenWidth).round();
      // Do something with the current index
      setState(() {});
    });
  }
}
