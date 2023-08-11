import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/helpers/network.dart';
import 'package:students/helpers/storage_manager.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/models/auth/users.dart';
import 'package:students/view/auth/login/login_controller.dart';

class RegistrationWithLinkController extends GetxController
    with GetTickerProviderStateMixin {
  APIClient apiClient = APIClient();
  AppDataModel arguments = AppDataModel();

  // State<RegistrationWithLinkScreen> with TickerProviderStateMixin {
  final TextEditingController emailorMobileController =
      TextEditingController(text: '');
  final TextEditingController otpController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  RxBool isUserEmail = false.obs;
  final loginController = Get.put(LoginController());
  late Rx<AnimationController> animationController;
  RxInt levelClock = 120.obs;
  RxBool timerComplete = false.obs;
  RxBool passwordVisible = false.obs;
  double opacity = 0.0;
  RxBool isNumberChanged = false.obs;

  RxBool isFocusEmailMobile = false.obs;
  RxBool isFocusPassword = false.obs;

  RxBool isShowNext = false.obs;
  Rx<String> tempUserId = ''.obs;

  Rx<UsersModal> userModal = UsersModal().obs;
  RxBool isAlreadyRegistered = false.obs;

  RxBool isTimerCompleted = false.obs;
  RxString sessionToken = ''.obs;
  var schoolData = {}.obs;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration.zero, () {
      if (Get.arguments is AppDataModel) {
        arguments = Get.arguments as AppDataModel;

        print(arguments);
      }
      if ((arguments.schoolId ?? '').isNotEmpty) {
        loginController.getSchoolDetail(
          schoolId: arguments.schoolId ?? '',
          isFromRegistrationLink: true,
        );
      }
    });

    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock.value,
      ),
    ).obs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // showSucessfullToast();
    });
  }

  @override
  void dispose() {
    animationController.value.dispose();
    super.dispose();
  }

  void changeOpacity(var currentopacity) {
    Future.delayed(const Duration(milliseconds: 200), () {
      opacity = currentopacity;
      if (opacity == 1.0) {
        isShowNext.value = false;
      }
    });
  }

  void emailMobileNumberSubmit(String value) {
    final isMobileNumber = RegExp(r'^[0-9]+$').hasMatch(value.trim());
    if (isMobileNumber) {
      if (value.length != 10) {
        isUserEmail.value = false;
        loginController.loginType.value = LoginType.phone;
        Fluttertoast.showToast(msg: 'Mobile Number is incorrect');
        changeOpacity(0.0);
      } else {
        isUserEmail.value = false;
        loginController.loginType.value = LoginType.phone;
        if (value.isEmpty) {
          changeOpacity(0.0);
          levelClock.value = 120;
        } else {
          otpController.text = '';
          changeOpacity(1.0);
          if (isNumberChanged.value) {
            isNumberChanged.value = false;
            sendOtp();
            resetAll();
          }
        }
      }
    } else {
      if (!emailorMobileController.text.isEmail) {
        Fluttertoast.showToast(msg: 'Invalid email address');
        changeOpacity(0.0);
      } else {
        isUserEmail.value = true;
        loginController.loginType.value = LoginType.email;
        if (value.isEmpty) {
          changeOpacity(0.0);
        } else {
          passwordController.text = '';
          changeOpacity(1.0);
        }
      }
    }
  }

  void sendOtp() {
    registerWithContact(
        contact: emailorMobileController.text.trim(),
        schoolId: arguments.schoolId);
  }

  void onResendCode() {
    if (timerComplete.value) {
      if (loginController.loginType == LoginType.phone) {
        loginController
            .contactResendOTP(
                contact: emailorMobileController.text.trim().toString())
            .then((value) {
          resetAll();
        });
      }
    }
  }

  void resetAll() {
    timerComplete.value = false;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock.value,
      ),
    ).obs;

    animationController.value.forward();
    otpController.text = '';
  }

  //Regiter With OTP(Dynamic Link)
  Future<bool> registerWithContact({
    required String? contact,
    required String? schoolId,
  }) async {
    try {
      dio.Response response = await apiClient.postData(
        url: '${APIUrls().registraionUrl}school/$schoolId/student/send-otp',
        data: jsonEncode({'contact': contact}),
      );
      if (response.statusCode == 200) {
        tempUserId.value = '';
        if (response.data['data']['studentId'] != null) {
          tempUserId.value = response.data['data']['studentId'];
        }
        if (response.data['data']['register'] != null) {
          isAlreadyRegistered.value = response.data['data']['register'];
        }
        Fluttertoast.showToast(msg: 'Otp sent to your mobile number');
        return true;
      } else {
        return false;
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(msg: 'User not found');
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: 'OTP Cannot be sent');
      return false;
    } finally {}
  }

  //Regiter With OTP(Dynamic Link)
  Future<bool> loginWithEmailDynamicLink({
    required String? email,
    required String? password,
    required String? schoolId,
  }) async {
    try {
      dio.Response response = await apiClient.postData(
        url: '${APIUrls().registraionUrl}school/$schoolId/student/with-email',
        data: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        tempUserId.value = '';
        if (response.data['data']['studentId'] != null) {
          tempUserId.value = response.data['data']['studentId'];
        }
        if (response.data['data']['register'] != null) {
          isAlreadyRegistered.value = response.data['data']['register'];
        }
        userPostProcess(response: response);
        return true;
      } else {
        return false;
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 409) {
        Fluttertoast.showToast(msg: 'Teacher already registered');
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: 'Incorrect Credentials');
      return false;
    } finally {}
  }

  void userPostProcess({required dio.Response response}) async {
    if (response.data['data'] != null) {
      if (response.data['data']['userId'] != null) {
        tempUserId.value = response.data['data']['userId'];
      } else {
        if (response.data['data']['users'] != null) {
          UsersModal user = UsersModal();
          user = UsersModal.fromJson(response.data['data']);
          userModal.value = UsersModal.fromJson(response.data['data']);
          sessionToken.value = userModal.value.token ?? '';
          StorageManager().setAuthToken(sessionToken.value);
          if (user.users?.length == 1) {
            //Register FCMToken
            registerFCMToken();
          }
        }
      }
    } else {
      userModal.value = UsersModal();
    }
  }

  // generate firebase cloud messeging token
  Future registerFCMToken() async {
    getFCMToken().then((fcmToken) async {
      await apiClient.postData(
          url: '${APIUrls().authUrl}register-token',
          data: {'fcmToken': fcmToken});
    }).catchError((error) {
      debugPrint('Cannot register FCMToken $error');
    });
  }

  //call api register fcm token with backend
  Future<String?> getFCMToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint('Cannot get FCMToken');
      return '';
    }
  }

  // showSucessfullToast() {
  //   FToast fToast;
  //   fToast = FToast();
  //   fToast.init(context);
  //   Widget toast = Container(
  //     padding: const EdgeInsets.all(10),
  //     margin: EdgeInsets.only(bottom: 10.h),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       color: colorGreen100,
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         SizedBox(
  //           height: 20.h,
  //           width: 20.w,
  //           child: SvgPicture.asset(
  //             '${imageAssets}toast_right.svg',
  //             fit: BoxFit.contain,
  //           ),
  //         ),
  //         SizedBox(
  //           width: 6.w,
  //         ),
  //         Text('Your password has been reset successfully.',
  //             style: textTitle14StylePoppins.merge(const TextStyle(color: colorGrey600, fontWeight: FontWeight.w400))),
  //       ],
  //     ),
  //   );
  //   if (widget.isFromPasswordReset) {
  //     fToast.showToast(
  //         child: toast,
  //         gravity: ToastGravity.SNACKBAR,
  //         toastDuration: const Duration(seconds: 2),
  //         positionedToastBuilder: (context, child) {
  //           return Positioned(
  //             right: 16,
  //             bottom: 40,
  //             left: 16.0,
  //             child: child,
  //           );
  //         });
  //   }
  // }
}
