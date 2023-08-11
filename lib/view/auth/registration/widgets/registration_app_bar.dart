import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/widgets/common_back_button.dart';
import 'package:students/widgets/rounded_corner_progressbar.dart';

class CustomRegistrationAppBar extends StatelessWidget {
  const CustomRegistrationAppBar({
    Key? key,
    required this.isfromRegistrationLink,
    required this.progress,
    this.isBackButton = true,
  }) : super(key: key);

  final bool isfromRegistrationLink;
  final double progress;
  final bool isBackButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isBackButton
            ? CommonBackButton()
            : SizedBox(
                height: 35.r,
                width: 35.r,
              ),
        isfromRegistrationLink
            ? const SizedBox()
            : Expanded(
                child: Center(
                  child: SizedBox(
                    width: 120.w,
                    height: 4.h,
                    child: RoundedCornerProgressBar(
                      current: progress * 100,
                      max: 100,
                      color: AppColors.color8434A1,
                    ),
                  ),
                ),
              ),
        SizedBox(
          width: 30.w,
        )
      ],
    );
  }
}
