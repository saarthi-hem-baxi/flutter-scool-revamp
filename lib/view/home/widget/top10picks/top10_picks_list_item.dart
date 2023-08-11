import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class Top10PicksItem extends StatelessWidget {
  const Top10PicksItem({
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
                // imagePath: HomeImageAssets.demo2,
                imagePath: 'https://mars-images.imgix.net/nft/1641491571846.png?auto=compress&w=1000',
                fit: BoxFit.cover,
                height: 200.h,
                width: 144.w,
              ),
              Container(
                color: AppColors.color1B2F6E.withOpacity(0.6),
                height: 24.h,
                padding: EdgeInsets.only(
                  left: 8.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonAppImage(
                      imagePath: HomeImageAssets.playerIcon,
                      height: 14.h,
                      width: 14.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Flexible(
                      child: Text(
                        'Two Digit Addition',
                        style: AppTextStyle.readexTextStyle12Regular(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
