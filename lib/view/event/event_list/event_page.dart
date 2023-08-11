import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';
import 'package:students/view/event/event_list/event_controller.dart';
import 'package:students/view/event/event_list/model/event.dart';
import 'package:students/view/event/event_list/widget/event_card.dart';
import 'package:students/view/event/event_list/widget/event_filter_sheet.dart';
import 'package:students/view/event/event_list/widget/event_tab.dart';
import 'package:students/view/event/event_list/widget/events_tab_custom_indicator.dart';

import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/status_color_manager.dart';

class EventPage extends GetView<EventController> {
  EventPage({super.key});

  final EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    TabBar _tabBar = TabBar(
      indicator: EventTabCustomIndicator(
        color: AppColors.color1E3A8A,
        height: 3.r,
        radius: 10,
      ),
      onTap: (value) {
        controller.currentIndex.value = value;
      },
      indicatorColor: AppColors.color1E3A8A,
      indicatorPadding: EdgeInsets.only(
        left: 10.r,
        right: 10.r,
      ),
      labelPadding: EdgeInsets.only(
        left: 2.r,
        right: 1.r,
      ),
      tabs: [
        Obx(
          () => Tab(
            child: EventTab(
              height: height,
              border: controller.currentIndex != 0
                  ? Border.all(
                      color: AppColors.colorCBD5E1,
                      width: 1.w,
                      style: BorderStyle.solid,
                    )
                  : Border.all(
                      color: Colors.transparent,
                    ),
              title: AppStrings.upcoming,
              count: controller.eventsData.where((element) => element.eventType == EventType.upComing).length.toString(),
              countColor: controller.currentIndex == 0 ? AppColors.colorF8FAFC : AppColors.gray500,
              backColor: controller.currentIndex == 0 ? AppColors.gray800 : AppColors.blueGray200,
              titleColor: controller.currentIndex == 0 ? AppColors.color1E293B : AppColors.gray500,
            ),
          ),
        ),
        Obx(
          () => Tab(
            child: EventTab(
              height: height,
              border: controller.currentIndex != 1
                  ? Border.all(
                      color: AppColors.colorCBD5E1,
                      width: 1.w,
                      style: BorderStyle.solid,
                    )
                  : Border.all(
                      color: Colors.transparent,
                    ),
              title: AppStrings.registered,
              count: controller.eventsData.where((element) => element.eventType == EventType.registered).length.toString(),
              countColor: controller.currentIndex == 1 ? AppColors.colorF8FAFC : AppColors.gray500,
              backColor: controller.currentIndex == 1 ? AppColors.color1F2937 : AppColors.blueGray200,
              titleColor: controller.currentIndex == 1 ? AppColors.color1E293B : AppColors.gray500,
            ),
          ),
        ),
        Obx(
          () => Tab(
            child: EventTab(
              height: height,
              border: controller.currentIndex != 2
                  ? Border.all(
                      color: AppColors.colorCBD5E1,
                      width: 1.w,
                      style: BorderStyle.solid,
                    )
                  : Border.all(
                      color: Colors.transparent,
                    ),
              title: AppStrings.completed,
              count: controller.eventsData.where((element) => element.eventType == EventType.completed).length.toString(),
              countColor: controller.currentIndex == 2 ? AppColors.colorF8FAFC : AppColors.gray500,
              backColor: controller.currentIndex == 2 ? AppColors.color1F2937 : AppColors.blueGray200,
              titleColor: controller.currentIndex == 2 ? AppColors.color1E293B : AppColors.gray500,
            ),
          ),
        ),
      ],
    );

    return Stack(
      children: [
        DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: StatusBarColorManager(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: AppColors.gray20,
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: _tabBar.preferredSize,
                  child: ColoredBox(
                    color: AppColors.colorWhite,
                    child: _tabBar,
                  ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.gray20,
                elevation: 0,
                centerTitle: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20.r,
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return EventFilterSheet(
                                  setState: setState,
                                  days: controller.daysfilter,
                                  modes: controller.modesFilter,
                                );
                              },
                            );
                          },
                        );
                      },
                      child: CommonAppImage(
                        imagePath: EventImageAssets.filterIcon,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20.r,
                      top: height > 700 ? 17.r : 20.r,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.eventNotificationPage);
                      },
                      child: bg.Badge(
                        badgeStyle: bg.BadgeStyle(
                          badgeColor: AppColors.colorF43F5E,
                          elevation: 0,
                        ),
                        position: bg.BadgePosition.custom(
                          top: -5.r,
                          end: -6.r,
                        ),
                        badgeContent: Text(
                          '2',
                          style: AppTextStyle.readexTextStyle10Regular(color: AppColors.colorWhite).copyWith(fontSize: 7.sp),
                        ),
                        child: CommonAppImage(
                          imagePath: EventImageAssets.notificationIcon,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20.r,
                      top: height > 700 ? 10.r : 15.r,
                      bottom: height > 700 ? 10.r : 15.r,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/77.jpg',
                      ),
                    ),
                  ),
                ],
                title: Text(AppStrings.event, style: AppTextStyle.readexTextStyle20Regular()),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: controller.eventsData.where((element) => element.eventType == EventType.upComing).length,
                                padding: EdgeInsets.only(
                                  top: height > 700 ? 19.r : 24.r,
                                  bottom: height > 700 ? 19.r : 24.r,
                                ),
                                separatorBuilder: ((context, index) {
                                  return SizedBox(
                                    height: 22.h,
                                  );
                                }),
                                itemBuilder: (context, index) {
                                  Event event = controller.eventsData.where((element) => element.eventType == EventType.upComing).toList()[index];
                                  return EventCard(
                                    height: height,
                                    event: event,
                                    textColor: AppColors.color1E3A8A,
                                    maxWords: 95,
                                    canJoin: true,
                                    eventType: event.eventType,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: controller.eventsData.where((element) => element.eventType == EventType.registered).length,
                                padding: EdgeInsets.only(
                                  top: 19.r,
                                  bottom: 19.r,
                                ),
                                separatorBuilder: ((context, index) {
                                  return SizedBox(
                                    height: 22.h,
                                  );
                                }),
                                itemBuilder: (context, index) {
                                  Event event = controller.eventsData.where((element) => element.eventType == EventType.registered).toList()[index];
                                  return EventCard(
                                    height: height,
                                    event: event,
                                    textColor: AppColors.gray600,
                                    maxWords: 75,
                                    canJoin: false,
                                    eventType: event.eventType,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: controller.eventsData.where((element) => element.eventType == EventType.completed).length,
                                padding: EdgeInsets.only(
                                  top: 19.r,
                                  bottom: 19.r,
                                ),
                                separatorBuilder: ((context, index) {
                                  return SizedBox(
                                    height: 22.h,
                                  );
                                }),
                                itemBuilder: (context, index) {
                                  Event event = controller.eventsData.where((element) => element.eventType == EventType.completed).toList()[index];
                                  return EventCard(
                                    height: height,
                                    event: event,
                                    textColor: AppColors.gray600,
                                    maxWords: 75,
                                    canJoin: false,
                                    eventType: event.eventType,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
