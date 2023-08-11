import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/helpers/firebase/dynamic_link.service.dart';
import 'package:students/helpers/storage_manager.dart';

class SplashController extends GetxController {
  RxString splashTitle = ''.obs;

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();

    super.onInit();
    onNavigate();
  }

  /// send to dashboard page

  void onNavigate() async {
    await Future.delayed(Duration(seconds: 2)).then((value) {
      FirebaseDynamicLinkService().listenDynamicLink();
      if (StorageManager().getUserIsLogeedInFromLocalStorage() == true) {
        Get.offAllNamed(AppRoutes.bottomMainPage, arguments: AppDataModel());
      } else {
        Get.offAllNamed(AppRoutes.loginPage, arguments: AppDataModel());
      }
    });
  }
}
