import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/models/chapter/chapter_model.dart';
import 'package:students/view/chapter/chapter_controller.dart';
import 'package:students/view/chapter/widget/quarter_item.dart';
import 'package:students/widgets/status_color_manager.dart';

int chapterNumber = 0;

class ChapterList extends GetView<ChapterController> {
  ChapterList({Key? key}) : super(key: key);

  // final List<Quarters>? chapterList = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return StatusBarColorManager(
        color: AppColors.navyBlueDark,
        child: Scaffold(
          backgroundColor: AppColors.blueGray100,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: Utils.getScreenHeight * .3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0,
                        color: AppColors.navyBlue,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          AppColors.navyBlue,
                          AppColors.navyBlueDark,
                          AppColors.navyBlueDark,
                        ],
                        stops: [0.0, 0.2813, 1.0],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.r),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          AppColors.navyBlue,
                          AppColors.navyBlueDark,
                          AppColors.navyBlueDark,
                        ],
                        stops: [0.0, 0.2813, 1.0],
                      ),
                    ),
                    child: Container(
                      height: Utils.getScreenHeight * .7,
                      decoration: BoxDecoration(
                        color: AppColors.blueGray100,
                        border: Border.all(
                          width: 0,
                          color: AppColors.blueGray100,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.r),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 30.h),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: MediaQuery.of(context).padding.bottom),
                          itemCount: controller.chapterList?.length,
                          itemBuilder: (_, index) {
                            chapterNumber = 0;
                            return QuarterItem(
                              quarterIndex: index,
                              quarters: (controller.chapterList?[index] ??
                                  Quarters()),
                              subjectId: controller.arguments.subjectId ?? '',
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          HeaderComponent(
                              subjectName:
                                  controller.arguments.subjectTitle ?? ''),
                          SizedBox(
                              height:
                                  Utils.getScreenHeight > 700 ? 44.h : 35.h),
                          // SizedBox(height: Utils.getScreenHeight * .06),
                          ChapterDetails(),
                        ],
                      ),
                      // Positioned(
                      //   top: 50.h,
                      //   right: 15.w,
                      //   child: Container(
                      //     height: 160.h,
                      //     alignment: Alignment.centerRight,
                      //     width: Utils.getScreenWidth,
                      //     child: Container(
                      //       height: 170.h,
                      //       width: 125.w,
                      //       decoration: BoxDecoration(
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: AppColors.colorBlack.withOpacity(0.15),
                      //             offset: const Offset(0, 1),
                      //             blurRadius: 8,
                      //             spreadRadius: 0,
                      //           )
                      //         ],
                      //       ),
                      //       child: Card(
                      //         elevation: 0,
                      //         color: Colors.transparent,
                      //         child: Image.asset(
                      //           HomeImageAssets.bookCover,
                      //           fit: BoxFit.fill,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                      Positioned(
                        top: 55.h,
                        right: 20.w,
                        child: Container(
                          // color: Colors.amber,
                          width: Utils.getScreenWidth,
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: Utils.getScreenWidth,
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: AppColors.colorBlack.withOpacity(0.15),
                                  offset: const Offset(0, 1),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                )
                              ]),
                              child: Image.asset(
                                height: 161.h,
                                width: 150.w,
                                HomeImageAssets.bookCover,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// class _ChapterListState extends State<ChapterList> {

//   @override
//   void initState() {
//     super.initState();
//     readJson();
//   }

//   Future<void> readJson() async {
//     final String response = await rootBundle.loadString('assets/chapter_dummy.json');
//     final data = await json.decode(response);
//     ChapterListModel chapterListModel = ChapterListModel.fromJson(data);
//     setState(() {
//       chapterList = chapterListModel.quarters;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class HeaderComponent extends StatelessWidget {
  final String subjectName;

  const HeaderComponent({
    Key? key,
    required this.subjectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 10.w, top: Utils.getScreenHeight > 700 ? 32.h : 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.colorWhite,
              size: 20.h,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            subjectName,
            style: AppTextStyle.readexTextStyle22Regular().copyWith(
              color: AppColors.colorWhite,
            ),
          )
        ],
      ),
    );
  }
}

class ChapterDetails extends StatelessWidget {
  const ChapterDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 38.w, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        HomeImageAssets.light,
                        height: 14.h,
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '6/14',
                        style: AppTextStyle.readexTextStyle16Regular().copyWith(
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Chapter Completion',
                    style: AppTextStyle.readexTextStyle12Regular().copyWith(
                      color: AppColors.colorWhite,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        HomeImageAssets.meter,
                        height: 14.h,
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '85',
                              style: AppTextStyle.readexTextStyle16Regular()
                                  .copyWith(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '%',
                              style: AppTextStyle.readexTextStyle10Regular()
                                  .copyWith(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Concept Understood',
                    style: AppTextStyle.readexTextStyle12Regular().copyWith(
                      color: AppColors.colorWhite,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            height: 30.h,
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            decoration: const BoxDecoration(
              color: AppColors.color2D50B8,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Dashboard',
                  style: AppTextStyle.readexTextStyle12Regular().copyWith(
                    color: AppColors.colorWhite,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 10.h,
                  color: AppColors.colorWhite,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
