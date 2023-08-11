import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/view/auth/registration/registration_controller.dart';
import 'package:students/widgets/common_app_button.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/common_app_input_floating.dart';

class StudentBasicDetailsBottomSheetWidget extends StatelessWidget {
  StudentBasicDetailsBottomSheetWidget({
    Key? key,
    required this.userInputData,
    required this.schoolId,
    required this.fromAddSchool,
    this.isFromLoginAddSchool,
  }) : super(key: key);

  final Map userInputData;
  final String schoolId;
  final bool fromAddSchool;
  final bool? isFromLoginAddSchool;

  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    var schoolId = controller.selectedSchoolData.value.id;

    print('LINE 33 : $userInputData');
    // print(controller.selectedSchoolData.value.id);
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 16.w,
            top: 26.h,
            bottom: 16.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w),
              topRight: Radius.circular(20.w),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: SizedBox(
                          height: 10.h,
                          width: 10.w,
                          child: CommonAppImage(
                              imagePath: AuthImageAssets.closeIcon),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.selectGender,
                        style: AppTextStyle.poppinsTextStyle14Regular(
                            color: AppColors.gray400),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.isSelectMale.value = true;
                                controller.isSelectFemale.value = false;
                              },
                              child: Container(
                                width: 60.w,
                                height: 60.w,
                                padding:
                                    EdgeInsets.fromLTRB(2.w, 8.h, 2.w, 0.h),
                                decoration: BoxDecoration(
                                  color: AppColors.colorFFFAFF,
                                  shape: BoxShape.circle,
                                  border: controller.isSelectMale.isTrue
                                      ? Border.all(
                                          color: AppColors.colorA93AFF,
                                          width: 2.w)
                                      : Border.all(
                                          color: AppColors.colorFFDDFD,
                                          width: 1.w),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(300.0),
                                  child: CommonAppImage(
                                      imagePath: AuthImageAssets.boyIcon),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.isSelectMale.value = false;
                                controller.isSelectFemale.value = true;
                              },
                              child: Container(
                                width: 60.w,
                                height: 60.w,
                                padding:
                                    EdgeInsets.fromLTRB(2.w, 8.h, 2.w, 0.h),
                                decoration: BoxDecoration(
                                  color: AppColors.colorFFFAFF,
                                  shape: BoxShape.circle,
                                  border:
                                      controller.isSelectFemale.value == true
                                          ? Border.all(
                                              color: AppColors.color0F94FF,
                                              width: 2.w)
                                          : Border.all(
                                              color: AppColors.color1554D1,
                                              width: 1.w),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(300.0),
                                  child: CommonAppImage(
                                    imagePath: AuthImageAssets.girlIcon,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Focus(
                        onFocusChange: (v) {
                          controller.isFocusOnFullName.value =
                              !controller.isFocusOnFullName.value;
                        },
                        child: CommonAppInputFloating(
                          fillColor: Colors.white,
                          controller: controller.nameController.value,
                          labelText: AppStrings.fullName,
                          floatingLabelStyle:
                              AppTextStyle.poppinsTextStyle18Regular(
                                  color: AppColors.gray400),
                          labelStyle: AppTextStyle.poppinsTextStyle16Regular(
                              color: AppColors.gray400),
                          enableBorderColor: AppColors.gray600,
                          scrollPadding: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CommonAppButton(
                title: AppStrings.submit,
                onTap: () {
                  print(controller.arguments);
                  if (controller.arguments?.isFromAddSchoolBtn == true) {
                    //  Original
                    //  controller.onTapAddSchoolBtn(schoolId: schoolId);
                    controller.onTapAddSchoolBtn(
                        schoolId: controller.selectedSchoolData.value.id!);
                  } else {
                    controller.onRegistrationPage2Submit(
                      schoolId: controller.selectedSchoolData.value.id!,
                      tempStudentId: userInputData['tempStudentId']!,
                    );
                    // below original
                    // controller.onRegistrationPage2Submit(schoolId: schoolId);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
