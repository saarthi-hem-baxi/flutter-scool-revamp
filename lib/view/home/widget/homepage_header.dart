import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/home/home_controller.dart';

class HeaderComponent extends StatelessWidget {
  HeaderComponent({
    Key? key,
  }) : super(key: key);

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.h, top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hi, ${controller.user.value?.name == null ? ('${controller.user.value?.firstName} ${controller.user.value?.lastName}') : ('${controller.user.value?.name}')}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.readexTextStyle18Regular().copyWith(
                    color: AppColors.colorWhite,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          (controller.user.value?.school?.logoThumb ?? '').isNotEmpty
              ? CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    controller.user.value?.school?.logoThumb ?? '',
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
    // });
  }
}
