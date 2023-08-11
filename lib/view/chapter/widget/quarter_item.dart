import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/models/chapter/chapter_model.dart';
import 'package:students/view/chapter/widget/month_item.dart';

class QuarterItem extends StatelessWidget {
  const QuarterItem({
    Key? key,
    required this.quarters,
    required this.quarterIndex,
    required this.subjectId,
  }) : super(key: key);
  final Quarters quarters;
  final int quarterIndex;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    var quarterWidget = Container(
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: Row(
        children: <Widget>[
          Container(
            width: 40.w,
            margin: EdgeInsets.only(right: 5.w),
            child: const Divider(
              color: AppColors.blueGray600,
              thickness: 1,
            ),
          ),
          Text(
            'QUARTER ${quarterIndex + 1}',
            style: AppTextStyle.readexTextStyle12Regular().copyWith(
              color: AppColors.blueGray700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5.w),
              child: const Divider(
                color: AppColors.blueGray600,
                thickness: 1,
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      children: [
        quarterWidget,
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          itemCount: quarters.months?.length,
          itemBuilder: (context, index) {
            return MonthsItem(
              months: (quarters.months?[index] ?? Months()),
              subjectId: subjectId,
            );
          },
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
