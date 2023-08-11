import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/view/chapter_details/concept_video/widget/concept_video_list_item.dart';
import 'package:video_player/video_player.dart';

class ConceptVideoScreen extends StatefulWidget {
  const ConceptVideoScreen({super.key});

  @override
  State<ConceptVideoScreen> createState() => _ConceptVideoScreenState();
}

class _ConceptVideoScreenState extends State<ConceptVideoScreen> {
  bool isPlaying = false;
  late VideoPlayerController _controller;
  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0;
  bool isVisible = false;
  bool isShortTextVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onReadMoreTap() {
    setState(() {
      isVisible = !isVisible;
      isShortTextVisible = false;
    });
  }

  void onBackButtonTap() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: ConceptVideoListItemWidget(),
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
        AppStrings.conceptVideo,
        style: AppTextStyle.readexTextStyle22Medium().copyWith(
          color: AppColors.gray900,
        ),
      ),
    );
  }
}
