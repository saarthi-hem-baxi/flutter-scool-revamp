import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';

class EventRegistrationDialog extends StatelessWidget {
  const EventRegistrationDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.r,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                EventImageAssets.registrationSuccessLottieAnimation,
              ),
              Transform.translate(
                offset: Offset(0, -30),
                child: Text(
                  AppStrings.registrationSuccessful,
                  style: AppTextStyle.readexTextStyle24Bold(color: AppColors.color1E3A8A),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -23),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.r,
                  ),
                  child: Text(
                    AppStrings.loremIpsum,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.readexTextStyle16Regular(color: AppColors.gray500).copyWith(fontSize: 15.sp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.h,
                  width: 152.w,
                  margin: EdgeInsets.only(
                    bottom: 50.r,
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.okayGotIt,
                      style: AppTextStyle.readexTextStyle16Regular(color: AppColors.colorWhite).copyWith(fontSize: 15.sp),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.color1E3A8A,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: AppColors.color1E3A8A,
                      style: BorderStyle.solid,
                      width: 1.w,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        margin: EdgeInsets.only(
          top: 170.r,
          // bottom: 170.r,
          right: 35.r,
          left: 35.r,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.colorWhite,
        ),
      ),
    );
  }
}
