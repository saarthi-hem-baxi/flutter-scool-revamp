import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class ForgotPasswordPage3 extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage3({super.key});

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
                      imagePath: AuthImageAssets.password,
                      width: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    AppStrings.enterNewPassword,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.poppinsTextStyle18Regular(color: AppColors.gray800),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                children: [
                  CommonAppImage(
                    imagePath: AuthImageAssets.unlock,
                    height: 30.h,
                    width: 30.w,
                  ),
                  Obx(
                    () => Expanded(
                      child: Focus(
                        onFocusChange: (v) {
                          controller.isFocusPassword1.value = !controller.isFocusPassword1.value;
                        },
                        child: CommonAppInputFloating(
                          obscureText: !controller.password1Visible.value,
                          controller: controller.password1TextController,
                          labelText: AppStrings.newPassword,
                          onSuffixClick: () {
                            controller.password1Visible.value = !controller.password1Visible.value;
                          },
                          suffixIcon: controller.password1Visible.value ? AuthImageAssets.passwordVisible : AuthImageAssets.passwordHide,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CommonAppImage(
                    imagePath: AuthImageAssets.unlock,
                    height: 30.h,
                    width: 30.w,
                  ),
                  Obx(
                    () => Expanded(
                      child: Focus(
                        onFocusChange: (v) {
                          controller.isFocusPassword2.value = !controller.isFocusPassword2.value;
                        },
                        child: CommonAppInputFloating(
                          obscureText: !controller.password2Visible.value,
                          controller: controller.password2TextController,
                          labelText: AppStrings.confirmNewPassword,
                          onSuffixClick: () {
                            controller.password2Visible.value = !controller.password2Visible.value;
                          },
                          suffixIcon: controller.password2Visible.value ? AuthImageAssets.passwordVisible : AuthImageAssets.passwordHide,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              CommonAppButton(
                title: AppStrings.submit,
                onTap: controller.onSubmitNewPassword,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
