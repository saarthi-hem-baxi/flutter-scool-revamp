import 'package:flutter/material.dart';
import 'package:students/constants/app_text_styles.dart';

class NoDataFoundText extends StatelessWidget {
  final String title;

  const NoDataFoundText({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyle.poppinsTextStyle16Bold());
  }
}
