import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';

class CustomCupertinoSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeBallColor;
  final Color? inactiveBallColor;

  const CustomCupertinoSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColors.color1D4ED8,
    this.inactiveColor = AppColors.gray700,
    this.activeBallColor = AppColors.colorDBEAFE,
    this.inactiveBallColor = AppColors.gray400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        width: 48.w,
        height: 24.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: value ? activeColor : inactiveColor,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 24.w : 4.w,
              top: 2.h,
              bottom: 2.h,
              child: Container(
                width: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? activeBallColor : inactiveBallColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
