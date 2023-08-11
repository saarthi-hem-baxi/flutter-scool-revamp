import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/helpers/network.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/models/auth/reset_token.dart';
import 'package:students/view/auth/forgot_password/widgets/password_reset_toast.dart';

class ForgotPasswordController extends GetxController with GetTickerProviderStateMixin {
  APIClient apiClient = APIClient();
  late AppDataModel arguments;
  TextEditingController emailController = TextEditingController();

  //ForgotPassword Page2
  final TextEditingController otp1TextController = TextEditingController();
  final TextEditingController otp2TextController = TextEditingController();
  final TextEditingController otp3TextController = TextEditingController();
  final TextEditingController otp4TextController = TextEditingController();

  final FocusNode OTP1FocusNode = FocusNode();
  final FocusNode OTP2FocusNode = FocusNode();
  final FocusNode OTP3FocusNode = FocusNode();
  final FocusNode OTP4FocusNode = FocusNode();

  RxBool isTimerCompleted = false.obs;
  RxInt levelClock = 120.obs;
  late Rx<AnimationController> animationController;
  String resetToken = '';

  //ForgotPassword Page3

  //Here [password1 -> password] & [password2 -> confirm password]

  final TextEditingController password1TextController = TextEditingController();
  final TextEditingController password2TextController = TextEditingController();

  RxBool password1Visible = false.obs;
  RxBool password2Visible = false.obs;
  RxBool isFocusPassword1 = false.obs;
  RxBool isFocusPassword2 = false.obs;

  @override
  void onInit() {
    super.onInit();
    levelClock.value = 120;
    arguments = Get.arguments as AppDataModel;
    emailController.text = arguments.email ?? '';

    //initlize animation controller forgot password page 2
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock.value,
      ),
    ).obs;

    animationController.value.forward();
  }

  RxBool isFocusOnEmailField = false.obs;

  // Invoke when tap [Sent OTP] button from forgot password page 1
  void onSubmitEmailAddress() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Fluttertoast.showToast(msg: AppStrings.emailRequired);
    } else if (!email.isEmail) {
      Fluttertoast.showToast(msg: AppStrings.invalidEmailAddress);
    } else {
      sendEmailVarificationCode(email: email);
    }
  }

  // invoke this method whenyser tap of resend email verification code btn
  void onResendEmailVerificationCode() {
    if (isTimerCompleted.isTrue) {
      forgotPassWordPage2ResetAll();
      sendEmailVarificationCode(email: emailController.text.trim());
    }
  }

  // invoke this method for reset value of state to it's default value
  void forgotPassWordPage2ResetAll() {
    animationController.value = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock.value,
      ),
    );
    animationController.value.forward();
    otp1TextController.clear();
    otp2TextController.clear();
    otp3TextController.clear();
    otp4TextController.clear();
    isTimerCompleted.value = false;
    levelClock.value = 120;
    OTP1FocusNode.unfocus();
    Future.delayed(Duration.zero, () {
      OTP1FocusNode.requestFocus();
    });
  }

  // Invoke when tap on [Verify] btn from Forgot password page 2
  void onSubmitEmailVerifyCode() {
    String otpText1 = otp1TextController.text.trim();
    String otpText2 = otp2TextController.text.trim();
    String otpText3 = otp3TextController.text.trim();
    String otpText4 = otp4TextController.text.trim();

    if (otpText1.isEmpty || otpText2.isEmpty || otpText3.isEmpty || otpText4.isEmpty) {
      Fluttertoast.showToast(msg: AppStrings.otpRequired);
    } else {
      verifyEmailOTP(
        email: emailController.text.trim(),
        otp: '${otpText1}${otpText2}${otpText3}${otpText4}',
      );
      forgotPassWordPage2ResetAll();
    }
  }

  // invoke when i submit form from Forgot password page 3
  void onSubmitNewPassword() {
    if (Utils.checkPasswordvalidation(
      password: password1TextController.text.trim(),
      confirmPassword: password2TextController.text.trim(),
    )) {
      resetAndSaveNewPassword(
        email: emailController.text.trim(),
        password: password1TextController.text.trim(),
        resetToken: resetToken,
      );
    }
  }

  // invoke this method for reset value of state to it's default value
  void forgotPasswordPage3ResetAll() {
    password1TextController.clear();
    password2TextController.clear();
    password1Visible.value = false;
    password2Visible.value = false;
    isFocusPassword1.value = false;
    isFocusPassword2.value = false;
  }

  // call api for send verification code on email
  Future sendEmailVarificationCode({required String email}) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.postData(
        url: APIUrls().authUrl + 'forgot-password/send-otp',
        data: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: AppStrings.otpsentSuccessfully);
        forgotPassWordPage2ResetAll();
        Get.toNamed(AppRoutes.forgotPasswordPage2);
      }
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(msg: AppStrings.emailNotFound);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.emailNotFound);
    } finally {
      AppClass().showLoading(false);
    }
  }

  // call api for verify otp code send on email
  Future verifyEmailOTP({required String email, required String otp}) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.postData(
        url: APIUrls().authUrl + 'forgot-password/verify-otp',
        data: jsonEncode({'email': email, 'otp': otp}),
      );
      if (response.statusCode == 200) {
        AppClass().showLoading(false);
        ResetToken resetTokenData = ResetToken.fromJson(response.data);
        resetToken = resetTokenData.data.resetToken;
        forgotPasswordPage3ResetAll();
        Get.toNamed(AppRoutes.forgotPasswordPage3);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.inCorrectOTP);
      AppClass().showLoading(false);
      return false;
    }
  }

  // call api for save new password after resetting
  Future resetAndSaveNewPassword({
    required String email,
    required String password,
    required String resetToken,
  }) async {
    AppClass().showLoading(true);
    try {
      var response = await apiClient.postData(
        url: APIUrls().authUrl + 'forgot-password/reset-password',
        data: jsonEncode({'email': email, 'password': password, 'resetToken': resetToken}),
      );
      if (response.statusCode == 200) {
        AppClass().showLoading(false);
        if (arguments.isFromDynamicLink == true) {
          //TODO : navigate to Registration with Link Page
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => RegistrationWithLinkScreen(isFromPasswordReset: true, schoolId: schoolId.value),
          //   ),
          // );
        } else {
          Get.offAllNamed(
            AppRoutes.loginPage,
            arguments: AppDataModel(isFromPasswordReset: true),
          );
        }

        Future.delayed(Duration(microseconds: 400), () {
          PasswordResetToast().showMesasge();
        });
      }
    } catch (error) {
      if (error is dio.DioError) {
        if (error.response!.statusCode == 404) {
          Fluttertoast.showToast(msg: AppStrings.userNotFound);
        } else if (error.response!.statusCode == 401) {
          Fluttertoast.showToast(msg: AppStrings.notAuthorized);
        }
      } else {}
      AppClass().showLoading(false);
    }
  }

  @override
  void dispose() {
    animationController.value.dispose();
    super.dispose();
  }
}
