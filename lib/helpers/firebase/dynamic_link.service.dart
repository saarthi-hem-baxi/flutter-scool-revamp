// ignore_for_file: unused_local_variable

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/helpers/storage_manager.dart';
import 'package:students/models/auth/dynamic_link_query.dart';
import 'package:students/models/auth/user.dart';
import 'package:students/view/auth/login/login_controller.dart';

class FirebaseDynamicLinkService {
  Future<Uri> getDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          'https://saarthipedagogy.com/studentsV2?type=register&value=62f78511081dab881b57a794'),
      uriPrefix: 'https://saarthipedagogystudentsv2.page.link',
      androidParameters: const AndroidParameters(
        packageName: 'com.saarthipedagogy.studentsv2',
      ),
      iosParameters:
          const IOSParameters(bundleId: 'com.saarthipedagogy.studentsv2'),
    );
    return await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
  }

  void listenDynamicLink() async {
    try {
      /// get intial links
      /// when app is not open
      ///
      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      handleDynamicLink(
        link: initialLink?.link ?? Uri.parse(''),
      );

      /// listen dynamic link
      /// when app is open
      ///
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
        print('call this listen');
        handleDynamicLink(
          link: dynamicLink.link,
        );
      });
    } catch (e) {
      debugPrint('Cannot listen link $e');
    }
  }

  void handleDynamicLink({required Uri link}) async {
    final loginController = Get.put(LoginController());
    try {
      if (link.queryParameters.containsKey('type') &&
          link.queryParameters.containsKey('value')) {
        DynamicLinkQueryData queryData = DynamicLinkQueryData(
          type: link.queryParameters['type'] ?? '',
          value: link.queryParameters['value'] ?? '',
        );

        switch (queryData.type) {
          case AppStrings.register:
            // registrationController.onRegistrationByDynamicLink(dynamicLinkData: queryData);
            try {
              bool isUserLoggedIn =
                  StorageManager().getUserIsLogeedInFromLocalStorage() ?? false;

              String schoolId = queryData.value;

              if (schoolId.isEmpty) {
                throw new Exception('SchoolId is empty');
              }

              if (!isUserLoggedIn) {
                Get.offAllNamed(
                  AppRoutes.dynamicLinkLogin,
                  arguments:
                      AppDataModel(isFromDynamicLink: true, schoolId: schoolId),
                );
                return;
              }

              bool result = await loginController.getSchoolDetail(
                  schoolId: schoolId, isFromRegistrationLink: true);

              if (result) {
                List<User> allUsers =
                    await loginController.getSessionUserData();
                if (allUsers.length > 1) {
                  List<User> schoolContainUser = allUsers
                      .where((element) => element.school?.schoolId == schoolId)
                      .toList();
                  if (!schoolContainUser.isNotEmpty) {
                    Fluttertoast.showToast(
                        msg: AppStrings.youAreAlreadyRegisterWithTheSchool);
                    return;
                  }
                  Get.offAllNamed(
                    AppRoutes.registrationPage2,
                    arguments: AppDataModel(
                      schoolId: schoolId,
                      isFromAddSchoolBtn: true,
                      isBackButtonEnabled: false,
                      isFromDynamicLink: true,
                    ),
                  );
                } else {
                  Get.offAllNamed(
                    AppRoutes.dynamicLinkLogin,
                    arguments: AppDataModel(
                      schoolId: schoolId,
                      isFromAddSchoolBtn: true,
                      isBackButtonEnabled: false,
                      isSingleSchoolUser: allUsers.length == 1,
                      isFromDynamicLink: true,
                    ),
                  );
                }
              }
            } catch (e) {
              Fluttertoast.showToast(msg: AppStrings.someThingWentWrong);
            }
            return;
          default:
            print('dynamic link default');
        }
      }
    } catch (e) {
      debugPrint(
          'Something went wrong when retrieving data from the dynamic link $e');
    }
  }
}
