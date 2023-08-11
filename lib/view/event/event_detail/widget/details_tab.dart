import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/event/event_detail/widget/guest_chip.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 9.r,
            ),
            child: Row(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          6.r,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.colorShadow.withOpacity(0.15),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(0, 4),
                            )
                          ],
                          border: Border.all(
                            color: AppColors.colorE3E3E7,
                            width: 0.5.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: 18.h,
                          color: AppColors.color1E3A8A,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        '13 May, 2023',
                        style: AppTextStyle.readexTextStyle12Regular(color: AppColors.gray700),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.r,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          6.r,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.colorShadow.withOpacity(0.15),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(0, 4),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.colorE3E3E7,
                            width: 0.5.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Icon(
                          Icons.watch_later_outlined,
                          color: AppColors.color1E3A8A,
                          size: 18.h,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        '8:30 am onwards',
                        style: AppTextStyle.readexTextStyle14Regular(color: AppColors.gray700),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Text(
            'Lorem ipsu ',
            style: AppTextStyle.readexTextStyle14Regular(color: AppColors.gray700),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 9.r,
              bottom: 9.r,
            ),
            child: Text(
              'Guests',
              style: AppTextStyle.readexTextStyle16Medium(color: AppColors.color040815),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 12.r,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GuestChip(
                    name: 'Minaxi Desai',
                    image: 'https://randomuser.me/api/portraits/women/41.jpg',
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  GuestChip(
                    name: 'Minaxi Desai',
                    image: 'https://randomuser.me/api/portraits/women/41.jpg',
                  ),
                ],
              ),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
