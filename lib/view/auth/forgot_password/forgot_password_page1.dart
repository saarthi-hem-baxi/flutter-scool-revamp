import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/view/auth/forgot_password/forgot_password_controller.dart';
import 'package:students/view/auth/login/widgets/having_trouble_help.dart';
import 'package:students/widgets/common_app_button.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/common_app_input_floating.dart';
import 'package:students/widgets/common_back_button.dart';

class ForgotPasswordPage1 extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 33.h,
          margin: EdgeInsets.only(bottom: 10.h),
          child: HavingTroubleHelpText(
            schoolId: controller.arguments.schoolId ?? '',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonBackButton(),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: [
                  Center(
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.lock,
                      width: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    AppStrings.enterYourEmail,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.poppinsTextStyle18Regular(color: AppColors.gray800),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.email,
                    ),
                  ),
                  Expanded(
                    child: CommonAppInputFloating(
                      controller: controller.emailController,
                      labelText: AppStrings.email,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CommonAppButton(
                title: AppStrings.sendOTP,
                onTap: controller.onSubmitEmailAddress,
              )
            ],
          ),
        )),
      ),
    );
  }
}
