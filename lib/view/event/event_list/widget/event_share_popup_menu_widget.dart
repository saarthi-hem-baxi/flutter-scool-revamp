import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class EventSharePopupMenuWidget extends StatelessWidget {
  const EventSharePopupMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 140.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppImage(
                  imagePath: EventImageAssets.whatsapp,
                  height: 24.h,
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 13.r,
                  ),
                  child: Text(
                    AppStrings.whatsapp,
                    style: AppTextStyle.readexTextStyle12Regular(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 140.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppImage(
                  imagePath: EventImageAssets.instagram,
                  height: 24.h,
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 13.r,
                  ),
                  child: Text(
                    AppStrings.instgram,
                    style: AppTextStyle.readexTextStyle12Regular(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 140.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppImage(
                  imagePath: EventImageAssets.facebook,
                  height: 24.h,
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 13.r,
                  ),
                  child: Text(
                    AppStrings.facebook,
                    style: AppTextStyle.readexTextStyle12Regular(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 140.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.copy,
                  color: AppColors.blueGray700,
                  size: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 13.r,
                  ),
                  child: Text(
                    AppStrings.copyLink,
                    style: AppTextStyle.readexTextStyle12Regular(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
