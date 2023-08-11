import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/forgot_password/forgot_password_controller.dart';
import 'package:students/view/auth/login/widgets/having_trouble_help.dart';
import 'package:students/widgets/common_app_button.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/common_app_otp_input.dart';
import 'package:students/widgets/common_back_button.dart';
import 'package:students/widgets/count_down_timer.dart';

class ForgotPasswordPage2 extends GetView<ForgotPasswordController> {
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
                AppStrings.verifyOTP,
                textAlign: TextAlign.center,
                style: AppTextStyle.poppinsTextStyle18Regular(color: AppColors.gray800),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    controller.emailController.text.trim(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.poppinsTextStyle16Regular(color: AppColors.color1554D1),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                      height: 22.w,
                      width: 22.w,
                      child: CommonAppImage(
                        imagePath: AuthImageAssets.editPencil,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 36.sp,
                width: Utils.getScreenWidth / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonAppOtpInput(
                      controller: controller.otp1TextController,
                      focusNode: controller.OTP1FocusNode,
                      autoFocus: true,
                      textInputAction: TextInputAction.next,
                      onChange: (v) {
                        if (v.length == 1) {
                          FocusScope.of(context).requestFocus(controller.OTP2FocusNode);
                        }
                      },
                    ),
                    CommonAppOtpInput(
                      controller: controller.otp2TextController,
                      focusNode: controller.OTP2FocusNode,
                      autoFocus: true,
                      textInputAction: TextInputAction.next,
                      onChange: (v) {
                        if (v.length == 1) {
                          FocusScope.of(context).requestFocus(controller.OTP3FocusNode);
                        } else if (v.isEmpty) {
                          FocusScope.of(context).requestFocus(controller.OTP1FocusNode);
                        }
                      },
                    ),
                    CommonAppOtpInput(
                      controller: controller.otp3TextController,
                      focusNode: controller.OTP3FocusNode,
                      autoFocus: true,
                      textInputAction: TextInputAction.next,
                      onChange: (v) {
                        if (v.length == 1) {
                          FocusScope.of(context).requestFocus(controller.OTP4FocusNode);
                        } else if (v.isEmpty) {
                          FocusScope.of(context).requestFocus(controller.OTP2FocusNode);
                        }
                      },
                    ),
                    CommonAppOtpInput(
                      controller: controller.otp4TextController,
                      focusNode: controller.OTP4FocusNode,
                      autoFocus: true,
                      textInputAction: TextInputAction.next,
                      onChange: (v) {
                        if (v.isEmpty) {
                          FocusScope.of(context).requestFocus(controller.OTP3FocusNode);
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !controller.isTimerCompleted.value
                        ? Row(
                            children: [
                              Container(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(AppStrings.resendCodeIn, style: AppTextStyle.poppinsTextStyle16Medium(color: AppColors.color808080)),
                              ),
                              CountDownTimer(
                                animation: StepTween(
                                  begin: controller.levelClock.value, // THIS IS A USER ENTERED NUMBER
                                  end: 0,
                                ).animate(controller.animationController.value),
                                callback: (timerValue, secondRem) => {
                                  if (secondRem == 0)
                                    {
                                      controller.animationController.value.stop(),
                                      WidgetsBinding.instance.addPostFrameCallback(
                                        (timeStamp) {
                                          controller.isTimerCompleted.value = true;
                                        },
                                      )
                                    }
                                },
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: controller.onResendEmailVerificationCode,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                color: controller.isTimerCompleted.value ? AppColors.blue30 : AppColors.color8E8E8E.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: AppColors.blue100),
                              ),
                              child: Text(
                                AppStrings.resendOTP,
                                style: AppTextStyle.poppinsTextStyle16Medium(
                                  color: controller.isTimerCompleted.value ? AppColors.blue600 : AppColors.color808080,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              CommonAppButton(
                title: AppStrings.verify,
                onTap: controller.onSubmitEmailVerifyCode,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
