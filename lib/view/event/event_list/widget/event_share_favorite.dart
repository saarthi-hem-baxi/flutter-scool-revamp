import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/helpers/utils.dart';

class EventShareFavorite extends StatelessWidget {
  final IconData icon;
  const EventShareFavorite({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.r,
      height: 35.r,
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: AppColors.color1E3A8A,
        size: Utils.getScreenWidth > 700 ? 14.h : 18.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        border: Border.all(width: 1, color: AppColors.blueGray200),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorShadow.withOpacity(
              0.15,
            ),
            spreadRadius: 0,
            blurRadius: 16,
            offset: Offset(0, 4),
          )
        ],
      ),
    );
  }
}
