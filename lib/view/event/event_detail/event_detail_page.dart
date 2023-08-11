import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/event/event_detail/event_detail_controller.dart';
import 'package:students/view/event/event_detail/widget/details_tab.dart';
import 'package:students/view/event/event_detail/widget/event_card.dart';
import 'package:students/view/event/event_detail/widget/gallery_tab.dart';
import 'package:students/view/event/event_detail/widget/venue_tab.dart';
import 'package:students/view/event/event_list/widget/events_tab_custom_indicator.dart';
import 'package:students/widgets/common_app_image.dart';

class EventDetailPage extends GetView<EventDetailController> {
  const EventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    List<Tab> _tabs = [
      Tab(
        child: Text(
          AppStrings.details,
          style: AppTextStyle.readexTextStyle14Regular(
              color: AppColors.color1E3A8A),
        ),
      ),
      Tab(
        child: Text(
          AppStrings.venue,
          style: AppTextStyle.readexTextStyle14Regular(
              color: AppColors.color1E3A8A),
        ),
      ),
      Tab(
        child: Text(
          AppStrings.gallery,
          style: AppTextStyle.readexTextStyle14Regular(
              color: AppColors.color1E3A8A),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      bottomSheet: Container(
        height: 80.h,
        padding: EdgeInsets.all(16.w),
        color: AppColors.colorWhite,
        child: Container(
          height: 50.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.blueGray200,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            AppStrings.joinNow,
            style:
                AppTextStyle.readexTextStyle14Medium(color: AppColors.gray500),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(AppStrings.event,
            style: AppTextStyle.poppinsTextStyle18Medium(
                color: AppColors.gray800)),
        backgroundColor: AppColors.colorTransparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(
              left: 16.r,
              top: 12.r,
              bottom: 12.r,
              right: 10.r,
            ),
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 17.r,
        ),
        child: Column(
          children: [
            EventDetailCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppColors.colorDC2945,
                      size: 20.h,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text('875 ${AppStrings.likes}',
                        style: AppTextStyle.readexTextStyle12Regular(
                            color: AppColors.color1E3A8A)),
                    SizedBox(
                      width: 10.h,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40.h,
                      margin: EdgeInsets.only(
                        right: 5.r,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.imageList.length,
                        itemBuilder: (context, index) {
                          return Align(
                            widthFactor: 0.6,
                            child: CircleAvatar(
                              radius: 11,
                              backgroundColor: AppColors.colorWhite,
                              child: Container(
                                width: 20,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: CommonAppImage(
                                  imagePath:
                                      controller.imageList.elementAt(index),
                                  width: 20,
                                  radius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      '1.5k ${AppStrings.seen}',
                      style: AppTextStyle.readexTextStyle12Regular(
                          color: AppColors.gray700),
                    )
                  ],
                )
              ],
            ),
            Text(
              'FREE 1:1 ONLINE CODING WORKSHOP FOR GRADE 1-12 STUDENTS',
              style: AppTextStyle.readexTextStyle16Medium(
                  color: AppColors.gray700),
            ),
            TabBar(
              indicator: EventTabCustomIndicator(
                color: AppColors.color1E3A8A,
                height: 3.r,
                radius: 10,
              ),
              controller: controller.tabController,
              indicatorColor: AppColors.color1E3A8A,
              indicatorPadding: EdgeInsets.only(
                left: 10.r,
                right: 10.r,
              ),
              labelPadding: EdgeInsets.only(
                left: 2.r,
                right: 1.r,
              ),
              tabs: _tabs,
              onTap: (index) {
                controller.currentIndex.value = index;
                if (index == 0) {
                  controller.itemScrollController.scrollTo(
                    index: 0,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInOutCubic,
                  );
                } else if (index == 1) {
                  controller.itemScrollController.scrollTo(
                    index: 1,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInOutCubic,
                  );
                } else {
                  controller.itemScrollController.scrollTo(
                    index: 2,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInOutCubic,
                  );
                }
              },
            ),
            Divider(
              height: 1,
              indent: 9,
              endIndent: 9,
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: ScrollablePositionedList.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return DetailsTab();
                  } else if (index == 1) {
                    return VenueTab();
                  }
                  return GalleryTab(gallerylist: controller.galleryList);
                },
                itemScrollController: controller.itemScrollController,
                itemPositionsListener: controller.itemPositionListener,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
