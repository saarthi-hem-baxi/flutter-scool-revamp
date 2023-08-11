import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// invoke this method when closed app via programatically
void forceClosedApp() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

// Redirect to app store or playstore based on [Platform]
void openPlayStoreAppStore() async {
  if (Platform.isIOS) {
    if (!await launchUrl(
      //TODO : change apple id
      Uri.parse('https://apps.apple.com/app/student-app-saarthi-pedagogy/id1611867530'),
      mode: LaunchMode.externalApplication,
    )) {
      Fluttertoast.showToast(msg: 'Cannot open app store');
    }
  } else if (Platform.isAndroid) {
    if (!await launchUrl(
      Uri.parse(
        'https://play.google.com/store/apps/details?id=com.saarthipedagogy.studentsv2',
      ),
      mode: LaunchMode.externalApplication,
    )) {
      Fluttertoast.showToast(msg: 'Cannot open play store');
    }
  }
}

// return App Name
String getAppName() {
  if (Platform.isIOS) {
    return 'student-mobile-ios';
  } else if (Platform.isAndroid) {
    return 'student-mobile-android';
  }
  return 'student-mobile-android';
}

// return current version of application Using [PackageInfo] package.
Future<String> getAppCurrentVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
