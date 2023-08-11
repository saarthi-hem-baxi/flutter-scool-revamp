import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/event/event_list/model/days_filter.dart';

class EventFilterCheckBox extends StatelessWidget {
  const EventFilterCheckBox({
    super.key,
    required this.daysFilter,
    required this.setState,
  });

  final List<DaysFilter> daysFilter;
  final Function(void Function()) setState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 6.r,
      ),
      shrinkWrap: true,
      primary: false,
      itemCount: daysFilter.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (daysFilter.elementAt(index).isChecked == false) {
              (() {
                daysFilter[index].isChecked = true;
              });
            } else {
              setState(() {
                daysFilter[index].isChecked = false;
              });
            }
          },
          child: Container(
            // width: double.infinity,
            color: Colors.white,
            child: Transform.translate(
              offset: const Offset(-14, 0),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: daysFilter.elementAt(index).isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          daysFilter[index].isChecked = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      checkColor: Colors.white,
                      activeColor: AppColors.color1E3A8A,
                    ),
                    Text(
                      daysFilter[index].dayName,
                      style: AppTextStyle.readexTextStyle14Regular(
                        color: AppColors.colorBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
