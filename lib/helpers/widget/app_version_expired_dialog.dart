import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/app_operation.dart';

class AppVersionExpiredDialog {
  Future showDialog(dio.Headers? headers) async {
    String currentVersion = await getAppCurrentVersion();
    String newVersion = '';
    String whatsNewMessage = '';

    if (headers?['new_version'] != null && (headers?['new_version']?.isNotEmpty ?? false)) {
      newVersion = headers?['new_version']?[0] ?? '';
    }
    if (headers?['new_version_desc'] != null && (headers?['new_version_desc']?.isNotEmpty ?? false)) {
      whatsNewMessage = headers?['new_version_desc']?[0] ?? '';
    }

    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      titlePadding: EdgeInsets.zero,
      content: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: AppColors.blueDark,
                ),
              ),
              child: const Icon(
                Icons.system_update_alt,
                size: 30,
                color: AppColors.blueDark,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppStrings.newUpdateAvailable,
              style: AppTextStyle.nunitoTextStyle16Bold(color: Colors.black),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.currentVersion,
                    style: AppTextStyle.nunitoTextStyle14Regular(color: Colors.black),
                  ),
                  TextSpan(
                    text: currentVersion,
                    style: AppTextStyle.nunitoTextStyle16Bold(color: Colors.black),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.newVersion,
                    style: AppTextStyle.nunitoTextStyle14Regular(color: Colors.black),
                  ),
                  TextSpan(
                    text: newVersion,
                    style: AppTextStyle.nunitoTextStyle16Bold(color: Colors.black),
                  ),
                ],
              ),
            ),
            whatsNewMessage.isNotEmpty ? Text('${AppStrings.whatsNew} : $whatsNewMessage') : Container(),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Platform.isAndroid
                    ? GestureDetector(
                        onTap: forceClosedApp,
                        child: Container(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                              border: Border.all(
                                width: 1,
                                color: AppColors.blue,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                            child: Center(
                              child: Text(
                                AppStrings.exitApp,
                                style: AppTextStyle.nunitoTextStyle12Bold(color: AppColors.blueDark),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 0.w,
                      ),
                Platform.isAndroid
                    ? SizedBox(
                        width: 10.w,
                      )
                    : SizedBox(
                        width: 0.w,
                      ),
                GestureDetector(
                  onTap: openPlayStoreAppStore,
                  child: Container(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppColors.blue,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      child: Center(
                        child: Text(
                          AppStrings.updateNow,
                          style: AppTextStyle.nunitoTextStyle12Bold(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
