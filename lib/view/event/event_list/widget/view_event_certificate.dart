import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as bg;
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class ViewEventCertificate extends StatelessWidget {
  const ViewEventCertificate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.gray20,
      appBar: AppBar(
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
              onTap: () {},
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
                style: AppTextStyle.readexTextStyle10Regular().copyWith(color: AppColors.colorWhite, fontSize: 7.sp),
              ),
              child: SvgPicture.asset(
                EventImageAssets.notificationIcon,
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
        leading: InkWell(
          onTap: () {
            Get.back();
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
        title: Text(
          'Event',
          style: AppTextStyle.readexTextStyle20Regular(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 210.h,
            margin: EdgeInsets.symmetric(horizontal: 50.r),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  EventImageAssets.certificateImage,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorBlack.withOpacity(0.15),
                  spreadRadius: 0,
                  blurRadius: 18,
                  offset: Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 39.h,
          ),
          Text(
            'Your Certificate Is Ready!',
            style: AppTextStyle.readexTextStyle22Bold().copyWith(
              color: AppColors.color1E3A8A,
              fontSize: 23.sp,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 80.r,
            ),
            child: Text(
              'Certificate will be saved to your camera roll.',
              textAlign: TextAlign.center,
              style: AppTextStyle.readexTextStyle16Regular().copyWith(
                color: AppColors.color667085,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 30.r),
              margin: EdgeInsets.only(
                bottom: 20.r,
                top: 20.r,
                left: 103.r,
                right: 103.r,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Download Again',
                    style: AppTextStyle.readexTextStyle16Regular().copyWith(
                      fontSize: 15.sp,
                      color: AppColors.colorWhite,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.r),
                    child: CommonAppImage(
                      imagePath: EventImageAssets.download,
                      color: AppColors.colorWhite,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.color1E3A8A,
                borderRadius: BorderRadius.circular(
                  40,
                ),
                border: Border.all(
                  color: AppColors.color1E3A8A,
                  style: BorderStyle.solid,
                  width: 1.w,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 34.r,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.shareCertificate,
                  style: AppTextStyle.readexTextStyle16Regular().copyWith(
                    color: AppColors.color1E3A8A,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Icon(
                  Icons.share,
                  color: AppColors.color1E3A8A,
                  size: 15.h,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
