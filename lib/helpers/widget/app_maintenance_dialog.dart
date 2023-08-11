import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/app_operation.dart';

class AppMaintenanceDialog {
  void showDialog(dio.Headers? header) {
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
                Icons.settings_suggest,
                size: 30,
                color: AppColors.blueDark,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppStrings.appUnderMaintenance,
              style: AppTextStyle.nunitoTextStyle16Bold(color: Colors.black),
            ),
            SizedBox(
              height: 20.h,
            ),
            Platform.isAndroid
                ? GestureDetector(
                    onTap: forceClosedApp,
                    child: Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: AppColors.blue,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        child: Center(
                          child: Text(
                            AppStrings.exitApp,
                            style: AppTextStyle.nunitoTextStyle12Bold(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                : Offstage()
          ],
        ),
      ),
    );
  }
}
