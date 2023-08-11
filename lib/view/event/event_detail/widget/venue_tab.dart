import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/event/event_detail/widget/google_map.dart';

class VenueTab extends StatelessWidget {
  const VenueTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '103-A, FOUR PLUS COMPLEX ASTRON CHOWK, Sardar Nagar Main Rd, Rajkot, Gujarat 360001,PLUS COMPLEX ASTRON CHOWK, Sardar Nagar Main Rd, Rajkot, Gujarat 360001,',
            style: AppTextStyle.readexTextStyle14Regular(
              color: AppColors.gray800,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 16.r,
              bottom: 8.r,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.openGoogleMap,
                  style: AppTextStyle.readexTextStyle16Medium(
                      color: AppColors.gray800),
                ),
                Text(
                  AppStrings.viewInGoogleMap,
                  style: AppTextStyle.readexTextStyle14Medium().copyWith(
                    color: AppColors.greenLight,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          GoogleMapWidget()
        ],
      ),
    );
  }
}
