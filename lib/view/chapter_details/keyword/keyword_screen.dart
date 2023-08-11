import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/view/chapter_details/keyword/widget/keyword_list_item_widget.dart';

class KeywordScreen extends StatefulWidget {
  const KeywordScreen({super.key});

  @override
  State<KeywordScreen> createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onBackBtnTap() {
    print('back Button is tapped');
  }

  void onBackButtonTap() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: KeywordListItemWidget(),
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
        AppStrings.keyword1,
        style: AppTextStyle.readexTextStyle22Medium().copyWith(
          color: AppColors.gray900,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
