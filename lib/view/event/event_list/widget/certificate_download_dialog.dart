import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';

class CertificateDownloadDialog extends StatefulWidget {
  const CertificateDownloadDialog({
    super.key,
  });

  @override
  State<CertificateDownloadDialog> createState() => _CertificateDownloadDialogState();
}

class _CertificateDownloadDialogState extends State<CertificateDownloadDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.r,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 55.r,
                ),
                child: LottieBuilder.asset(
                  EventImageAssets.certificateLottieAnimation,
                  height: 152.h,
                  width: 152.w,
                ),
              ),
              Text(
                AppStrings.downloadSuccessfull,
                style: AppTextStyle.readexTextStyle22Bold(
                  color: AppColors.color1E3A8A,
                ).copyWith(fontSize: 23.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                ),
                child: Text(
                  AppStrings.certificateWillBeSavedToYourCameraRoll,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.readexTextStyle16Regular().copyWith(
                    fontSize: 15.sp,
                    color: AppColors.color667085,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 152.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.r,
                    vertical: 10.r,
                  ),
                  margin: EdgeInsets.only(
                    bottom: 10.r,
                    top: 20.r,
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.okayGotIt,
                      style: AppTextStyle.readexTextStyle16Regular().copyWith(
                        fontSize: 15.sp,
                        color: AppColors.colorWhite,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.color1E3A8A,
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                    border: Border.all(
                      color: AppColors.color1E3A8A,
                      style: BorderStyle.solid,
                      width: 1.w,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 34.r,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.shareCertificate,
                      style: AppTextStyle.readexTextStyle16Regular(
                        color: AppColors.color1E3A8A,
                      ).copyWith(
                        fontSize: 15.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Icon(
                      Icons.share,
                      color: AppColors.color1E3A8A,
                      size: 15.h,
                    )
                  ],
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
