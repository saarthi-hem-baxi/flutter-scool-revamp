import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_highlight_text/search_highlight_text.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class RegistrtionSchoolListTile extends StatelessWidget {
  final String title;
  final String highlightText;
  final String schoolLogoUrl;
  final VoidCallback onTap;

  const RegistrtionSchoolListTile({
    Key? key,
    required this.title,
    required this.highlightText,
    required this.schoolLogoUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 10.w,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 25.w,
              height: 25.h,
              child: CommonAppImage(
                imagePath: schoolLogoUrl.isNotEmpty ? schoolLogoUrl : AuthImageAssets.schoolPlaceholder,
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            SearchHighlightText(
              title,
              searchText: highlightText,
              highlightStyle: AppTextStyle.poppinsTextStyle14Medium(color: AppColors.gray600),
              style: AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray600),
            ),
          ],
        ),
      ),
    );
  }
}
