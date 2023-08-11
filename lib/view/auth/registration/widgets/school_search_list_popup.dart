import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/registration/registration_controller.dart';
import 'package:students/view/auth/registration/widgets/registration_school_list_tile.dart';
import 'package:students/widgets/loading_spinner.dart';
import 'package:students/widgets/no_data_found_text.dart';

class SchoolSearchListPopUp extends StatelessWidget {
  final RegistrationController controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSchoolSelected.isTrue) {
        return SizedBox();
      } else if (controller.findingSchool.isTrue) {
        return LoadingSpinner();
      } else if (controller.allSchoolList.isNotEmpty) {
        return Expanded(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxHeight: Utils.getScreenWidth / 2),
              margin: EdgeInsets.only(bottom: 35.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.gray300,
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.color292929.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...controller.allSchoolList.map((item) {
                      return RegistrtionSchoolListTile(
                        onTap: () {
                          controller.isSchoolSelected.value = true;
                          controller.selectedSchoolData.value = item;
                        },
                        schoolLogoUrl: item.logoThumb ?? '',
                        title: item.name ?? '',
                        highlightText: controller.searchSchoolTextController.value.text.trim(),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (controller.allSchoolList.isNotEmpty) {
        return const NoDataFoundText(title: AppStrings.schoolNotFound);
      } else {
        return SizedBox();
      }
    });
  }
}
