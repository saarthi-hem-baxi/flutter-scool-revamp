import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/helpers/network.dart';
import 'package:students/helpers/storage_manager.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/models/auth/city_list.dart';
import 'package:students/models/auth/dynamic_link_query.dart';
import 'package:students/models/auth/school_list.dart';
import 'package:students/models/auth/teaching.dart';
import 'package:students/models/auth/user.dart';
import 'package:students/view/auth/login/login_controller.dart';
import 'package:students/view/auth/login/widgets/multi_auth_sheet.dart';
import 'package:students/view/auth/registration/registration_with_link_controller.dart';

class RegistrationController extends GetxController {
  APIClient apiClient = APIClient();
  AppDataModel? arguments;

  // Registration Page 1
  RxList<CityListModal> allCityList = <CityListModal>[].obs;
  RxList<SchoolListModel> allSchoolList = <SchoolListModel>[].obs;
  Rx<SchoolListModel> selectedSchoolData = SchoolListModel().obs;

  LoginController loginController = Get.put(LoginController());

  RxBool isSchoolDataLoading = false.obs;
  RxBool isCitySchoolDataLoading = false.obs;

  RxBool isCitySelected = false.obs;
  RxBool isCitiesSeachLoaded = false.obs;
  RxBool isCityiesSearching = false.obs;
  RxBool findingCity = false.obs;
  RxBool findingSchool = false.obs;
  RxBool editSchool = true.obs;

  RxString searchCityText = ''.obs;
  RxString searchSchoolText = ''.obs;
  RxBool isSchoolSelected = false.obs;

  RxString selectedCityName = ''.obs;
  RxString selectedStateName = ''.obs;
  RxString selectedStateID = ''.obs;
  RxString selectedCityId = ''.obs;

  Rx<Color> citySearchBgColor = AppColors.gray25.obs;
  Rx<Color> schoolSearchBgColor = AppColors.gray25.obs;

  Timer? debounceTimer;

  final TextEditingController searchCityTextController =
      TextEditingController();
  final Rx<TextEditingController> searchSchoolTextController =
      TextEditingController().obs;

  // Registration Page 2

  RxBool isClassSelected = false.obs;
  RxBool isFocusOnFullName = false.obs;

  RxBool isSelectMale = false.obs;
  RxBool isSelectFemale = false.obs;

  RxString selectedClassId = ''.obs;
  RxString selectedSectionId = ''.obs;

  RxList<TeachingModal> teachingData = <TeachingModal>[].obs;
  RxList<TeachingModal> teachingClassSectionData = <TeachingModal>[].obs;

