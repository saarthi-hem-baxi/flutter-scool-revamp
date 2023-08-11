import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_text_styles.dart';

class EventTab extends StatelessWidget {
  final String title;
  final String count;
  final double height;
  final Color titleColor;
  final BoxBorder border;
  final countColor;
  final backColor;
  const EventTab({
    required this.backColor,
    required this.border,
    required this.count,
    required this.countColor,
    required this.height,
    required this.title,
    required this.titleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(title, style: AppTextStyle.readexTextStyle14Medium(color: titleColor)),
        Container(
          constraints: BoxConstraints(minHeight: 25.w, minWidth: 25.w, maxHeight: 25.w),
          padding: EdgeInsets.all(2.w),
          alignment: Alignment.center,
          child: Text(
            count,
            style: AppTextStyle.readexTextStyle14Medium(color: countColor),
          ),
          decoration: BoxDecoration(
            shape: count.length == 1 ? BoxShape.circle : BoxShape.rectangle,
            border: border,
            color: backColor,
            borderRadius: count.length == 1 ? null : BorderRadius.circular(200),
          ),
        )
      ],
    );
  }
}
