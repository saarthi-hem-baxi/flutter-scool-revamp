import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/event/event_list/event_controller.dart';

class EvnetFilterClear extends StatelessWidget {
  EvnetFilterClear({
    super.key,
  });

  final EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: controller.onClearFilter,
          child: Container(
            width: Utils.getScreenWidth / 3,
            height: 40.h,
            child: Center(
              child: Text(
                AppStrings.clearAll,
                style: AppTextStyle.readexTextStyle14Regular(color: AppColors.color1E3A8A),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.onClearFilter();
            Navigator.of(context).pop();
          },
          child: Container(
            width: Utils.getScreenWidth / 3,
            child: Center(
              child: Text(
                AppStrings.confirm,
                style: AppTextStyle.readexTextStyle14Regular(color: AppColors.colorWhite),
              ),
            ),
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.color1E3A8A,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        )
      ],
    );
  }
}
