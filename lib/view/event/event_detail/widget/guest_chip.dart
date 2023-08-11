import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';

class GuestChip extends StatelessWidget {
  final String image;
  final String name;
  const GuestChip({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(
        vertical: 8.r,
        horizontal: 12.r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              image,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.r,
            ),
            child: Text(name, style: AppTextStyle.readexTextStyle16SemiBold(color: AppColors.gray800)),
          )
        ],
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            spreadRadius: 0,
            offset: Offset(0, 4),
            color: AppColors.color0957DE.withOpacity(0.05),
          ),
        ],
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(
          100,
        ),
      ),
    );
  }
}
