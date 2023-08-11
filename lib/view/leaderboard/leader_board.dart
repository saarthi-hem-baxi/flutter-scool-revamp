import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_gradients.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/status_color_manager.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusBarColorManager(
      color: AppColors.colorFBE3D0,
      child: Scaffold(
          body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.orangeLighGradient,
          ),
          height: Utils.getScreenHeight,
          child: Stack(
            children: [
              Container(
                height: Utils.getScreenHeight * 0.35,
                color: Colors.amber,
                child: Container(
                  height: Utils.getScreenHeight * 0.35,
                  decoration: BoxDecoration(
                    gradient: AppGradients.orangeGradient,
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
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
                                            margin:
                                                EdgeInsets.only(bottom: 12.h),
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
                                                            'https://img.freepik.com/free-photo/handsome-young-indian-student-man-holding-notebooks-while-standing-street_231208-2771.jpg?w=740&t=st=1685620885~exp=1685621485~hmac=96439806d8301e5b3bafa54c3b5f7bdc3251582d519b54756aab8c6c20ebbb92',
                                                        width: 70.w,
                                                        height: 70.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        CommonAppImage(
                                                          imagePath:
                                                              HomeImageAssets
                                                                  .bedge,
                                                          width: 20.w,
                                                          height: 25.h,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 4.h),
                                                          child: Text(
                                                            '2',
                                                            style: AppTextStyle
                                                                    .readexTextStyle10SemiBold(
                                                                        color: AppColors
                                                                            .colorWhite)
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                padding: EdgeInsets.only(
                                                    right: 16.w),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20.h,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.w,
                                                              vertical: 2.h),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .colorFFD7AA,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                                                  text: '85',
                                                                  style: AppTextStyle.readexTextStyle10SemiBold(
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
                                                                  style: AppTextStyle.readexTextStyle10Regular(
                                                                          color:
                                                                              AppColors.colorC2410C)
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
                                            margin:
                                                EdgeInsets.only(bottom: 12.h),
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
                                                            'https://img.freepik.com/free-photo/handsome-young-indian-student-man-holding-notebooks-while-standing-street_231208-2771.jpg?w=740&t=st=1685620885~exp=1685621485~hmac=96439806d8301e5b3bafa54c3b5f7bdc3251582d519b54756aab8c6c20ebbb92',
                                                        width: 70.w,
                                                        height: 70.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        CommonAppImage(
                                                          imagePath:
                                                              HomeImageAssets
                                                                  .bedge,
                                                          width: 20.w,
                                                          height: 25.h,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 4.h),
                                                          child: Text(
                                                            '3',
                                                            style: AppTextStyle
                                                                    .readexTextStyle10SemiBold(
                                                                        color: AppColors
                                                                            .colorWhite)
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 13.h,
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.w,
                                                            vertical: 2.h),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .colorFFD7AA,
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
                                                                text: '85',
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
                                                                  fontSize:
                                                                      8.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
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
                                              margin:
                                                  EdgeInsets.only(bottom: 8.h),
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
                                                            BorderRadius
                                                                .circular(100),
                                                        child: CommonAppImage(
                                                          imagePath:
                                                              'https://img.freepik.com/free-photo/outdoor-autumn-portrait-happy-smiling-teenage-girl-with-copybooks_231208-152.jpg?w=1060&t=st=1685957811~exp=1685958411~hmac=9a56aa21b454f4a337c3bcb12b08a337eb49869d5c4211e3ac0d57155f9f18d8',
                                                          width: 90.w,
                                                          height: 90.w,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
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
                                                                    bottom:
                                                                        6.h),
                                                            child: Text(
                                                              '1',
                                                              style: AppTextStyle
                                                                      .readexTextStyle12SemiBold(
                                                                          color:
                                                                              AppColors.colorWhite)
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                    imagePath: HomeImageAssets
                                                        .leader1),
                                                Stack(
                                                  alignment:
                                                      Alignment.topCenter,
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
                                                                            1.h),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .colorFFD7AA,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            64),
                                                                  ),
                                                                ),
                                                                height: 18.h,
                                                                child: Row(
                                                                  children: [
                                                                    CommonAppImage(
                                                                        imagePath:
                                                                            HomeImageAssets.ic_bulb),
                                                                    SizedBox(
                                                                      width:
                                                                          2.w,
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '98',
                                                                            style:
                                                                                AppTextStyle.readexTextStyle10SemiBold(color: AppColors.colorC2410C).copyWith(
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                '%',
                                                                            style:
                                                                                AppTextStyle.readexTextStyle10Regular(color: AppColors.colorC2410C).copyWith(
                                                                              fontSize: 8.sp,
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
                      ),
                      Stack(
                        children: [
                          Positioned(
                            left: 26.w,
                            right: 16.w,
                            top: 0,
                            child: Container(
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
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 32.h,
                                width: 32.h,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.gray50,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.gray300,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_outlined,
                                  size: 18,
                                  color: AppColors.gray800,
                                ),
                              ),
                            ),
                            Text(
                              'Leaderboard',
                              style: AppTextStyle.readexTextStyle22Regular(
                                color: AppColors.gray900,
                              ).copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: Utils.getScreenHeight * 0.33,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                    color: AppColors.colorWhite,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 72.h,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CommonAppImage(
                                imagePath:
                                    'https://img.freepik.com/free-photo/handsome-young-indian-student-man-holding-notebooks-while-standing-street_231208-2771.jpg?w=740&t=st=1685620885~exp=1685621485~hmac=96439806d8301e5b3bafa54c3b5f7bdc3251582d519b54756aab8c6c20ebbb92',
                                width: 48.w,
                                height: 48.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ajay Dave',
                                      style: AppTextStyle
                                              .poppinsTextStyle14SemiBold(
                                                  color: AppColors.gray800)
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '3',
                                      style: AppTextStyle
                                              .poppinsTextStyle12Regular(
                                                  color: AppColors.gray500)
                                          .copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                top: 4.h,
                                bottom: 4.h,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.colorFFF7ED,
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.colorFED7AA,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      64,
                                    ),
                                  )),
                              child: Row(
                                children: [
                                  CommonAppImage(
                                    imagePath: HomeImageAssets.ic_bulb,
                                    width: 16.w,
                                    height: 16.w,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '85',
                                          style: AppTextStyle
                                                  .readexTextStyle16Regular(
                                                      color:
                                                          AppColors.colorEA580C)
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '%',
                                          style: AppTextStyle
                                              .readexTextStyle12Regular(
                                            color: AppColors.colorEA580C,
                                          ).copyWith(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w600,
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
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
