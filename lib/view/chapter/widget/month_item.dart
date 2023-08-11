import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';

import 'package:students/models/chapter/chapter_model.dart';
import 'package:students/view/chapter/chapter_list.dart';
import 'package:students/view/chapter/widget/chapter_item.dart';

class MonthsItem extends StatelessWidget {
  const MonthsItem({
    Key? key,
    required this.months,
    required this.subjectId,
  }) : super(key: key);
  final Months months;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    // var monthNameBar = Container(
    //   padding: EdgeInsets.symmetric(horizontal: 5.w),
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //     color: colorMonthName,
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(6.r),
    //     ),
    //   ),
    //   child: RotatedBox(
    //     quarterTurns: 3,
    //     child: Text(
    //       months.month.toString(),
    //       style: textReadexProNormal.merge(
    //         TextStyle(
    //           color: colorWhite,
    //           fontSize: 14.sp,
    //           fontWeight: FontWeight.w600,
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Stack(
      children: [
        // Positioned(
        //   top: 0,
        //   bottom: 0,
        //   child: monthNameBar,
        // ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          itemCount: months.chapters?.length,
          itemBuilder: (context, index) {
            chapterNumber++;

            return ChapterItem(
              chapters: (months.chapters?[index] ?? Chapters()),
              subjectId: subjectId,
              onDotTap: (datail) {
                double left = datail.globalPosition.dx;
                double top = datail.globalPosition.dy;
                showPopupMenu(context, left, top);
              },
              onHwTap: () {
                onHomeWorkTapped();
              },
              isHomeworkAssigened: true,
            );
          },
        )
      ],
    );
  }

  void onHomeWorkTapped() {
    print('HomeWork Assigned is tapped');
  }

  Future<void> showPopupMenu(BuildContext context, double left, double top) {
    return showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top + 10.h, 30.w, 0),
      elevation: 5.0,
      color: AppColors.colorF5F9FF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      items: [
        PopupMenuItem<String>(
            height: 30.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  HomeImageAssets.conceptMap,
                  height: 15.h,
                  width: 15.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Concept Map',
                  style: AppTextStyle.readexTextStyle14Regular().copyWith(
                    color: AppColors.blueGray700,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            value: 'Concept Map'),
      ],
    );
  }
}
