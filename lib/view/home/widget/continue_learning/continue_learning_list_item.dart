import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/widgets/common_app_image.dart';

class ContinueLearningItem extends StatelessWidget {
  const ContinueLearningItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 232.w,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CommonAppImage(
                imagePath: HomeImageAssets.demoImage,
                fit: BoxFit.fitWidth,
                width: Utils.getScreenWidth * 0.6,
              ),
              Container(
                color: AppColors.color1B2F6E.withOpacity(0.6),
                height: 24.h,
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonAppImage(
                          imagePath: HomeImageAssets.playerIcon,
                          height: 14.h,
                          width: 14.h,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Two Digit Addition',
                          style: AppTextStyle.readexTextStyle12Regular(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '4:23',
                      style: AppTextStyle.readexTextStyle12Regular(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
