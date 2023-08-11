import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';

class AddSchoolButton extends StatelessWidget {
  const AddSchoolButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // navigate to registration page 1
        Get.toNamed(
          AppRoutes.registrationPage1,
          arguments: AppDataModel(
            isBackButtonEnabled: true,
            isFromAddSchoolBtn: false,
            isFromLoginAddSchool: true,
            userInputLoginData: {},
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5.w),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: AppColors.blue600,
          borderRadius: BorderRadius.all(
            Radius.circular(6.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 2.w,
            ),
            const Icon(
              Icons.add,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              AppStrings.addSchool,
              style: AppTextStyle.poppinsTextStyle12SemiBold().copyWith(
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
