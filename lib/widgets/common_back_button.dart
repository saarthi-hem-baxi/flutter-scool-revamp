import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CommonBackButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap?.call();
          } else {
            Get.back();
          }
        },
        child: Container(
          height: 35.r,
          width: 35.r,
          margin: const EdgeInsets.only(right: 20),
          decoration: const BoxDecoration(
            color: AppColors.colorF2F4F7,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: const Icon(
            Icons.arrow_back_outlined,
            size: 18,
            color: AppColors.gray800,
          ),
        ),
      ),
    );
  }
}
