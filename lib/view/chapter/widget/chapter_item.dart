import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/models/chapter/chapter_model.dart';
import 'package:students/view/chapter/chapter_list.dart';

class ChapterItem extends StatefulWidget {
  final Chapters chapters;
  final String subjectId;
  final Function() onHwTap;
  final GestureTapDownCallback onDotTap;
  final bool isHomeworkAssigened;
  const ChapterItem({
    Key? key,
    required this.chapters,
    required this.subjectId,
    required this.onHwTap,
    required this.onDotTap,
    this.isHomeworkAssigened = false,
  }) : super(key: key);

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  Timer? timer;
  @override
  void initState() {
    getAnimatedText();
    super.initState();
  }

  Timer? getAnimatedText() {
    timer = Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      shakeKey.currentState?.shake();
    });
    return timer;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getAnimatedText();
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.chapterDetailsPage,
          arguments: AppDataModel(
            chapterId: widget.chapters.chapterId,
            subjectId: widget.subjectId,
            bookId: widget.chapters.bookId,
            chapterTitle: widget.chapters.chapterName,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4.h),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(width: 1.w, color: AppColors.gray50),
            boxShadow: [
              BoxShadow(
                color: AppColors.color0052A4.withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: AppColors.color0052A4.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 3,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$chapterNumber. ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.readexTextStyle14Regular()
                                .copyWith(
                              color: AppColors.blueGray700,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.chapters.chapterName.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.readexTextStyle14Regular()
                                  .copyWith(
                                color: AppColors.blueGray700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTapDown: (details) {
                      widget.onDotTap(details);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Icon(
                        Icons.more_vert,
                        color: AppColors.blueGray600,
                        size: 15.h,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 31.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.chapters.obtainMark == widget.chapters.totalMark
                        ? Icon(
                            Icons.check_circle,
                            size: 16.h,
                            color: AppColors.color34D399,
                          )
                        : SvgPicture.asset(
                            HomeImageAssets.light,
                            height: 18.h,
                            width: 18.w,
                          ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.chapters.obtainMark.toString(),
                              style: AppTextStyle.readexTextStyle14Regular()
                                  .copyWith(
                                color: AppColors.blueGray600,
                              ),
                            ),
                            Text(
                              '/',
                              style: AppTextStyle.readexTextStyle14Regular()
                                  .copyWith(
                                color: AppColors.blueGray400,
                              ),
                            ),
                            Text(
                              widget.chapters.totalMark.toString(),
                              style: AppTextStyle.readexTextStyle14Regular()
                                  .copyWith(
                                color: AppColors.blueGray600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Concept Cleared',
                          style:
                              AppTextStyle.readexTextStyle12Regular().copyWith(
                            color: AppColors.blueGray400,
                            fontSize: 10.sp,
                          ),
                        )
                      ],
                    ),
                    widget.isHomeworkAssigened
                        ? GestureDetector(
                            onTap: () {
                              widget.onHwTap();
                            },
                            child: ShakeMe(
                              key: shakeKey,
                              shakeCount: 1,
                              shakeOffset: 10,
                              shakeDuration: Duration(milliseconds: 500),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: Text(
                                  AppStrings.homeWorkAssigned,
                                  style: AppTextStyle.readexTextStyle12Medium()
                                      .copyWith(
                                    color: AppColors.color1E3A8A,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
