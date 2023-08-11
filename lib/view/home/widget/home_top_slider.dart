import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_gradients.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class HomeTopSlider extends StatefulWidget {
  const HomeTopSlider({Key? key}) : super(key: key);

  @override
  State<HomeTopSlider> createState() => _HomeTopSliderState();
}

class _HomeTopSliderState extends State<HomeTopSlider> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              height: 250.h,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                setState(() {});
              }),
          items: [1, 2, 3, 4, 5].map((i) {
            if (i % 2 == 0) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: AppGradients.orangeGradient,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: CommonAppImage(
                        imagePath: HomeImageAssets.sunrays,
                        height: 250.h,
                        width: 320.w,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 19.w),
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 74.w,
                                        height: 74.w,
                                        margin: EdgeInsets.only(
                                            bottom: 12.h, right: 12.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorWhite,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: CommonAppImage(
                                                    imagePath:
                                                        'https://img.freepik.com/free-photo/handsome-young-indian-student-man-holding-notebooks-while-standing-street_231208-2771.jpg?w=740&t=st=1685620885~exp=1685621485~hmac=96439806d8301e5b3bafa54c3b5f7bdc3251582d519b54756aab8c6c20ebbb92',
                                                    width: 70.w,
                                                    height: 70.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CommonAppImage(
                                                      imagePath:
                                                          HomeImageAssets.bedge,
                                                      width: 20.w,
                                                      height: 25.h,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 6.h),
                                                      child: Text(
                                                        '2',
                                                        style: AppTextStyle
                                                                .readexTextStyle10SemiBold(
                                                                    color: AppColors
                                                                        .colorWhite)
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                      Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          CommonAppImage(
                                              imagePath:
                                                  HomeImageAssets.leader2),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 16.w),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 18.h,
                                                ),
                                                Text(
                                                  'Harsh',
                                                  style: AppTextStyle
                                                      .readexTextStyle14Medium(
                                                          color: AppColors
                                                              .yellow50),
                                                ),
                                                SizedBox(
                                                  height: 7.h,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.w,
                                                      vertical: 2.h),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.colorFFD7AA,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(64),
                                                    ),
                                                  ),
                                                  height: 18.h,
                                                  child: Row(
                                                    children: [
                                                      CommonAppImage(
                                                          imagePath:
                                                              HomeImageAssets
                                                                  .ic_bulb),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: '87',
                                                              style: AppTextStyle
                                                                      .readexTextStyle10SemiBold(
                                                                          color:
                                                                              AppColors.colorC2410C)
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '%',
                                                              style: AppTextStyle
                                                                      .readexTextStyle10Regular(
                                                                          color:
                                                                              AppColors.colorC2410C)
                                                                  .copyWith(
                                                                fontSize: 8.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 74.w,
                                        height: 74.w,
                                        margin: EdgeInsets.only(
                                            bottom: 12.h, left: 12.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorWhite,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: CommonAppImage(
                                                    imagePath:
                                                        'https://img.freepik.com/free-photo/handsome-young-indian-student-man-holding-notebooks-while-standing-street_231208-2771.jpg?w=740&t=st=1685620885~exp=1685621485~hmac=96439806d8301e5b3bafa54c3b5f7bdc3251582d519b54756aab8c6c20ebbb92',
                                                    width: 70.w,
                                                    height: 70.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CommonAppImage(
                                                      imagePath:
                                                          HomeImageAssets.bedge,
                                                      width: 20.w,
                                                      height: 25.h,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4.h),
                                                      child: Text(
                                                        '3',
                                                        style: AppTextStyle
                                                                .readexTextStyle10SemiBold(
                                                                    color: AppColors
                                                                        .colorWhite)
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                      Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          CommonAppImage(
                                              imagePath:
                                                  HomeImageAssets.leader3),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 25.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                                Text(
                                                  'Pothulayya',
                                                  style: AppTextStyle
                                                      .readexTextStyle14Medium(
                                                          color: AppColors
                                                              .yellow50),
                                                ),
                                                SizedBox(
                                                  height: 7.h,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.w,
                                                      vertical: 2.h),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.colorFFD7AA,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  64))),
                                                  height: 18.h,
                                                  child: Row(
                                                    children: [
                                                      CommonAppImage(
                                                          imagePath:
                                                              HomeImageAssets
                                                                  .ic_bulb),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: '82',
                                                              style: AppTextStyle
                                                                      .readexTextStyle10SemiBold(
                                                                          color:
                                                                              AppColors.colorC2410C)
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '%',
                                                              style: AppTextStyle
                                                                      .readexTextStyle10Regular(
                                                                          color:
                                                                              AppColors.colorC2410C)
                                                                  .copyWith(
                                                                fontSize: 8.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 122.w,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 94.w,
                                          height: 94.w,
                                          margin: EdgeInsets.only(bottom: 8.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.colorWhite,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CommonAppImage(
                                                      imagePath:
                                                          'https://img.freepik.com/free-photo/outdoor-autumn-portrait-happy-smiling-teenage-girl-with-copybooks_231208-152.jpg?w=1060&t=st=1685957811~exp=1685958411~hmac=9a56aa21b454f4a337c3bcb12b08a337eb49869d5c4211e3ac0d57155f9f18d8',
                                                      width: 90.w,
                                                      height: 90.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CommonAppImage(
                                                        imagePath:
                                                            HomeImageAssets
                                                                .bedge,
                                                        width: 25.w,
                                                        height: 30.h,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 6.h),
                                                        child: Text(
                                                          '1',
                                                          style: AppTextStyle
                                                                  .readexTextStyle12SemiBold(
                                                                      color: AppColors
                                                                          .colorWhite)
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                        Stack(
                                          children: [
                                            CommonAppImage(
                                                imagePath:
                                                    HomeImageAssets.leader1),
                                            Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                // CommonAppImage(imagePath: HomeImageAssets.leader2),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 0.w),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 28.h,
                                                      ),
                                                      Text(
                                                        'Sakhi',
                                                        style: AppTextStyle
                                                            .readexTextStyle14Medium(
                                                                color: AppColors
                                                                    .yellow50),
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w,
                                                                    vertical:
                                                                        2.h),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .colorFFD7AA,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    64),
                                                              ),
                                                            ),
                                                            height: 18.h,
                                                            child: Row(
                                                              children: [
                                                                CommonAppImage(
                                                                    imagePath:
                                                                        HomeImageAssets
                                                                            .ic_bulb),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            '98',
                                                                        style: AppTextStyle.readexTextStyle10SemiBold(color: AppColors.colorC2410C)
                                                                            .copyWith(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            '%',
                                                                        style: AppTextStyle.readexTextStyle10Regular(color: AppColors.colorC2410C)
                                                                            .copyWith(
                                                                          fontSize:
                                                                              8.sp,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          left: 26.w,
                          right: 16.w,
                          top: 0,
                          child: Container(
                            // color: Colors.yellow,
                            child: Image.asset(
                              HomeImageAssets.leader1Animation1,
                              width: 280.w,
                              height: 200.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 26.w,
                          right: 16.w,
                          top: 0,
                          child: Container(
                            // color: Colors.yellow,
                            child: Image.asset(
                              HomeImageAssets.leader1Animation2,
                              width: 280.w,
                              height: 200.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Leaderboard',
                            style: AppTextStyle.readexTextStyle16SemiBold(
                              color: AppColors.color1E293B,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print('object');
                              Get.toNamed(AppRoutes.leaderBoardPage);
                            },
                            child: Row(
                              children: [
                                Text(
                                  'View all',
                                  style: AppTextStyle.readexTextStyle14SemiBold(
                                    color: AppColors.color1E293B,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  size: 16.w,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            // if (i % 2 == 0) {
            //   return Builder(
            //     builder: (context) {
            //       return Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10.w),
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(15.r),
            //           child: Stack(
            //             children: [
            //               Positioned.fill(
            //                 child: Image.asset(
            //                   HomeImageAssets.sliderBanner2,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //               // Align(
            //               //   alignment: Alignment.center,
            //               //   child: Padding(
            //               //     padding: EdgeInsets.symmetric(horizontal: 15.w),
            //               //     child: Row(
            //               //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               //       children: [
            //               //         GestureDetector(
            //               //           onTap: () {
            //               //             _controller.previousPage();
            //               //           },
            //               //           child: Container(
            //               //             padding: EdgeInsets.all(2.h),
            //               //             decoration: BoxDecoration(
            //               //               shape: BoxShape.circle,
            //               //               border: Border.all(
            //               //                 color: AppColors.gray300,
            //               //                 width: 1.w,
            //               //               ),
            //               //               color: AppColors.gray50,
            //               //             ),
            //               //             child: Icon(
            //               //               Icons.arrow_back,
            //               //               color: AppColors.gray900,
            //               //               size: 12.h,
            //               //             ),
            //               //           ),
            //               //         ),
            //               //         GestureDetector(
            //               //           onTap: () {
            //               //             _controller.nextPage();
            //               //           },
            //               //           child: Container(
            //               //             padding: EdgeInsets.all(2.h),
            //               //             decoration: BoxDecoration(
            //               //               shape: BoxShape.circle,
            //               //               border: Border.all(
            //               //                 color: AppColors.gray300,
            //               //                 width: 1.w,
            //               //               ),
            //               //               color: AppColors.gray50,
            //               //             ),
            //               //             child: Icon(
            //               //               Icons.arrow_forward,
            //               //               color: AppColors.gray900,
            //               //               size: 12.h,
            //               //             ),
            //               //           ),
            //               //         )
            //               //       ],
            //               //     ),
            //               //   ),
            //               // ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   );
            // }
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            HomeImageAssets.sliderBanner,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.0),
                                  Colors.black.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.5, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 7.h),
                            decoration: BoxDecoration(
                                color: AppColors.colorWhite.withOpacity(0.8),
                                border: Border.all(
                                    color: AppColors.blueGray200, width: 0.5),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.r),
                                  bottomRight: Radius.circular(5.r),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.colorBlack.withOpacity(0.15),
                                    offset: const Offset(0, 4),
                                    blurRadius: 16,
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Row(
                              children: [
                                RippleAnimation(
                                  child: Container(
                                    height: 10.h,
                                    width: 10.w,
                                    decoration: const BoxDecoration(
                                      color: AppColors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  color: AppColors.red,
                                  delay: const Duration(milliseconds: 300),
                                  repeat: true,
                                  minRadius: 8,
                                  ripplesCount: 0,
                                  duration:
                                      const Duration(milliseconds: 6 * 300),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Live',
                                  style: AppTextStyle.readexTextStyle14Regular()
                                      .copyWith(
                                    color: AppColors.blueDarkExtra,
                                    fontSize: 15.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 15.w),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         GestureDetector(
                        //           onTap: () {
                        //             _controller.previousPage();
                        //           },
                        //           child: Container(
                        //             padding: EdgeInsets.all(2.h),
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               border: Border.all(
                        //                 color: AppColors.gray300,
                        //                 width: 1.w,
                        //               ),
                        //               color: AppColors.gray50,
                        //             ),
                        //             child: Icon(
                        //               Icons.arrow_back,
                        //               color: AppColors.gray900,
                        //               size: 12.h,
                        //             ),
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: () {
                        //             _controller.nextPage();
                        //           },
                        //           child: Container(
                        //             padding: EdgeInsets.all(2.h),
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               border: Border.all(
                        //                 color: AppColors.gray300,
                        //                 width: 1.w,
                        //               ),
                        //               color: AppColors.gray50,
                        //             ),
                        //             child: Icon(
                        //               Icons.arrow_forward,
                        //               color: AppColors.gray900,
                        //               size: 12.h,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 15.h, right: 15.h, bottom: 35.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'free 1:1 online coding workshop\nfor grade 1-12 students',
                                  style: AppTextStyle.readexTextStyle14Regular()
                                      .copyWith(
                                    color: AppColors.colorWhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 7.h),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      color: AppColors.colorWhite,
                                    ),
                                    child: Text(
                                      'Join Now',
                                      style: AppTextStyle
                                              .readexTextStyle14Regular()
                                          .copyWith(
                                        color: AppColors.blueDark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.previousPage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.gray300,
                          width: 1.w,
                        ),
                        color: AppColors.gray50,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.gray900,
                        size: 12.h,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.nextPage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.gray300,
                          width: 1.w,
                        ),
                        color: AppColors.gray50,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.gray900,
                        size: 12.h,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [1, 2, 3, 4, 5].asMap().entries.map((entry) {
        //     return GestureDetector(
        //       onTap: () => _controller.animateToPage(entry.key),
        //       child: Container(
        //         width: 6.w,
        //         height: 6.h,
        //         margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white.withOpacity(0.5))
        //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
        //       ),
        //     );
        //   }).toList(),
        // )
      ],
    );
  }
}
