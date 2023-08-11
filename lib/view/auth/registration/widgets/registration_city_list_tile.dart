import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_highlight_text/search_highlight_text.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';

class RegistrationCityListTile extends StatelessWidget {
  final String title;
  final String highlightText;
  final VoidCallback onTap;

  const RegistrationCityListTile({
    Key? key,
    required this.title,
    required this.highlightText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 10.w,
        ),
        alignment: Alignment.topLeft,
        child: SearchHighlightText(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          searchText: highlightText,
          highlightStyle: AppTextStyle.poppinsTextStyle14SemiBold(color: AppColors.gray600),
          style: AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray600),
        ),
      ),
    );
  }
}
