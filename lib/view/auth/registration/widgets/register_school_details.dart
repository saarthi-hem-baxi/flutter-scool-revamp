import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/view/auth/registration/registration_controller.dart';
import 'package:students/widgets/common_app_image.dart';

class SelectedSchoolDetails extends StatelessWidget {
  SelectedSchoolDetails({super.key});

  final RegistrationController controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 40.h,
        ),
        SizedBox(
          width: 70.w,
          height: 70.h,
          child: CommonAppImage(
            imagePath: (controller.selectedSchoolData.value.logo?.isNotEmpty ?? false)
                ? controller.selectedSchoolData.value.logo ?? ''
                : AuthImageAssets.schoolPlaceholder,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: AppColors.gray20,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.gray200,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    controller.selectedSchoolData.value.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.poppinsTextStyle16Medium(color: AppColors.gray800),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    controller.selectedSchoolData.value.address?.city?.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray500),
                  )
                ],
              ),
            ),
            controller.editSchool.isTrue
                ? Positioned(
                    top: -1,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        controller.isSchoolSelected.value = false;
                        controller.findingSchool.value = false;
                      },
                      child: SizedBox(
                        child: CommonAppImage(
                          imagePath: AuthImageAssets.editPencil,
                          height: 17.w,
                          width: 17.w,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        )
      ],
    );
  }
}
