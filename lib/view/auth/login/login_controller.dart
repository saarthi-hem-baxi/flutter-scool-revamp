import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/helpers/network.dart';
import 'package:students/helpers/storage_manager.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/models/auth/renew.dart';
import 'package:students/models/auth/update_session.dart';
import 'package:students/models/auth/user.dart';
import 'package:students/models/auth/users.dart';
import 'package:students/view/auth/login/widgets/multi_auth_sheet.dart';
import 'package:students/view/auth/school_deactivation/school_deactivation_page.dart';
import 'package:students/view/auth/school_deactivation/widgets/school_deactivation_dialog.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  APIClient apiClient = APIClient();

  AppDataModel? arguments;

  TextEditingController emailorMobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  var schoolData = {}.obs;

  RxBool isFocusOnLoginEmailPhone = false.obs;
  RxBool isFocusOnLoginOTPPassword = false.obs;
  RxBool isUserEmail = false.obs;
  RxBool isShowNextBtn = false.obs;
  RxBool isNumberChanged = false.obs;
  RxBool passwordVisible = false.obs;
  RxBool timerComplete = false.obs;
  RxInt levelClock = 120.obs;
  RxDouble opacity = 0.0.obs;
  Rx<LoginType> loginType = LoginType.phone.obs;

  RxString tempUserId = ''.obs;
  RxString sessionToken = ''.obs;

  Rx<UsersModal> userModal = UsersModal().obs;
  Rx<User> currentUser = User().obs;
  RxList<User> allUsers = <User>[].obs;

  late Rx<AnimationController> animationController;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    onInitScroll();
    super.onInit();
    //initlize animation controller
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock.value,
      ),
    ).obs;
  }

  // for scrool on page init
  void onInitScroll() {
    if (WidgetsBinding.instance.window.viewInsets.bottom == 0.0 &&
        scrollController.hasClients) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  // scroll to bottom when close keyboard
  void onScrollToBottom() {
    if (WidgetsBinding.instance.window.viewInsets.bottom == 0.0 &&
        scrollController.hasClients) {
      scrollController.animateTo(
          //go to top of scroll
          0, //scroll offset to go
          duration: const Duration(milliseconds: 500), //duration of scroll
          curve: Curves.linear //scroll type
          );
    }
  }

  // navigate to forgot password screen using getx
  void navigateToForgotPaswordScreen() {
    Get.toNamed(AppRoutes.forgotPasswordPage,
        arguments: AppDataModel(email: emailorMobileController.text.trim()));
  }

  // invoke this method when email or mobile number submit
  void onEmailMobileNumberSubmit(String value) {
    final isMobileNumber = RegExp(r'^[0-9]+$').hasMatch(value.trim());
    if (isMobileNumber) {
      if (value.length != 10) {
        isUserEmail.value = false;
        loginType.value = LoginType.phone;
        Fluttertoast.showToast(msg: AppStrings.mobileNumberIsIncorrect);
        changeOpacity(0.0);
      } else {
        isUserEmail.value = false;
        loginType.value = LoginType.phone;
        if (value.isEmpty) {
          changeOpacity(0.0);
          levelClock.value = 120;
        } else {
          otpController.text = '';
          changeOpacity(1.0);
          if (isNumberChanged.isTrue) {
            isNumberChanged.value = false;
            sendOtp();
            resetAll();
          }
        }
      }
    } else {
      String emailTxt = emailorMobileController.text;

      if (!emailTxt.isEmail) {
        Fluttertoast.showToast(msg: AppStrings.invalidEmailAddress);
        changeOpacity(0.0);
      } else {
        isUserEmail.value = true;
        loginType.value = LoginType.email;
        if (value.isEmpty) {
          changeOpacity(0.0);
        } else {
          passwordController.text = '';
          changeOpacity(1.0);
        }
      }
    }
    isShowNextBtn.value = false;
  }

  // change the opacity of the next button
  void changeOpacity(double currentOpacity) {
    Future.delayed(const Duration(milliseconds: 100), () {
      opacity.value = currentOpacity;
      if (opacity == 1.0) {
        isShowNextBtn.value = false;
      }
    });
  }

  // reset state value to it's default value
  void resetAll() {
    timerComplete.value = false;
    animationController.value = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock.value,
      ),
    );
    animationController.value.forward();
    otpController.clear();
  }

  // invoke this method when tap to onResent btn
  void onResendOTP() {
    if (timerComplete.isTrue) {
      if (loginType == LoginType.phone) {
        contactResendOTP(contact: emailorMobileController.text.trim());
        resetAll();
      }
    }
  }

  /// invoke this method when user tap on get started btn
  ///
  ///
  void submitForm(BuildContext context) {
    FocusScope.of(context).unfocus();
    String emailTxt = emailorMobileController.text.trim();
    if (loginType == LoginType.email) {
      // here we passed password and confirm password as same due to we are not input confirm password
      bool isValidPassword = Utils.checkPasswordvalidation(
          password: passwordController.text,
          confirmPassword: passwordController.text);

      //verify email is valid
      if (!emailTxt.isEmail) {
        Fluttertoast.showToast(msg: AppStrings.invalidEmailAddress);

        //verify  password is
      } else if (isValidPassword) {
        loginWithEmail(
          email: emailorMobileController.text.trim(),
          password: passwordController.text.trim(),
        ).then((v) {
          if (v) {
            if (tempUserId.isEmpty) {
              MultiAuthBottomSheet().showMultiAuthSheet();
            } else {
              var data = {
                'email': emailorMobileController.text.trim(),
                'password': passwordController.text.trim(),
                'tempStudentId': tempUserId.toString()
              };

              print(data);

              Get.toNamed(
                AppRoutes.registrationPage1,
                arguments: AppDataModel(
                  userInputLoginData: data,
                  isFromAddSchoolBtn: false,
                  isBackButtonEnabled: true,
                ),
              );
            }
          }
        });
      }
    } else {
      String otpValue = otpController.text.trim();
      if (otpValue.isEmpty) {
        Fluttertoast.showToast(msg: AppStrings.otpRequired);
      } else {
        verifyLoginOTP(
                contact: emailorMobileController.text.trim(),
                otp: otpController.text.trim())
            .then((value) {
          if (value) {
            print(tempUserId);
            if (tempUserId.isEmpty) {
              MultiAuthBottomSheet().showMultiAuthSheet();
            } else {
              Map data = {
                'contact': emailorMobileController.text.trim(),
                'loginOTP': int.parse(otpController.text.trim().toString()),
                'tempStudentId': tempUserId.toString()
              };

              print('LINE 242 : DATA : $data');
              Get.toNamed(
                AppRoutes.registrationPage1,
                arguments: AppDataModel(
                  userInputLoginData: data,
                  isFromAddSchoolBtn: false,
                  isBackButtonEnabled: true,
                ),
              );
            }
          }
        });
      }
    }
  }

  // invoke this method when select user from user list bottom sheet in login page
  void onSchoolSelectFromMultiAuthSheet(String userId) {
    updateSession(studentUserId: userId).then((value) {
      StorageManager().setAuthToken(userModal.value.token ?? '');

      if (userModal.value.users?.length == 1) {
        StorageManager()
            .setCurrentUserToLocalStorage(userModal.value.users?[0]);
      } else {
        StorageManager().setCurrentUserToLocalStorage(userModal.value.users
            ?.singleWhere((element) => element.id == userId));
        currentUser.value = userModal.value.users
                ?.singleWhere((element) => element.id == userId) ??
            User();
      }
      StorageManager().setUsersToLocalStorage(userModal.value.users);
      StorageManager().setUserIsLoggedIn(true);
      // _callTotalTimeSpent(authController, context);
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(AppRoutes.bottomMainPage);
      });
    });
  }

  // call api for send OTP using mobile number
  Future<bool> sendOtp() async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.postData(
        url: APIUrls().authUrl + 'send-otp',
        data: jsonEncode({'contact': emailorMobileController.text.trim()}),
      );
      if (response.statusCode == 200) {
        tempUserId.value = '';
        if (response.data['data']['studentId'] != null) {
          tempUserId.value = response.data['data']['studentId'];
        }
        Fluttertoast.showToast(msg: AppStrings.otpSentYourMobileNumber);
        return true;
      } else {
        return false;
      }
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(msg: AppStrings.userNotFound);
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.otpCannotBeSent);
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  // call api when user tap on resend btn
  Future<bool> contactResendOTP({
    required String? contact,
  }) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.postData(
        url: APIUrls().authUrl + 'resend-otp',
        data: jsonEncode({'contact': contact}),
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: AppStrings.otpSentYourMobileNumber);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.someThingWentWrong);
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  // call this api when user login with email address
  Future<bool> loginWithEmail({
    required String? email,
    required String? password,
  }) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.postData(
        url: APIUrls().authUrl + 'email-login',
        data: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        tempUserId.value = '';
        userPostProcess(response: response);
        AppClass().showLoading(false);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.inCorrectCredentials);
      AppClass().showLoading(false);
      return false;
    }
  }

  // call this api when user verify otp with email number
  Future<bool> verifyLoginOTP({
    required String? contact,
    required String? otp,
  }) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.postData(
        url: APIUrls().authUrl + 'verify-login-otp',
        data: jsonEncode({'contact': contact, 'otp': otp}),
      );
      if (response.statusCode == 200) {
        userPostProcess(response: response);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.otpCannotBeVerified);
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  // for processing on user data after recing from login data
  void userPostProcess({required dio.Response response}) {
    if (response.data['data'] != null) {
      if (response.data['data']['studentId'] != null) {
        tempUserId.value = response.data['data']['studentId'];
      } else {
        userModal.value = UsersModal.fromJson(response.data['data']);

        sessionToken.value = response.data['data']['token'] ?? '';
        StorageManager().setAuthToken(sessionToken.value);

        if (userModal.value.users?.length == 1) {
          currentUser.value = userModal.value.users?[0] ?? User();

          //Register FCMToken
          registerFCMToken();
        }
        // await pref.setString(users, jsonEncode(userModal.value.users));
        // pref.setBool(loginKey, true);
      }
    }
  }

  void submitFromDynamicLink(BuildContext context) {
    FocusScope.of(context).unfocus();
    String emailTxt = emailorMobileController.text.trim();

    if (loginType == LoginType.email) {
      // here we passed password and confirm password as same due to we are not input confirm password
      bool isValidPassword = Utils.checkPasswordvalidation(
          password: passwordController.text,
          confirmPassword: passwordController.text);

      //verify email is valid
      if (!emailTxt.isEmail) {
        Fluttertoast.showToast(msg: AppStrings.invalidEmailAddress);

        //verify  password is
      } else if (isValidPassword) {
        loginWithEmailDynamicLink(
          email: emailorMobileController.text.trim(),
          password: passwordController.text.trim(),
          schoolId: arguments?.schoolId ?? '',
        ).then((value) {
          var data = {
            'email': emailorMobileController.text.toString(),
            'password': passwordController.text.toString(),
            'tempStudentId': tempUserId.toString()
          };
          arguments = AppDataModel(
            userInputLoginData: data,
            schoolId: arguments?.schoolId ?? '',
            isFromAddSchoolBtn: false,
            isFromDynamicLink: true,
          );
          Get.offAllNamed(AppRoutes.registrationPage2, arguments: arguments);
        });
      }
    } else {
      if (otpController.text.trim().isEmpty) {
        Fluttertoast.showToast(msg: AppStrings.otpRequired);
        return;
      }
      verifyLoginOTP(
              contact: emailorMobileController.text.trim(),
              otp: otpController.text.trim())
          .then((value) {
        var data = {
          'email': emailorMobileController.text.toString(),
          'password': passwordController.text.toString(),
          'tempStudentId': tempUserId.toString()
        };
        arguments = AppDataModel(
          userInputLoginData: data,
          schoolId: arguments?.schoolId ?? '',
          isFromAddSchoolBtn: false,
          isFromDynamicLink: true,
        );
        Get.offAllNamed(AppRoutes.registrationPage2, arguments: arguments);
      });
    }
  }

  //Regiter With OTP(Dynamic Link)
  Future<bool> loginWithEmailDynamicLink({
    required String? email,
    required String? password,
    required String? schoolId,
  }) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.postData(
        url: '${APIUrls().registraionUrl}school/$schoolId/student/with-email',
        data: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        tempUserId.value = '';
        userPostProcess(response: response);
        return true;
      } else {
        return false;
      }
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 409) {
        Fluttertoast.showToast(msg: 'Student already registered');
      } else if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(msg: 'User not found');
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: 'Incorrect Credentials');
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  //Regiter With OTP(Dynamic Link)
  Future<bool> registerWithContact({
    required String? contact,
    required String? schoolId,
  }) async {
    AppClass().showLoading(true);
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
        Fluttertoast.showToast(msg: 'Otp sent to your mobile number');
        return true;
      } else {
        return false;
      }
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 409) {
        Fluttertoast.showToast(msg: 'Student already registered');
      } else if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(msg: 'User not found');
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: 'OTP Cannot be sent');
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  // invoke this method for session update
  Future updateSession({
    required String studentUserId,
    bool isNeedToRegisterFCM = true,
    bool? isStopLoaderAfterCompleteProcess = true,
  }) async {
    AppClass().showLoading(true);

    try {
      dio.Response response = await apiClient.putData(
        url: APIUrls().authUrl + 'update-session',
        data: {'studentUserId': studentUserId},
      );

      UpdateSessionModal updateSessionModal =
          UpdateSessionModal.fromJson(response.data['data']);
      StorageManager().setCurrentUserToLocalStorage(updateSessionModal.user);
      StorageManager().setAuthToken(updateSessionModal.token ?? '');

      currentUser.value = updateSessionModal.user ?? User();
      allUsers.value = updateSessionModal.users ?? [];

      //Register FCMToken
      if (isNeedToRegisterFCM) {
        registerFCMToken();
      }
      if (response.statusCode == 200) {}
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.someThingWentWrong);
    } finally {
      if (isStopLoaderAfterCompleteProcess == true) {
        AppClass().showLoading(false);
      }
    }
  }

  // invoke method for renew user
  Future renewUser() async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.getData(
        url: APIUrls().authUrl + 'renew',
      );
      if (response.statusCode == 200) {
        RenewUserModal renewUserModal =
            RenewUserModal.fromJson(response.data['data']);

        currentUser.value = renewUserModal.user ?? User();
        allUsers.value = renewUserModal.users ?? [User()];

        StorageManager().setCurrentUserToLocalStorage(renewUserModal.user);
        StorageManager().setUsersToLocalStorage(renewUserModal.users);
      }
    } catch (error) {
      debugPrint('Something went wrong');
    } finally {
      AppClass().showLoading(false);
    }
  }

  /// call api for get session data
  Future<List<User>> getSessionUserData() async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.getData(
        url: APIUrls().authUrl + 'session-data',
      );
      if (response.statusCode == 200) {
        RenewUserModal renewUserModal =
            RenewUserModal.fromJson(response.data['data']);

        currentUser.value = renewUserModal.user ?? User();
        allUsers.value = renewUserModal.users ?? [User()];

        StorageManager().setCurrentUserToLocalStorage(renewUserModal.user);
        StorageManager().setUsersToLocalStorage(renewUserModal.users);
        return allUsers;
      }
      return [];
    } catch (error) {
      debugPrint('Cannot get users');
      return [];
    } finally {
      AppClass().showLoading(true);
    }
  }

  // call api for get school details using school id
  Future getSchoolDetail(
      {required String schoolId, bool isFromRegistrationLink = false}) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.getData(
        url: APIUrls().registraionUrl + 'school/$schoolId',
      );
      if (response.statusCode == 200) {
        schoolData.value = response.data['data'];
        AppClass().showLoading(false);
        return true;
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        SchoolDeactivationDialog().showDialog(
            message: e.response?.data['error'] ?? 'School deactivated.');
        SchoolDeactivationPopUp.showPopUp(
          isFromRegistrationLink: isFromRegistrationLink,
          schoolId: schoolId,
        );
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: 'Cannot get school details ');
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  // invoke this method for logout process
  void logout() async {
    AppClass().showLoading(true);
    //TODO : Call to disconnect analytics socket
    // disconnectAnalyticsSocket();

    //navigate to login page & clear all pages
    Future.delayed(Duration.zero, () {
      Get.offAllNamed(AppRoutes.loginPage);
    });

    try {
      var response = await apiClient.postData(
        url: APIUrls().authUrl + 'logout',
        data: {'fcmToken': await getFCMToken()},
      );

      if (response.statusCode == 200) {
        AppClass().showLoading(false);
      }
    } catch (error) {
      if (error is dio.DioException) {
        if (error.response?.statusCode == 404) {
          Fluttertoast.showToast(msg: AppStrings.userNotFound);
        } else if (error.response!.statusCode == 401) {
          Fluttertoast.showToast(msg: AppStrings.notAuthorized);
        }
      }
    } finally {
      AppClass().showLoading(false);
      StorageManager().clearSession();
    }
  }

  // generate firebase cloud messeging token
  Future<String?> getFCMToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint('Cannot get FCMToken');
      return '';
    }
  }

  //call api register fcm token with backend
  void registerFCMToken() async {
    getFCMToken().then((fcmToken) async {
      await apiClient.postData(
        url: APIUrls().authUrl + 'register-token',
        data: {'fcmToken': fcmToken},
      );
    }).catchError((error) {
      debugPrint('Cannot register FCMToken');
    });
  }

  @override
  void dispose() {
    animationController.value.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
