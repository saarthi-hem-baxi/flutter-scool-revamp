import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/chapter_details/chapter_details_controller.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    super.key,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isHorizontal = false;

  final controller = Get.find<ChapterDetailsController>();

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animationController.reset();
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    // start the animation automatically after a delay of 2 seconds
    Timer(Duration(seconds: 2), () {
      _toggleShape();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleShape() {
    if (mounted)
      setState(() {
        _isHorizontal = !_isHorizontal;
        _animationController.reset();
        _animationController.forward();
      });
    // schedule the next toggle after a delay of 4 seconds
  }

  @override
  Widget build(BuildContext context) {
    final queWidth =
        _isHorizontal ? 86.h + (_animation.value * (28.w - 86.h)) : 28.w + (_animation.value * (86.h - 28.w));
    final double queHeight = _isHorizontal ? 86.h + (_animation.value) : 28.w + (_animation.value);
    return Positioned(
      bottom: 0.0,
      top: 0.0,
      child: FadeInLeft(
        animate: true,
        delay: Duration(milliseconds: 300),
        duration: Duration(milliseconds: 800),
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.isOpenWebViewPopup.isTrue ? 0 : 1,
            duration: Duration(milliseconds: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: queWidth + 15.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: queWidth,
                          height: queHeight,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: _isHorizontal ? 0.0 : 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.navyBlueDark,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: RotatedBox(
                            quarterTurns: _isHorizontal ? 3 : 4,
                            child: Text(
                              AppStrings.questions,
                              style: _isHorizontal
                                  ? AppTextStyle.readexTextStyle12SemiBold(
                                      color: AppColors.colorWhite,
                                    )
                                  : AppTextStyle.readexTextStyle16SemiBold(
                                      color: AppColors.colorWhite,
                                    ),
                            ),
                          ),
                        ),
                        _isHorizontal
                            ? Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 13,
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
