import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';
import 'package:students/view/event/event_list/event_controller.dart';
import 'package:students/view/event/event_list/model/event.dart';
import 'package:students/view/event/event_list/widget/certificate_view_download.dart';
import 'package:students/view/event/event_list/widget/custom_pop_up_menu.dart';
import 'package:students/view/event/event_list/widget/event_join_container.dart';
import 'package:students/view/event/event_list/widget/event_registration_dialog.dart';
import 'package:students/view/event/event_list/widget/event_share_favorite.dart';
import 'package:students/view/event/event_list/widget/event_share_popup_menu_widget.dart';
import 'package:students/widgets/common_app_image.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Color textColor;
  final int maxWords;

  final EventType eventType;

  final double height;
  final bool canJoin;
  EventCard({
    required this.canJoin,
    required this.event,
    required this.height,
    required this.maxWords,
    required this.eventType,
    required this.textColor,
    super.key,
  });

  final EventController controller = Get.put(EventController());

  Widget getCTAWidget(BuildContext context) {
    if (event.eventType == EventType.upComing ||
        event.eventType == EventType.registered) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return EventRegistrationDialog();
            },
          );
        },
        child: EventJoinContainer(
          canJoin: canJoin,
          title: event.isLive ? AppStrings.joinNow : AppStrings.registerNow,
        ),
      );
    } else if (event.eventType == EventType.completed) {
      return CertificateViewDownlod(
        onTap: () {},
        canDownload: event.canDownloadCertificate,
        title: event.canDownloadCertificate == false
            ? AppStrings.viewCertificate
            : AppStrings.downloadCertificate,
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: height > 700 ? 13.r : 16.r,
      ),
      margin: EdgeInsets.symmetric(horizontal: 27.r),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorCAC4D0),
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                right: 14.r,
                top: height > 700 ? 14.r : 19.r,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30.h,
                    padding: EdgeInsets.only(
                      right: 9.r,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        event.isLive
                            ? Center(
                                child: Lottie.asset(
                                  EventImageAssets.liveLottieAnimation,
                                  fit: BoxFit.fill,
                                  height: 30.h,
                                  width: 23.w,
                                ),
                              )
                            : CommonAppImage(
                                imagePath: EventImageAssets.location),
                        Text(
                          event.isLive ? AppStrings.live : event.city,
                          style:
                              AppTextStyle.readexTextStyle16Regular().copyWith(
                            fontSize: 15.sp,
                            color: AppColors.color13224E,
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorBlack.withOpacity(0.15),
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: Offset(0, 5),
                        ),
                      ],
                      color: AppColors.colorWhite.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10.r,
                    ),
                    child: EventShareFavorite(
                      icon: Icons.favorite_border,
                    ),
                  ),
                  CustomPopupMenu(
                    child: EventShareFavorite(
                      icon: Icons.share,
                    ),
                    horizontalMargin: 40.r,
                    position: PreferredPosition.bottom,
                    verticalMargin: -8.r,
                    arrowColor: Colors.transparent,
                    barrierColor: AppColors.blueGray700.withOpacity(0.7),
                    menuBuilder: () {
                      return EventSharePopupMenuWidget();
                    },
                    pressType: PressType.singleClick,
                  )
                ],
              ),
            ),
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(
                  event.eventImage,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 16.r,
              left: 16.r,
              right: 16.r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.readexTextStyle18Regular(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CommonAppImage(
                            imagePath: EventImageAssets.calender,
                            height: 16.w,
                            width: 16.w,
                          ),
                          SizedBox(
                            width: 6.8.w,
                          ),
                          Text(
                            event.eventDate,
                            style: AppTextStyle.readexTextStyle14Regular(
                                color: AppColors.color1E3A8A),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.color1E3A8A,
                            size: 16.h,
                          ),
                          SizedBox(
                            width: 6.8.w,
                          ),
                          Text(
                            '${event.eventTime} ${AppStrings.onwards}',
                            style: AppTextStyle.readexTextStyle14Regular(
                                color: AppColors.color1E3A8A),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: AppColors.colorA61B31,
                            size: 15.h,
                          ),
                          SizedBox(
                            width: 6.8.w,
                          ),
                          Text(
                            '${event.eventLikes} ${AppStrings.likes}',
                            style: AppTextStyle.readexTextStyle14Regular(
                                color: AppColors.color1E3A8A),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.color1E3A8A,
                            size: 16.h,
                          ),
                          SizedBox(
                            width: 6.8.w,
                          ),
                          Text(
                            '${event.eventViews} ${AppStrings.seen}',
                            style: AppTextStyle.readexTextStyle14Regular(
                                color: AppColors.color1E3A8A),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.eventDetailPage);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: event.eventDescription.length > maxWords
                                ? event.eventDescription.substring(
                                    0,
                                    maxWords,
                                  )
                                : event.eventDescription,
                            style: AppTextStyle.readexTextStyle14Regular(
                                color: textColor)),
                        TextSpan(
                          text: AppStrings.readMore,
                          style:
                              AppTextStyle.readexTextStyle12Regular().copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: 14.sp,
                            color: AppColors.color1E3A8A,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [getCTAWidget(context)],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
