import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';

class EventFilterHeader extends StatelessWidget {
  const EventFilterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.quickFilterEventsBy,
          style: AppTextStyle.readexTextStyle22Regular(color: AppColors.colorBlack),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: AppColors.colorBlack,
            size: 25.h,
          ),
        )
      ],
    );
  }
}
