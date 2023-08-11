import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/event/event_list/model/days_filter.dart';
import 'package:students/view/event/event_list/widget/event_filter_checkbox.dart';
import 'package:students/view/event/event_list/widget/event_filter_clear.dart';
import 'package:students/view/event/event_list/widget/event_filter_header.dart';

class EventFilterSheet extends StatelessWidget {
  const EventFilterSheet({
    super.key,
    required this.days,
    required this.setState,
    required this.modes,
  });

  final List<DaysFilter> days;
  final List<DaysFilter> modes;
  final Function(void Function()) setState;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: 14.r,
          left: 25.r,
          right: 16.r,
          bottom: 22.r,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventFilterHeader(),
            Padding(
              padding: EdgeInsets.only(
                top: 10.r,
              ),
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.r,
              ),
              child: Text(
                AppStrings.day,
                style: AppTextStyle.readexTextStyle16Regular(color: AppColors.colorBlack),
              ),
            ),
            EventFilterCheckBox(
              daysFilter: days,
              setState: setState,
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.r,
                bottom: 10.r,
              ),
              child: Text(
                AppStrings.mode,
                style: AppTextStyle.readexTextStyle16Regular(color: AppColors.colorBlack),
              ),
            ),
            EventFilterCheckBox(
              daysFilter: modes,
              setState: setState,
            ),
            EvnetFilterClear()
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
