import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/communication_image_assets.dart';

class CommunicationTeacherWiseView extends StatefulWidget {
  const CommunicationTeacherWiseView({super.key});

  @override
  State<CommunicationTeacherWiseView> createState() => _CommunicationTeacherWiseViewState();
}

class _CommunicationTeacherWiseViewState extends State<CommunicationTeacherWiseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 72.h,
            color: index == 0 || index == 1 || index == 5 ? AppColors.blue50 : AppColors.colorWhite,
            margin: EdgeInsets.only(
              bottom: 8.h,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Image.asset(
                      CommunicationImageAssets.headerIcon,
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (() {
                                      if (index == 0) {
                                        return 'Maharaja Agrasen Public School';
                                      } else if (index == 1) {
                                        return 'Ajay Dave sir';
                                      } else {
                                        return 'Radhika Mishra ma’am';
                                      }
                                    }()),
                                    style: AppTextStyle.readexTextStyle14Regular(color: AppColors.gray800),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '10:30 PM',
                                    style: AppTextStyle.readexTextStyle10Medium(color: AppColors.gray600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Dear students, Kindly complete pretest of as as as chater Dear students, Kindly complete pretest of chater...',
                                      style: AppTextStyle.readexTextStyle12Regular(color: AppColors.gray500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.attach_file_sharp,
                                        size: 20.w,
                                      ),
                                      index == 0 || index == 1 || index == 5
                                          ? Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.blue600,
                                              ),
                                              height: 24.w,
                                              width: 24.w,
                                              margin: EdgeInsets.only(left: 10.w),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '10',
                                                style: AppTextStyle.readexTextStyle12SemiBold(color: AppColors.blue25),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
