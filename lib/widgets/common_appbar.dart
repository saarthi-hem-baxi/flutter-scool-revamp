import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actionWidgets;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.actionWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 32.h,
                width: 32.h,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    width: 1,
                    color: AppColors.gray300,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 18,
                  color: AppColors.gray800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.readexTextStyle22Regular().copyWith(
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (actionWidgets != null) ...actionWidgets!,
          ],
        ),
      ),
    );
  }
}
