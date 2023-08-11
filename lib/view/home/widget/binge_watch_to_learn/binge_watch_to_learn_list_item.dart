import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/widgets/common_app_image.dart';

class BingeWatchToLearnItem extends StatelessWidget {
  const BingeWatchToLearnItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 144.w,
          height: 200.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CommonAppImage(
                imagePath: 'https://cdn.dribbble.com/userupload/2740678/file/original-ec284b452ae3634ff7b75d3f838f2598.png?compress=1&resize=752x',
                fit: BoxFit.cover,
                width: Utils.getScreenWidth * 0.4,
                height: 200.h,
              ),
              Container(
                color: AppColors.color1B2F6E.withOpacity(0.6),
                height: 24.h,
                padding: EdgeInsets.only(left: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonAppImage(
                      imagePath: HomeImageAssets.playerIcon,
                      height: 14.h,
                      width: 14.h,
                      fit: BoxFit.cover,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
