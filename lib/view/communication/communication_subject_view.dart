import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/communication_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class CommunicationSubjectView extends StatefulWidget {
  const CommunicationSubjectView({super.key});

  @override
  State<CommunicationSubjectView> createState() => _CommunicationSubjectViewState();
}

class _CommunicationSubjectViewState extends State<CommunicationSubjectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorF7F7F7,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.64,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 8.h,
          padding: EdgeInsets.zero,
          children: List.generate(8, (index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.colorTransparent,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5.w, top: 6.h),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.colorBlack.withOpacity(0.08),
                            blurRadius: 14,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: Row(
                              children: [
                                Image.asset(
                                  CommunicationImageAssets.headerIcon,
                                  height: 36.h,
                                  width: 36.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Flexible(
                                  child: Text(
                                    index == 6 || index == 7 ? 'School' : 'Saarthi Pedagogy',
                                    style: AppTextStyle.readexTextStyle14Regular(color: AppColors.gray700).copyWith(fontWeight: FontWeight.w400),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                          index == 0 || index == 2 || index == 5
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Notifications',
                                          style: AppTextStyle.readexTextStyle10Regular(color: AppColors.gray500).copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            CommonAppImage(imagePath: CommunicationImageAssets.bell),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              '35',
                                              style: AppTextStyle.readexTextStyle14Medium(color: AppColors.gray800),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    index == 0 || index == 2 || index == 5
                        ? Positioned(
                            right: 0.0,
                            top: 0.0,
                            child: Container(
                              height: 32.h,
                              width: 32.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorF7F7F7,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.blue600,
                                ),
                                height: 24.h,
                                width: 24.h,
                                alignment: Alignment.center,
                                child: Text(
                                  '10',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.readexTextStyle12SemiBold(color: AppColors.blue25),
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
