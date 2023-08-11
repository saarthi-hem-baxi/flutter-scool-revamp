import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/models/home/subject_list_model.dart';

import 'dart:math' as math;

import 'package:students/view/chapter/chapter_list.dart';

import 'package:students/constants/home_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/marquee/marqee.dart';

class SubjectListComponent extends StatelessWidget {
  const SubjectListComponent({
    Key? key,
    required this.subjectList,
    required this.username,
  }) : super(key: key);

  final List<SubjectListModel> subjectList;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Card(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
          color: AppColors.colorF5F7FB,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Utils.getScreenHeight > 700 ? 70.h : 90.h,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Text(
                          'Hurry ',
                          style: AppTextStyle.readexTextStyle16Medium(),
                        ),
                        SvgPicture.asset(HomeImageAssets.worldcupIcon),
                        Text(
                          ', $username Learned',
                          style: AppTextStyle.readexTextStyle16Medium(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                      height: 36.h,
                      width: Utils.getScreenWidth,
                      color: AppColors.gray300,
                      child: ScrollLoopAutoScroll(
                        duration: Duration(seconds: 50 * 4),
                        gap: 0.0,
                        child: Row(
                          children: [
                            AutoScrollListItem(
                                itemTitle: '1Two Digit Addition'),
                            AutoScrollListItem(
                                itemTitle: '2Two Digit Addition'),
                            AutoScrollListItem(
                                itemTitle: '3Two Digit Addition'),
                            AutoScrollListItem(
                                itemTitle: '4Two Digit Addition'),
                          ],
                        ),
                        scrollDirection: Axis.horizontal,
                      )

                      // Marquee(
                      //   text: 'Two Digit Addition',
                      //   scrollAxis: Axis.horizontal,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   // blankSpace: getScreenWidth(context) - 32.w,
                      //   velocity: 10.0,
                      //   pauseAfterRound: const Duration(seconds: 1),
                      //   // startPadding: 10.0,
                      //   accelerationDuration: const Duration(milliseconds: 100),
                      //   accelerationCurve: Curves.linear,
                      //   decelerationDuration: const Duration(milliseconds: 500),
                      //   decelerationCurve: Curves.easeOut,
                      //   customWidget: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: 20.w,
                      //       ),
                      //       Text(
                      //         'Two Digit Addition',
                      //         style: AppTextStyle.readexTextStyle14Medium(),
                      //       ),
                      //       SizedBox(
                      //         width: 20.w,
                      //       ),
                      //       SizedBox(
                      //         height: 20.w,
                      //         width: 20.w,
                      //         child: Image.asset(
                      //           HomeImageAssets.dancingMan,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Choose Subject',
                  style: AppTextStyle.readexTextStyle16Medium().copyWith(
                    color: AppColors.navyBlueDarkExtra,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 0.80,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: List.generate(subjectList.length, (index) {
                    return SubjectItem(subjectData: subjectList[index]);
                  }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class AutoScrollListItem extends StatelessWidget {
  const AutoScrollListItem({
    super.key,
    required this.itemTitle,
  });

  final String itemTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          itemTitle,
          style: AppTextStyle.readexTextStyle14Medium(),
        ),
        SizedBox(
          width: 20.w,
        ),
        CommonAppImage(
          imagePath: HomeImageAssets.dancingMan,
          height: 25.h,
          width: 25.h,
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}

class SubjectItem extends StatefulWidget {
  const SubjectItem({
    Key? key,
    required this.subjectData,
  }) : super(key: key);

  final SubjectListModel subjectData;

  @override
  State<SubjectItem> createState() => _SubjectItemState();
}

class _SubjectItemState extends State<SubjectItem> {
  bool isShowNumbers = false;

  late Timer _timer;
  int _start = 10;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start <= 5) {
          setState(() {
            _start--;
            isShowNumbers = false;
            print(_start);
          });
        } else {
          setState(() {
            _start--;
            isShowNumbers = true;
            print(_start);
          });
        }
        if (_start == 0) {
          _start = 10;
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.chapterListPage,
          arguments: AppDataModel(
            subjectTitle: widget.subjectData.name,
            subjectId: widget.subjectData.subjectId,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.subjectData.bgColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -8.w,
              right: -10.w,
              child: Container(
                width: 28.w,
                height: 28.w,
                // padding: EdgeInsets.all(5.h),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorWhite,
                ),
                child: isShowNumbers
                    ? FadeIn(
                        animate: true,
                        delay: Duration(milliseconds: 500),
                        duration: Duration(milliseconds: 800),
                        child: Text(
                          '5',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.poppinsTextStyle16SemiBold(),
                        ),
                      )
                    : FadeIn(
                        animate: true,
                        delay: Duration(seconds: 1),
                        duration: Duration(milliseconds: 800),
                        child: Text(
                          widget.subjectData.emoji,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.notoEmojiTextStyleRegular
                              .copyWith(fontSize: 13.sp),
                        ),
                      ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      widget.subjectData.gif,
                      height: 57.h,
                      width: 57.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: -8.w,
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.subjectData.bubbleColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.w,
                    right: -25.w,
                    child: Container(
                      height: 30.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.subjectData.bubbleColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -5.w,
                    left: -20.w,
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: Container(
                        height: 30.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(25.r),
                          ),
                          color: widget.subjectData.bubbleColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        widget.subjectData.name,
                        style:
                            AppTextStyle.poppinsTextStyle12Regular().copyWith(
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
