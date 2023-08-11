import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/login/login_controller.dart';
import 'package:students/view/auth/login/widgets/having_trouble_help.dart';
import 'package:students/view/auth/login/widgets/multi_auth_sheet.dart';
import 'package:students/view/auth/registration/registration_with_link_controller.dart';
import 'package:students/widgets/common_app_button.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/common_app_input_floating.dart';
import 'package:students/widgets/count_down_timer.dart';

class DynamiLinkLogin extends GetView<RegistrationWithLinkController> {
  DynamiLinkLogin({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Obx(
              () => AppClass().isShowLoading.isTrue
                  ? const Center(
                      child: SizedBox(),
                    )
                  : Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            SizedBox(
                              height: 30.h,
                              width: 100.w,
                              child: CommonAppImage(
                                imagePath: AppImageAssets.splashLogo,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Center(
                              child: Text(
                                AppStrings.speciallyDesignedFor,
                                style: AppTextStyle.poppinsTextStyle12Medium(
                                        color: AppColors.gray400)
                                    .copyWith(letterSpacing: 6),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Center(
                              child: Container(
                                // width: 100.w,
                                height: 80.h,
                                padding: EdgeInsets.all(5.w),
                                child: CommonAppImage(
                                  imagePath: (loginController
                                                  .schoolData['logoThumb'] ??
                                              '')
                                          .toString()
                                          .isNotEmpty
                                      ? controller.schoolData['logoThumb'] ?? ''
                                      : AuthImageAssets.schoolPlaceholder,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Center(
                              child: Text(
                                loginController.schoolData['name'] ?? '',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.poppinsTextStyle16Medium(
                                    color: AppColors.gray800),
                              ),
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.manual,
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
                                          controller.isFocusEmailMobile.value =
                                              !controller
                                                  .isFocusEmailMobile.value;
                                        },
                                        child: CommonAppInputFloating(
                                          controller: controller
                                              .emailorMobileController,
                                          labelText:
                                              AppStrings.mobileNumberOrEmail,
                                          onChange: (text) {
                                            if (text.isEmpty) {
                                              controller.changeOpacity(0.0);
                                              controller.isShowNext.value =
                                                  false;
                                            } else {
                                              if (controller.opacity != 1.0) {
                                                controller.isShowNext.value =
                                                    true;
                                              }
                                            }
                                            controller.isNumberChanged.value =
                                                true;
                                          },
                                          onInputSubmit: (value) {
                                            controller
                                                .emailMobileNumberSubmit(value);
                                          },
                                          scrollPadding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                controller.opacity == 1.0
                                    ? AnimatedOpacity(
                                        opacity: controller.opacity,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 26.h,
                                                  width: 26.w,
                                                  child: CommonAppImage(
                                                    imagePath:
                                                        AuthImageAssets.unlock,
                                                  ),
                                                ),
                                                loginController.loginType ==
                                                        LoginType.email
                                                    ? Expanded(
                                                        child: Focus(
                                                          onFocusChange: (v) {
                                                            controller
                                                                    .isFocusPassword
                                                                    .value =
                                                                !controller
                                                                    .isFocusPassword
                                                                    .value;
                                                          },
                                                          child:
                                                              CommonAppInputFloating(
                                                            obscureText: !controller
                                                                .passwordVisible
                                                                .value,
                                                            controller: controller
                                                                .passwordController,
                                                            labelText:
                                                                AppStrings
                                                                    .password,
                                                            onSuffixClick: () {
                                                              controller
                                                                      .passwordVisible
                                                                      .value =
                                                                  !controller
                                                                      .passwordVisible
                                                                      .value;
                                                            },
                                                            suffixIcon: controller
                                                                    .passwordVisible
                                                                    .value
                                                                ? AuthImageAssets
                                                                    .passwordVisible
                                                                : AuthImageAssets
                                                                    .passwordHide,
                                                            scrollPadding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                          ),
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: Focus(
                                                          onFocusChange: (v) {
                                                            controller
                                                                    .isFocusPassword
                                                                    .value =
                                                                !controller
                                                                    .isFocusPassword
                                                                    .value;
                                                          },
                                                          child:
                                                              CommonAppInputFloating(
                                                            maxLength: 4,
                                                            controller: controller
                                                                .otpController,
                                                            labelText:
                                                                AppStrings.otp,
                                                            keyboardType:
                                                                TextInputType
                                                                    .numberWithOptions(),
                                                            regExp: RegExp(
                                                                r'[0-9]'),
                                                            onChange: (text) {
                                                              if (text.length >=
                                                                  4) {
                                                                FocusScope.of(
                                                                        context)
                                                                    .requestFocus(
                                                                        FocusNode());
                                                              }
                                                            },
                                                            scrollPadding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            loginController.loginType ==
                                                    LoginType.email
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap:
                                                              _onForgotPassword,
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        14.w,
                                                                    vertical:
                                                                        2.h),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .blue30,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColors
                                                                      .blue100),
                                                            ),
                                                            child: Text(
                                                              AppStrings
                                                                  .forgotPasword,
                                                              style: AppTextStyle
                                                                  .poppinsTextStyle16Medium(
                                                                      color: AppColors
                                                                          .blue600),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        !controller
                                                                .timerComplete
                                                                .value
                                                            ? Row(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .topStart,
                                                                    child: Text(
                                                                      AppStrings
                                                                          .resendCodeIn,
                                                                      style: AppTextStyle.poppinsTextStyle14SemiBold(
                                                                          color:
                                                                              AppColors.color808080),
                                                                    ),
                                                                  ),
                                                                  CountDownTimer(
                                                                    animation:
                                                                        StepTween(
                                                                      begin: controller
                                                                          .levelClock
                                                                          .value, // THIS IS A USER ENTERED NUMBER
                                                                      end: 0,
                                                                    ).animate(controller
                                                                            .animationController
                                                                            .value),
                                                                    callback:
                                                                        (timerValue,
                                                                                secondRem) =>
                                                                            {
                                                                      if (secondRem ==
                                                                          0)
                                                                        {
                                                                          controller
                                                                              .animationController
                                                                              .value
                                                                              .stop(),
                                                                          WidgetsBinding
                                                                              .instance
                                                                              .addPostFrameCallback(
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
                                                                onTap:
                                                                    _onResendCode,
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          14.w,
                                                                      vertical:
                                                                          2.h),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: controller
                                                                            .timerComplete
                                                                            .isTrue
                                                                        ? AppColors
                                                                            .blue30
                                                                        : AppColors
                                                                            .color8E8E8E,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          10),
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 1,
                                                                      color: AppColors
                                                                          .blue100,
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    AppStrings
                                                                        .resendOTP,
                                                                    style: AppTextStyle
                                                                        .poppinsTextStyle16Medium(
                                                                      color: controller
                                                                              .timerComplete
                                                                              .isTrue
                                                                          ? AppColors
                                                                              .blue600
                                                                          : AppColors
                                                                              .color808080,
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
                                                submitForm(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                                controller.isShowNext.isTrue
                                    ? CommonAppButton(
                                        title: AppStrings.next,
                                        onTap: () {
                                          controller.emailMobileNumberSubmit(
                                              controller.emailorMobileController
                                                  .text);
                                        },
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        HavingTroubleHelpText(schoolId: ''),
                        SizedBox(height: 10.h),
                      ],
                    ),
            )),
      ),
    );
  }

  void _onForgotPassword() {
    Get.toNamed(
      AppRoutes.forgotPasswordPage,
      arguments: AppDataModel(
        email: controller.emailorMobileController.text.trim(),
        isFromDynamicLink: true,
        schoolId: controller.arguments.schoolId,
      ),
    );
  }

  void _onResendCode() {
    if (controller.timerComplete.value) {
      if (loginController.loginType == LoginType.phone) {
        loginController
            .contactResendOTP(
                contact:
                    controller.emailorMobileController.text.trim().toString())
            .then((value) {
          resetAll();
        });
      }
    }
  }

  void resetAll() {
    controller.timerComplete = false.obs;
    controller.animationController = AnimationController(
      vsync: controller,
      duration: Duration(
        seconds: controller.levelClock.value,
      ),
    ).obs;

    controller.animationController.value.forward();
    controller.otpController.text = '';
  }

  void submitForm(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (loginController.loginType == LoginType.email) {
      bool passwordVal = Utils.checkPasswordvalidation(
          password: controller.passwordController.text,
          confirmPassword: controller.passwordController.text);

      if (!controller.emailorMobileController.text.isEmail) {
        Fluttertoast.showToast(msg: AppStrings.invalidEmailAddress);
      } else if (passwordVal) {
        controller
            .loginWithEmailDynamicLink(
          email: controller.emailorMobileController.text.trim(),
          password: controller.passwordController.text.trim(),
          schoolId: controller.arguments.schoolId,
        )
            .then((v) {
          if (v) {
            if (controller.isAlreadyRegistered.isTrue) {
              loginController
                  .loginWithEmail(
                email: controller.emailorMobileController.text.trim(),
                password: controller.passwordController.text.trim(),
              )
                  .then((v) {
                if (v) {
                  if (controller.tempUserId.isEmpty) {
                    MultiAuthBottomSheet().showMultiAuthSheet();

                    // showMultiAuthSheet(loginController: loginController, context: context);
                  } else {
                    var data = {
                      'email':
                          controller.emailorMobileController.text.toString(),
                      'password': controller.passwordController.text.toString(),
                      'tempSchoolUserId': controller.tempUserId.toString()
                    };
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RegistrationScreen2(
                    //       userInputData: data,
                    //       fromAddSchool: false,
                    //       fromRegitrationLink: false,
                    //     ),
                    //   ),
                    // );
                    Get.toNamed(
                      AppRoutes.registrationPage1,
                      arguments: AppDataModel(
                        schoolId: controller.arguments.schoolId,
                        userInputLoginData: data,
                        isFromAddSchoolBtn: false,
                        isFromDynamicLink: false,
                        isBackButtonEnabled: false,
                        isFromLoginAddSchool: false,
                      ),
                    );
                  }
                }
              });
            } else {
              var data = {
                'email': controller.emailorMobileController.text.toString(),
                'password': controller.passwordController.text.toString(),
                'tempSchoolUserId': controller.tempUserId.toString()
              };
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RegistrationScreen3(
              //       userInputData: data,
              //       fromAddSchool: false,
              //       schoolId: widget.schoolId,
              //       fromRegitrationLink: true,
              //     ),
              //   ),
              // );
              Get.toNamed(
                AppRoutes.registrationPage2,
                arguments: AppDataModel(
                  userInputLoginData: data,
                  schoolId: controller.arguments.schoolId,
                  isFromDynamicLink: true,
                  isFromLoginAddSchool: false,
                  isBackButtonEnabled: false,
                ),
              );
            }
          }
        });
      }
    } else {
      loginController
          .verifyLoginOTP(
              contact: controller.emailorMobileController.text,
              otp: controller.otpController.text)
          .then((value) {
        if (value) {
          String otpValue = controller.otpController.text.trim();
          if (otpValue.isEmpty) {
            Fluttertoast.showToast(msg: AppStrings.otpRequired);
          } else {
            if ((loginController.userModal.value.users ?? []).isNotEmpty) {
              // showMultiAuthSheet(loginController: loginController, context: context);
              MultiAuthBottomSheet().showMultiAuthSheet();
            } else {
              Map data = {
                'contact': controller.emailorMobileController.text,
                'loginOTP': int.parse(controller.otpController.text.toString()),
                'tempSchoolUserId': controller.tempUserId.toString()
              };
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RegistrationScreen3(
              //       userInputData: data,
              //       fromAddSchool: false,
              //       schoolId: widget.schoolId,
              //       fromRegitrationLink: true,
              //     ),
              //   ),
              // );
              Get.toNamed(
                AppRoutes.registrationPage2,
                arguments: AppDataModel(
                  userInputLoginData: data,
                  schoolId: controller.arguments.schoolId,
                  isFromDynamicLink: true,
                  isFromLoginAddSchool: true,
                  isFromAddSchoolBtn: false,
                  isBackButtonEnabled: false,
                ),
              );
            }
          }
        }
      });
    }
  }
}
