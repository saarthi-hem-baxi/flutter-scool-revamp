import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class PasswordResetToast {
  void showMesasge() {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.colorCBFBE7,
        margin: EdgeInsets.all(16.w),
        borderRadius: 10,
        duration: Duration(seconds: 3),
        isDismissible: true,
        snackStyle: SnackStyle.FLOATING,
        messageText: Row(
          children: [
            CommonAppImage(
              imagePath: AuthImageAssets.toastRight,
              width: 20.w,
              height: 20.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              AppStrings.yourPasswordHasBeenResetSuccessfully,
              style: AppTextStyle.poppinsTextStyle14Regular(
                color: AppColors.gray600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