  Rx<TextEditingController> nameController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is AppDataModel) {
      arguments = Get.arguments as AppDataModel;
      print('REG CONTROLLER LINE 86 : $arguments');
    }
    Future.delayed(Duration.zero, () {
      if ((arguments?.schoolId ?? '').isNotEmpty) {
        loginController.getSchoolDetail(
          schoolId: arguments?.schoolId ?? '',
          isFromRegistrationLink: arguments?.isFromDynamicLink ?? false,
        );
        getTeachingDataClassSection(schoolId: arguments?.schoolId ?? '');
      }
    });
  }

  // invoke this method for navigation to login page
  void navigateToLogin() {
    loginController.refresh();
    Get.back();
  }

  /// invoke this method when tap submit btn from registration page 1
  void onRegistration1Submit() {
    // navigate to Registration page 2

    print('LINE 109 : ${arguments?.userInputLoginData}');
    Get.toNamed(
      AppRoutes.registrationPage2,
      arguments: AppDataModel(
        userInputLoginData: arguments?.userInputLoginData ?? {},
        schoolId: selectedSchoolData.value.id ?? '',
        isFromAddSchoolBtn: arguments?.isFromAddSchoolBtn,
        isFromDynamicLink: false,
        isFromLoginAddSchool: arguments?.isFromLoginAddSchool,
      ),
    );
    isClassSelected.value = false;
    getTeachingDataClassSection(schoolId: selectedSchoolData.value.id ?? '');
  }

  /// decide gender value based on [isSelectMale] and [isSelectFemale]
  String getGenderValue() {
    if (isSelectMale.isTrue) {
      return 'male';
    } else if (isSelectFemale.isTrue) {
      return 'female';
    } else {
      return '';
    }
  }

  // invoke this method when user tap [Add School] btn from login page multi user bottom sheet
  void onTapAddSchoolBtn({required String schoolId}) async {
    if (nameController.value.text.isEmpty) {
      Fluttertoast.showToast(msg: AppStrings.pleaseEnterFullName);
      return;
    } else if (isSelectMale.value == false && isSelectFemale.value == false) {
      Fluttertoast.showToast(msg: AppStrings.pleaseSelectGender);
    } else {
      Map dataMap = {
        'name': nameController.value.text.trim(),
        'gender': getGenderValue(),
        'class': selectedClassId.value,
        'section': selectedSectionId.value,
      };

      studentAddSchool(
        data: dataMap,
        schoolId: selectedSchoolData.value.id ?? schoolId,
        isFromLoginAddSchool: arguments?.isFromLoginAddSchool ?? false,
      ).then((value) {
        if (value) {
          Get.offAllNamed(AppRoutes.bottomMainPage, arguments: AppDataModel());
        }
      });
    }
  }

  // invoke this method when user tap submit btn fom page2
  void onRegistrationPage2Submit(
      {String? schoolId, String? tempStudentId}) async {
    final registrationLinkController =
        Get.put(RegistrationWithLinkController());
    print('LINE 164 : ${registrationLinkController.tempUserId.value}');
    print(tempStudentId);
    if (nameController.value.text.isEmpty) {
      Fluttertoast.showToast(msg: AppStrings.pleaseEnterFullName);
      return;
    } else if (isSelectMale == false && isSelectFemale == false) {
      Fluttertoast.showToast(msg: AppStrings.pleaseSelectGender);
    } else {
      Map dataMap = {
        'name': nameController.value.text.trim().toString(),
        'tempStudentId': tempStudentId,
        // Original below
        // 'tempStudentId': registrationLinkController.tempUserId.value,
        'gender': getGenderValue(),
        'class': selectedClassId.value,
        'section': selectedSectionId.value
      };
      print('LINE 178 : $dataMap');
      if (loginController.loginType == LoginType.phone) {
        dataMap = {
          ...dataMap,
          'contact': arguments?.userInputLoginData?['contact'] ?? '',
          'loginOTP': arguments?.userInputLoginData?['loginOTP'] ?? '',
        };
      } else {
        dataMap = {
          ...dataMap,
          'email': arguments?.userInputLoginData?['email'] ?? '',
          'password': arguments?.userInputLoginData?['password'] ?? '',
        };
      }

      print(dataMap);

      bool value =
          await studentRegistrationNew(data: dataMap, schoolId: schoolId ?? '');

      if (value) {
        if (loginController.loginType == LoginType.phone) {
          bool isVerifyLogin = await loginController.verifyLoginOTP(
            contact: dataMap['contact'].toString(),
            otp: dataMap['loginOTP'].toString(),
          );

          if (isVerifyLogin) {
            MultiAuthBottomSheet().showMultiAuthSheet();
          }
        } else if (loginController.loginType == LoginType.email) {
          bool isLogin = await loginController.loginWithEmail(
            email: dataMap['email'].toString().trim(),
            password: dataMap['password'].toString().trim(),
          );

          if (isLogin) {
            MultiAuthBottomSheet().showMultiAuthSheet();
          }
        }
      }
    }
  }

  // call api for get [City] & [State] list when user search in city search bar
  Future getCities({required String cityName}) async {
    isCitySchoolDataLoading.value = true;
    findingCity.value = true;
    isCityiesSearching.value = true;
    isCitiesSeachLoaded.value = false;
    try {
      dio.Response response = await apiClient.getData(
          url: '${APIUrls().registraionUrl}cities?search=$cityName');
      if (response.statusCode == 200) {
        allCityList.clear();
        print("response data ${response.data['data']}");
        allCityList.value = cityListModalFromJson(response.data['data']);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: AppStrings.someThingWentWrong);
      return false;
    } finally {
      isCitySchoolDataLoading.value = false;
      findingCity.value = false;
      isCityiesSearching.value = false;
      isCitiesSeachLoaded.value = true;
    }
  }

  // call api for get Schools list when user search in school search bar
  Future getSchools(
      {required String stateId,
      required String cityName,
      required String schoolName}) async {
    isSchoolDataLoading.value = true;
    findingSchool.value = true;
    print(stateId);
    print(cityName);
    print(schoolName);

    try {
      dio.Response response = await apiClient.getData(
          url:
              '${APIUrls().registraionUrl}states/$stateId/cities/$cityName/schools?search=$schoolName');

      print(response);
      if (response.statusCode == 200) {
        allSchoolList.clear();
        allSchoolList.value = schoolListModelFromJson(response.data['data']);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: AppStrings.someThingWentWrong);
      return false;
    } finally {
      isSchoolDataLoading.value = false;
      findingSchool.value = false;
    }
  }

  // call api for get class and section data of selected school
  void getTeachingData({required String schoolId}) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.getData(
        url:
            APIUrls().registraionUrl + 'school/$schoolId/classes-with-sections',
      );

      print(response);
      if (response.statusCode == 200) {
        teachingData.value = teachingModalFromJson(response.data['data']);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.cannotGetTeachingDetails);
    } finally {
      AppClass().showLoading(false);
    }
  }

  // call api for get class and section data with subject data
  void getTeachingDataClassSection({required String schoolId}) async {
    AppClass().showLoading(true);

    print(schoolId);
    try {
      dio.Response response = await apiClient.getData(
        url: APIUrls().registraionUrl +
            'school/$schoolId/classes-sections-subjects',
      );
      print('LINE 307 CONTROLLER : $response');
      if (response.statusCode == 200) {
        teachingClassSectionData.value =
            teachingModalFromJson(response.data['data']);

        print(teachingClassSectionData.value);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.cannotGetTeachingDetails);
    } finally {
      AppClass().showLoading(false);
    }
  }

  // call api for add student from [Add School] btn
  Future<bool> studentAddSchool(
      {required Map data,
      required String schoolId,
      bool? isFromLoginAddSchool}) async {
    AppClass().showLoading(true);
    try {
      if (isFromLoginAddSchool == true) {
        if ((loginController.userModal.value.users ?? []).isNotEmpty) {
          await loginController.updateSession(
            studentUserId:
                (loginController.userModal.value.users ?? []).first.id ?? '',
            isStopLoaderAfterCompleteProcess: false,
          );
        }
      } // while we add student from login sheet we need to update session first for temp.

      dio.Response response = await apiClient.postData(
        url: '${APIUrls().lmsSchoolUrl}$schoolId/student/add-school',
        data: data,
      );

      if (response.statusCode == 200) {
        if (isFromLoginAddSchool == true) {
          Future.delayed(const Duration(milliseconds: 300), () {
            loginController.updateSession(
              studentUserId: response.data?['data']?['_id'] ?? '',
            );
          }); // here we are add some deley for backend process for preapre session data
        }
        return true;
      }
      if (response.statusCode == 409) {
        Fluttertoast.showToast(msg: AppStrings.studentAlreadyRegisterd);
        return false;
      } else {
        return false;
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 409) {
        Fluttertoast.showToast(msg: AppStrings.studentAlreadyRegisterd);
      } else if (e.response?.statusCode == 504) {
        Fluttertoast.showToast(msg: AppStrings.cannotRegisterStudent);
      }

      AppClass().showLoading(false);
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.cannotRegisterStudent);
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  // call api when student register using regular flow
  Future<bool> studentRegistrationNew(
      {required Map data, required String schoolId}) async {
    AppClass().showLoading(true);
    print('LINE 370 : $schoolId');

    print(' LINE 369 $data');

    try {
      dio.Response response = await apiClient.postData(
          url: APIUrls().registraionUrl + 'school/$schoolId/student',
          data: data);

      print(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(
            msg: e.response?.statusMessage ?? AppStrings.userNotFound);
      } else if (e.response?.statusCode == 409) {
        Fluttertoast.showToast(msg: AppStrings.studentAlreadyRegisterd);
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.cannotRegisterAccount);
      return false;
    } finally {
      AppClass().showLoading(false);
    }
  }

  /// handle dyanmic link for registration
  void onRegistrationByDynamicLink(
      {required DynamicLinkQueryData dynamicLinkData}) async {}
}
