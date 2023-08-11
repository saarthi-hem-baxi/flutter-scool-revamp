import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/widgets/common_app_image.dart';

class InformationListTile extends StatelessWidget {
  const InformationListTile({
    Key? key,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.iconPath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final String iconPath;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          children: [
            CommonAppImage(
              imagePath: iconPath,
              width: 26.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Flexible(
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.poppinsTextStyle16Regular(color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
