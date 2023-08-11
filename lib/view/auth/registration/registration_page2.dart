import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_gradients.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/registration/registration_controller.dart';
import 'package:students/view/auth/registration/widgets/registration_app_bar.dart';
import 'package:students/view/auth/registration/widgets/registration_list_widget.dart';
import 'package:students/view/auth/registration/widgets/student_basic_details_bottomsheet.dart';
import 'package:students/widgets/common_app_image.dart';

class RegistrationPage2 extends GetView<RegistrationController> {
  const RegistrationPage2({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.selectedSchoolData.value.id);
    print(controller.arguments!.userInputLoginData);

    Map<dynamic, dynamic> newMap = controller.arguments!.userInputLoginData!;

    print(newMap);
    print(newMap['tempStudentId']);

    return WillPopScope(
      onWillPop: () async => controller.arguments?.isBackButtonEnabled ?? false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 8.h,
          ),
          child: Obx(
            () => Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomRegistrationAppBar(
                    isfromRegistrationLink:
                        controller.arguments?.isFromDynamicLink ?? false,
                    progress: 1.0,
                    isBackButton:
                        controller.arguments?.isBackButtonEnabled ?? false,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              CommonAppImage(
                                imagePath: AuthImageAssets.board,
                                width: 30.h,
                                height: 30.w,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                AppStrings.selectYourClassSection,
                                style: AppTextStyle.poppinsTextStyle18Regular(
                                  color: AppColors.gray800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                      Expanded(
                        child: AppClass().isShowLoading.isTrue
                            ? const SizedBox()
                            : const SingleChildScrollView(child: ListWidget()),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print(controller.arguments?.userInputLoginData);
                    if (controller.isClassSelected.isTrue) {
                      /// reset state of data input
                      controller.isSelectMale.value = false;
                      controller.isSelectFemale.value = false;
                      controller.nameController.value.clear();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w),
                          ),
                        ),
                        context: context,
                        builder: (_) => StudentBasicDetailsBottomSheetWidget(
                          userInputData:
                              controller.arguments?.userInputLoginData ?? {},
                          schoolId:
                              controller.selectedSchoolData.value.id ?? '',
                          // Original Code below
                          // schoolId: controller.arguments?.schoolId ?? '',
                          fromAddSchool:
                              controller.arguments?.isFromAddSchoolBtn ?? false,
                          isFromLoginAddSchool:
                              controller.arguments?.isFromLoginAddSchool ??
                                  false,
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    height: 40.h,
                    width: Utils.getScreenWidth,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        gradient: controller.isClassSelected.isTrue
                            ? AppGradients.blueDarkGradient
                            : AppGradients.grayGradient,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          controller.isClassSelected.isTrue
                              ? const BoxShadow(
                                  color: Color.fromRGBO(11, 55, 132, 0.2),
                                  blurRadius: 10.0,
                                )
                              : const BoxShadow(),
                        ]),
                    child: Text(
                      AppStrings.next,
                      style: AppTextStyle.poppinsTextStyle16Medium(
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
