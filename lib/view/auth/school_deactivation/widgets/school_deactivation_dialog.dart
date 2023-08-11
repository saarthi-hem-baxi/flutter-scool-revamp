import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/app_operation.dart';

/// display when call get school details api
class SchoolDeactivationDialog {
  Future showDialog({required String message}) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      titlePadding: EdgeInsets.zero,
      content: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              message,
              style: AppTextStyle.poppinsTextStyle16Medium(color: Colors.black),
            ),
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
                                style: AppTextStyle.poppinsTextStyle12Medium(color: AppColors.bgBlue),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
