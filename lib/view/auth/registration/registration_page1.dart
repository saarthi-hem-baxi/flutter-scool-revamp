import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/view/auth/registration/registration_controller.dart';
import 'package:students/view/auth/registration/widgets/city_search_list_popup.dart';
import 'package:students/view/auth/registration/widgets/register_school_details.dart';
import 'package:students/view/auth/registration/widgets/registration_app_bar.dart';
import 'package:students/view/auth/registration/widgets/school_search_list_popup.dart';
import 'package:students/widgets/common_app_button.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/common_app_input.dart';

class RegistrationPage1 extends GetView<RegistrationController> {
  RegistrationPage1({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    Map<dynamic, dynamic> tempStudentMap =
        controller.arguments!.userInputLoginData!;
    var tempStudentId = tempStudentMap['tempStudentId'];
    print('LINE 32 REG1 : $tempStudentId');
    return WillPopScope(
      onWillPop: () async => controller.arguments?.isBackButtonEnabled ?? false,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(
              () {
                return AppClass().isShowLoading.isTrue
                    ? const SizedBox()
                    : Column(
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                controller.arguments?.isSingleSchoolUser == true
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20.h),
                                          SizedBox(
                                            height: 30.h,
                                            width: 100.w,
                                            child: CommonAppImage(
                                              imagePath:
                                                  AppImageAssets.splashLogo,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 40.h),
                                          Center(
                                            child: Text(
                                              AppStrings.speaciallyDesignFor,
                                              style: AppTextStyle
                                                      .poppinsTextStyle12Regular()
                                                  .copyWith(
                                                color: AppColors.gray400,
                                                letterSpacing: 6,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 40.h),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          CustomRegistrationAppBar(
                                            isfromRegistrationLink: false,
                                            progress: 0.5,
                                            isBackButton: controller.arguments
                                                    ?.isBackButtonEnabled ??
                                                false,
                                          ),
                                          CommonAppImage(
                                            imagePath:
                                                AuthImageAssets.handShake,
                                            height: 30.h,
                                            width: 30.h,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            AppStrings
                                                .letsStartYourRegistration,
                                            style: AppTextStyle
                                                .poppinsTextStyle18Medium(
                                                    color: AppColors.gray800),
                                          ),
                                          SizedBox(
                                            height: 40.h,
                                          ),
                                          SizedBox(
                                            height: 60.w,
                                            width: 60.w,
                                            child: CommonAppImage(
                                                imagePath:
                                                    AuthImageAssets.school),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                        ],
                                      ),

                                Column(
                                  children: [
                                    controller.arguments?.isSingleSchoolUser ==
                                            true
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              CommonAppImage(
                                                imagePath:
                                                    AuthImageAssets.building,
                                                width: 26.w,
                                                height: 26.w,
                                              ),
                                              SizedBox(
                                                width: controller
                                                        .isCitySelected.isTrue
                                                    ? 20.w
                                                    : 10.w,
                                              ),
                                              controller.isCitySelected.isTrue
                                                  ? Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '${controller.selectedCityName.value}, ${controller.selectedStateName.value}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyle
                                                                  .poppinsTextStyle16Regular(
                                                                      color: AppColors
                                                                          .gray700),
                                                            ),
                                                          ),
                                                          controller.editSchool
                                                                  .isTrue
                                                              ? Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      controller
                                                                          .isCitySelected
                                                                          .value = false;
                                                                      controller
                                                                          .findingCity
                                                                          .value = false;
                                                                      controller
                                                                          .isSchoolSelected
                                                                          .value = false;
                                                                      controller
                                                                          .findingSchool
                                                                          .value = false;
                                                                      controller
                                                                          .allSchoolList
                                                                          .value = [];
                                                                    },
                                                                    child:
                                                                        CommonAppImage(
                                                                      imagePath:
                                                                          AuthImageAssets
                                                                              .editPencil,
                                                                      width:
                                                                          17.w,
                                                                      height:
                                                                          17.w,
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    )
                                                  // Start city search bar input
                                                  : Expanded(
                                                      child: SizedBox(
                                                        height: 38.h,
                                                        child: Focus(
                                                          onFocusChange:
                                                              (hasFocus) {
                                                            if (hasFocus) {
                                                              controller
                                                                      .citySearchBgColor
                                                                      .value =
                                                                  AppColors
                                                                      .gray50;
                                                            } else {
                                                              controller
                                                                      .citySearchBgColor
                                                                      .value =
                                                                  AppColors
                                                                      .gray25;
                                                            }
                                                          },
                                                          child: CommonAppInput(
                                                            style: AppTextStyle
                                                                .poppinsTextStyle14Medium(
                                                                    color: AppColors
                                                                        .gray500),
                                                            controller: controller
                                                                .searchCityTextController,
                                                            fillColor: controller
                                                                .citySearchBgColor
                                                                .value,
                                                            hintText: AppStrings
                                                                .searchYourCity,
                                                            prefixIcon:
                                                                AuthImageAssets
                                                                    .search,
                                                            suffixIcon: controller
                                                                        .searchCityText
                                                                        .value
                                                                        .isNotEmpty &&
                                                                    controller
                                                                        .searchCityTextController
                                                                        .text
                                                                        .trim()
                                                                        .isNotEmpty
                                                                ? Icons.close
                                                                : null,
                                                            onSuffixClick: () {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                controller
                                                                    .searchCityText
                                                                    .value = '';
                                                                controller
                                                                    .searchCityTextController
                                                                    .clear();
                                                                controller
                                                                    .isCitySelected
                                                                    .value = false;
                                                                controller
                                                                    .findingCity
                                                                    .value = false;
                                                                controller
                                                                    .allCityList
                                                                  ..clear();
                                                                controller
                                                                    .allSchoolList
                                                                    .clear();
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              });
                                                            },
                                                            onChanged:
                                                                (string) {
                                                              String value =
                                                                  string.trim();
                                                              controller
                                                                  .searchCityText
                                                                  .value = value;
                                                              if (controller
                                                                      .debounceTimer
                                                                      ?.isActive ??
                                                                  false)
                                                                controller
                                                                    .debounceTimer
                                                                    ?.cancel();
                                                              controller
                                                                      .debounceTimer =
                                                                  Timer(
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                      () {
                                                                if (value
                                                                    .isNotEmpty) {
                                                                  controller.getCities(
                                                                      cityName:
                                                                          string
                                                                              .trim());
                                                                } else {
                                                                  controller
                                                                      .allCityList
                                                                      .clear();
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          autofocus: true,
                                                        ),
                                                      ),
                                                    ),
                                              // end city search bar input
                                            ],
                                          ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),

                                CitySearchListPopUp(),
                                // start city & state list modal
                                SizedBox(
                                  height: 10.h,
                                ),

                                // end city & state list modal
                                // start display of selected school details
                                !controller.isCitySelected.value
                                    ? const SizedBox()
                                    : controller.isSchoolSelected.isTrue
                                        ? SelectedSchoolDetails()
                                        // end display of selected school details
                                        // Start school search bar input
                                        : SizedBox(
                                            height: 38.h,
                                            child: Focus(
                                              onFocusChange: (hasFocus) {
                                                if (hasFocus) {
                                                  controller.schoolSearchBgColor
                                                      .value = AppColors.gray50;
                                                } else {
                                                  controller.schoolSearchBgColor
                                                      .value = AppColors.gray25;
                                                }
                                              },
                                              child: CommonAppInput(
                                                style: AppTextStyle
                                                    .poppinsTextStyle14Medium(
                                                        color:
                                                            AppColors.gray500),
                                                controller: controller
                                                    .searchSchoolTextController
                                                    .value,
                                                fillColor: controller
                                                    .schoolSearchBgColor.value,
                                                hintText:
                                                    AppStrings.searchYourSchool,
                                                prefixIcon:
                                                    AuthImageAssets.search,
                                                suffixIcon: controller
                                                        .searchSchoolText
                                                        .value
                                                        .isNotEmpty
                                                    ? Icons.close
                                                    : null,
                                                onSuffixClick: () {
                                                  Future.delayed(Duration.zero,
                                                      () {
                                                    controller.searchSchoolText
                                                        .value = '';
                                                    controller
                                                        .searchSchoolTextController
                                                        .value
                                                        .clear();
                                                    controller.isSchoolSelected
                                                        .value = false;
                                                    controller.allSchoolList
                                                        .clear();
                                                    controller.findingSchool
                                                        .value = false;
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  });
                                                },
                                                onChanged: (string) {
                                                  String query = string.trim();
                                                  controller.searchSchoolText
                                                      .value = query;
                                                  if (controller.debounceTimer
                                                          ?.isActive ??
                                                      false)
                                                    controller.debounceTimer
                                                        ?.cancel();
                                                  controller.debounceTimer =
                                                      Timer(
                                                          const Duration(
                                                              seconds: 1), () {
                                                    if (query.isNotEmpty) {
                                                      controller.getSchools(
                                                        cityName: controller
                                                            .selectedCityId
                                                            .trim(),
                                                        schoolName: query,
                                                        stateId: controller
                                                            .selectedStateID
                                                            .value,
                                                      );
                                                    } else {
                                                      controller.allSchoolList
                                                          .clear();
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                // end school search bar input
                                SizedBox(
                                  height: 10.h,
                                ),
                                SchoolSearchListPopUp(),
                              ],
                            ),
                          ),
                          // end school list modal

                          controller.isSchoolSelected.isTrue
                              ? CommonAppButton(
                                  title: AppStrings.next,
                                  onTap: controller.onRegistration1Submit,
                                )
                              : controller.arguments?.isFromAddSchoolBtn == true
                                  ? const SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppStrings
                                                .alreadyGrowingWithSaarthi,
                                            style: AppTextStyle
                                                .poppinsTextStyle14Regular(
                                              color: AppColors.gray600,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          GestureDetector(
                                            onTap: (() {
                                              controller.navigateToLogin();
                                            }),
                                            child: Text(
                                              AppStrings.login,
                                              style: AppTextStyle
                                                  .poppinsTextStyle18Medium(
                                                      color: AppColors.gray800),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          SizedBox(height: 10.h)
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
