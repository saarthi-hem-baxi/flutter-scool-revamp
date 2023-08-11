import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

/// All app level utility methods are defined here
class Utils {
  Utils._();

  /// Hide common snack bar messages
  static void hideMessage() {
    Get.closeCurrentSnackbar();
  }

  /// Show common snack bar messages
  static void showMessage(String title, String message, {snackPosition = SnackPosition.BOTTOM}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, message, snackPosition: snackPosition);
  }

  /// Get device timezone
  static String getDeviceTimeZone() {
    return DateTime.now().timeZoneName;
  }

  /// Close keyboard
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// set status bar color to white
  static void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light)); // for the app
  }

  /// get width of screen using media query
  static double get getScreenWidth => Get.mediaQuery.size.width;

  /// get height of screen using media query
  static double get getScreenHeight => Get.mediaQuery.size.height;

  /// get ratio of screen using media query [width/height]
  static double get getScreenRatio => (Get.mediaQuery.size.width / Get.mediaQuery.size.height);

  static bool checkPasswordvalidation({required String password, required String confirmPassword}) {
    if (password.trim().isEmpty) {
      Fluttertoast.showToast(msg: AppStrings.passwordRequired);
      return false;
    } else if (confirmPassword.trim().isEmpty) {
      Fluttertoast.showToast(msg: AppStrings.confirmPasswordRequired);
      return false;
    } else if (password.length < 8) {
      Fluttertoast.showToast(msg: AppStrings.passwordAtleast8Character);
      return false;
    } else if (password.length > 32) {
      Fluttertoast.showToast(msg: AppStrings.passwordMax32Character);
      return false;
    } else if (!password.contains(RegExp(r'[a-z]'))) {
      Fluttertoast.showToast(msg: AppStrings.passwordMustContainLowerCase);
      return false;
    } else if (!password.contains(RegExp(r'[A-Z]'))) {
      Fluttertoast.showToast(msg: AppStrings.passwordMustContainUpperCase);
      return false;
    } else if (!password.contains(RegExp(r'[0-9]'))) {
      Fluttertoast.showToast(msg: AppStrings.passwordMustContainerDigit);
      return false;
    } else if (!password.contains(RegExp(r'[!@#$?%^&*,]'))) {
      Fluttertoast.showToast(msg: AppStrings.passwordMustContainerSpecial);
      return false;
    } else if (password != confirmPassword) {
      Fluttertoast.showToast(msg: AppStrings.bothPasswordAreNotMatch);
      return false;
    } else {
      return true;
    }
  }

  static Future<void> openMailApp({required String mailAddress}) async {
    try {
      String url = 'mailto:$mailAddress';
      await launchUrl(Uri.parse(url));
    } catch (e) {
      Fluttertoast.showToast(msg: AppStrings.cannotOpenMailApp);
    }
  }

  static Future<void> openDialer({required String contactNumber}) async {
    String url = Platform.isIOS ? 'tel://$contactNumber' : 'tel:$contactNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Fluttertoast.showToast(msg: AppStrings.cannotOpenCallDialer);
    }
  }
}
