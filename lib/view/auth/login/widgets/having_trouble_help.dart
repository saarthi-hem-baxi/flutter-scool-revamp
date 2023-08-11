import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';

class HavingTroubleHelpText extends StatelessWidget {
  const HavingTroubleHelpText({
    Key? key,
    this.schoolId = '',
  }) : super(key: key);

  final String? schoolId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.helpPage,
            arguments: AppDataModel(schoolId: schoolId),
          );
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.havingTrouble,
                style: AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray500),
              ),
              TextSpan(
                text: ' ${AppStrings.help}',
                style: AppTextStyle.poppinsTextStyle18Medium(color: AppColors.gray800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
