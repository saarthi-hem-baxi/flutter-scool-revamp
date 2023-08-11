import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/login/login_controller.dart';
import 'package:students/view/auth/login/widgets/having_trouble_help.dart';
import 'package:students/view/auth/login/widgets/login_slider.dart';
import 'package:students/widgets/common_app_button.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/common_app_input_floating.dart';
import 'package:students/widgets/count_down_timer.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onScrollToBottom();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  physics: MediaQuery.of(context).viewInsets.bottom == 0 ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
                    height: Utils.getScreenHeight,
                    width: Utils.getScreenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.w),
                        Expanded(
                          child: Stack(
                            children: [
                              LoginSlider(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 26.w,
                                        width: 26.w,
                                        child: CommonAppImage(
                                          imagePath: AuthImageAssets.user,
                                        ),
                                      ),
                                      Expanded(
                                        child: Focus(
                                          onFocusChange: (v) {
                                            controller.isFocusOnLoginEmailPhone.value = !controller.isFocusOnLoginEmailPhone.value;
                                          },
                                          child: CommonAppInputFloating(
                                            controller: controller.emailorMobileController,
                                            labelText: AppStrings.mobileNumberOrEmail,
                                            onChange: (text) {
                                              if (text.isEmpty) {
                                                controller.changeOpacity(0.0);
                                                controller.isShowNextBtn.value = false;
                                              } else {
                                                if (controller.opacity != 1.0) {
                                                  controller.isShowNextBtn.value = true;
                                                }
                                              }
                                              controller.isNumberChanged.value = true;
                                            },
                                            onInputSubmit: (value) {
                                              controller.onEmailMobileNumberSubmit(value);
                                            },
                                            scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.opacity == 1.0
                                      ? AnimatedOpacity(
                                          opacity: controller.opacity.value,
                                          duration: const Duration(milliseconds: 200),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 26.h,
                                                    width: 26.w,
                                                    child: CommonAppImage(
                                                      imagePath: AuthImageAssets.unlock,
                                                    ),
                                                  ),
                                                  controller.loginType == LoginType.email
                                                      ? Expanded(
                                                          child: Focus(
                                                            onFocusChange: (v) {
                                                              controller.isFocusOnLoginOTPPassword.value =
                                                                  !controller.isFocusOnLoginOTPPassword.value;
                                                            },
                                                            child: CommonAppInputFloating(
                                                              obscureText: !controller.passwordVisible.value,
                                                              controller: controller.passwordController,
                                                              labelText: AppStrings.password,
                                                              onSuffixClick: () {
                                                                controller.passwordVisible.value = !controller.passwordVisible.value;
                                                              },
                                                              suffixIcon: controller.passwordVisible.value
                                                                  ? AuthImageAssets.passwordVisible
                                                                  : AuthImageAssets.passwordHide,
                                                              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                            ),
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Focus(
                                                            onFocusChange: (v) {
                                                              controller.isFocusOnLoginOTPPassword.value =
                                                                  !controller.isFocusOnLoginOTPPassword.value;
                                                            },
                                                            child: CommonAppInputFloating(
                                                              maxLength: 4,
                                                              controller: controller.otpController,
                                                              labelText: AppStrings.otp,
                                                              keyboardType: TextInputType.numberWithOptions(),
                                                              regExp: RegExp(r'[0-9]'),
                                                              onChange: (text) {
                                                                if (text.length >= 4) {
                                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                                }
                                                              },
                                                              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              controller.loginType == LoginType.email
                                                  ? Container(
                                                      margin: const EdgeInsets.only(top: 5),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: controller.navigateToForgotPaswordScreen,
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.blue30,
                                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                border: Border.all(width: 1, color: AppColors.blue100),
                                                              ),
                                                              child: Text(
                                                                AppStrings.forgotPasword,
                                                                style: AppTextStyle.poppinsTextStyle16Medium(color: AppColors.blue600),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      margin: const EdgeInsets.only(top: 15),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          !controller.timerComplete.value
                                                              ? Row(
                                                                  children: [
                                                                    Container(
                                                                      alignment: AlignmentDirectional.topStart,
                                                                      child: Text(
                                                                        AppStrings.resendCodeIn,
                                                                        style: AppTextStyle.poppinsTextStyle14SemiBold(color: AppColors.color808080),
                                                                      ),
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
                                                                                controller.timerComplete.value = true;
                                                                              },
                                                                            )
                                                                          }
                                                                      },
                                                                    ),
                                                                  ],
                                                                )
                                                              : InkWell(
                                                                  onTap: controller.onResendOTP,
                                                                  child: Container(
                                                                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          controller.timerComplete.isTrue ? AppColors.blue30 : AppColors.color8E8E8E,
                                                                      borderRadius: const BorderRadius.all(
                                                                        Radius.circular(10),
                                                                      ),
                                                                      border: Border.all(
                                                                        width: 1,
                                                                        color: AppColors.blue100,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      AppStrings.resendOTP,
                                                                      style: AppTextStyle.poppinsTextStyle16Medium(
                                                                        color: controller.timerComplete.isTrue
                                                                            ? AppColors.blue600
                                                                            : AppColors.color808080,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                              CommonAppButton(
                                                title: AppStrings.getStarted,
                                                onTap: () {
                                                  controller.submitForm(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                  controller.isShowNextBtn.isTrue
                                      ? CommonAppButton(
                                          title: AppStrings.next,
                                          onTap: () {
                                            controller.onEmailMobileNumberSubmit(controller.emailorMobileController.text);
                                          },
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              HavingTroubleHelpText(schoolId: ''),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
