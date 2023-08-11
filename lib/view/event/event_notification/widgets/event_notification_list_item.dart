import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';
import 'package:students/view/event/event_notification/models/notification.dart';
import 'package:students/widgets/common_app_image.dart';

class EventNotificationListItem extends StatelessWidget {
  const EventNotificationListItem({
    super.key,
    required this.notificationdata,
  });

  final NotificationList notificationdata;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.eventDetailPage);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 8.r,
          bottom: 9.r,
          left: 20.r,
          right: 20.r,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(11.r),
              height: 55.h,
              alignment: Alignment.center,
              child: CommonAppImage(
                imagePath: EventImageAssets.flag,
              ),
              width: 55.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorWhite,
                border: Border.all(
                  color: AppColors.color1E3A8A,
                  style: BorderStyle.solid,
                  width: 0.5.w,
                ),
              ),
            ),
            SizedBox(
              width: 28.r,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationdata.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.readexTextStyle16Regular(color: AppColors.color0F172A),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'By ${notificationdata.receivedBy}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.readexTextStyle12Regular(
                      color: AppColors.gray500,
                    ).copyWith(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    notificationdata.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.readexTextStyle14Regular(color: AppColors.color1E3A8A),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    notificationdata.dateTime,
                    style: AppTextStyle.readexTextStyle12Regular(
                      color: AppColors.gray500,
                    ).copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: notificationdata.isReaded ? AppColors.colorWhite : AppColors.colorF5F9FF,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
