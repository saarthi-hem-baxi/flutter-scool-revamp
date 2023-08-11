import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/event/event_list/widget/custom_pop_up_menu.dart';
import 'package:students/view/event/event_list/widget/event_share_favorite.dart';
import 'package:students/view/event/event_list/widget/event_share_popup_menu_widget.dart';

class EventDetailCard extends StatelessWidget {
  const EventDetailCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          right: 14.r,
          top: Utils.getScreenHeight > 700 ? 14.r : 19.r,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                right: 9.r,
                top: 4.r,
                bottom: 5.r,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    color: AppColors.color13224E,
                    size: 23.h,
                  ),
                  Text(
                    "Online",
                    style: AppTextStyle.readexTextStyle16Regular(
                      color: AppColors.color13224E,
                    ).copyWith(
                      fontSize: 15.sp,
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
              padding: EdgeInsets.only(right: 10.r),
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
              barrierColor: AppColors.color334155.withOpacity(
                0.7,
              ),
              menuBuilder: () {
                return EventSharePopupMenuWidget();
              },
              pressType: PressType.singleClick,
            )

            //
          ],
        ),
      ),
      height: Utils.getScreenHeight > 700 ? 200.h : 230.h,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 30.r,
        bottom: 9.r,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(
              'https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
        ),
      ),
    );
  }
}
