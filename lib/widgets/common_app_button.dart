import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_gradients.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/utils.dart';

/// Common app button used in whole app
class CommonAppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? height;
  final double? width;

  const CommonAppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.colorTransparent,
      highlightColor: AppColors.colorTransparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        height: height ?? 40.h,
        width: width ?? Utils.getScreenWidth,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            gradient: AppGradients.blueDarkGradient,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.color0B3784.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
            ]),
        child: Text(
          title,
          style: AppTextStyle.poppinsTextStyle16Medium(color: AppColors.colorWhite),
        ),
      ),
    );
  }
}
