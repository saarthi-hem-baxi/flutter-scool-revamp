import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/events_image_assets.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 17.r,
              right: 13.r,
            ),
            height: 48.h,
            width: 48.w,
            child: Center(
              child: Icon(
                Icons.share,
                color: AppColors.colorWhite,
                size: 18.h,
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.color1E3A8A,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            EventImageAssets.googleMapImage,
          ),
        ),
      ),
    );
  }
}
