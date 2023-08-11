import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';

class WorksheetScreen extends StatefulWidget {
  const WorksheetScreen({super.key});

  @override
  State<WorksheetScreen> createState() => _WorksheetScreenState();
}

class _WorksheetScreenState extends State<WorksheetScreen> {
  @override
  void initState() {
    super.initState();
  }

  void onBackButtonTap() {
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
    );
  }

  Widget leadingIconWidget() {
    return GestureDetector(
      onTap: () {
        onBackButtonTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColors.gray300,
            ),
          ),
          child: Center(
            child: Image.asset(
              HomeImageAssets.arrowBack,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColors.colorWhite,
      elevation: 0,
      centerTitle: false,
      leading: leadingIconWidget(),
      title: Text(
        AppStrings.worksheet,
        style: AppTextStyle.readexTextStyle22Medium().copyWith(
          color: AppColors.gray900,
        ),
      ),
    );
  }
}
