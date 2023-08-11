import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/event/event_notification/event_notification_controller.dart';
import 'package:students/view/event/event_notification/models/notification.dart';
import 'package:students/view/event/event_notification/widgets/event_notification_list_item.dart';

class EventNotificationPage extends GetView<EventNotificationController> {
  EventNotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppStrings.notification,
          style: AppTextStyle.readexTextStyle20Regular(
            color: AppColors.gray800,
          ),
        ),
        backgroundColor: AppColors.colorTransparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 32.h,
            margin: EdgeInsets.only(
              left: 16.r,
              top: 12.r,
              bottom: 12.r,
              right: 10.r,
            ),
            width: 32.w,
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.gray300,
                width: 1.w,
                style: BorderStyle.solid,
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.gray900,
              size: 20.h,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 20.r,
              top: Utils.getScreenHeight > 700 ? 10.r : 15.r,
              bottom: Utils.getScreenHeight > 700 ? 10.r : 15.r,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/77.jpg',
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.r,
            right: 20.r,
          ),
          child: Column(
            children: [
              ListView.builder(
                  itemCount: controller.notificationList.length,
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 7.r,
                            bottom: 12.r,
                          ),
                          child: Text(
                            controller.notificationList.elementAt(index).day,
                            style: AppTextStyle.readexTextStyle18Regular(
                                color: AppColors.gray700),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, notificationIndex) {
                            NotificationList notificationdata = controller
                                .notificationList
                                .elementAt(index)
                                .notificationlist
                                .elementAt(notificationIndex);
                            return EventNotificationListItem(
                              notificationdata: notificationdata,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                          itemCount: controller.notificationList
                              .elementAt(index)
                              .notificationlist
                              .length,
                        ),
                      ],
                    );
                  }),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 25.r,
                  top: 7.r,
                ),
                child: Text(
                  AppStrings.noOtherNotification,
                  style: AppTextStyle.readexTextStyle14Regular().copyWith(
                    color: AppColors.color94A3B8,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
