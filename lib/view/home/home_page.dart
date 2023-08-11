import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/firebase/dynamic_link.service.dart';

import 'package:students/view/home/home_controller.dart';
import 'package:students/view/home/widget/binge_watch_to_learn/binge_watch_to_learn_list.dart';
import 'package:students/view/home/widget/continue_learning/continue_learning_list.dart';
import 'package:students/view/home/widget/homepage_header.dart';

import 'package:students/view/home/widget/learn_o_meter_component.dart';
import 'package:students/view/home/widget/most_trending_among_learner.dart';
import 'package:students/view/home/widget/home_top_slider.dart';
import 'package:students/view/home/widget/subject_list_component.dart';
import 'package:students/view/home/widget/top10picks/top10_picks_list.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  // final AuthController authController = Get.put(AuthController());
  // final List<SubjectListModel> subjectList = [
  //   SubjectListModel('Maths', const Color(0xffFDA531), const Color(0xffFB7A16), '😍', HomeImageAssets.maths),
  //   SubjectListModel('Social Science', const Color(0xff2CAA72), const Color(0xff168439), '❤️', HomeImageAssets.socialScience),
  //   SubjectListModel('Numeracy', const Color(0xff35B3FF), const Color(0xff1B8DFD), '😊', HomeImageAssets.numeracy),
  //   SubjectListModel('Hindi', const Color(0xff004596), const Color(0xff003370), '😔', HomeImageAssets.hindi),
  //   SubjectListModel('Environmental Science', const Color(0xffDE3D73), const Color(0xffD12548), '😍', HomeImageAssets.environmentalScience),
  //   SubjectListModel('Science', const Color(0xffDADE07), const Color(0xffCACE00), '❤️', HomeImageAssets.science),
  //   SubjectListModel('Hindi Grammer', const Color(0xffA71681), const Color(0xffB7188D), '😊', HomeImageAssets.hindiGrammer),
  //   SubjectListModel('English Grammer', const Color(0xff00B3B2), const Color(0xff009999), '😔', HomeImageAssets.englishGrammer),
  // ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          // height: getScrenHeight(context),
          // width: getScreenWidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColors.navyBlueDarkExtra,
                AppColors.navyBlueDarkLight,
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  HeaderComponent(),
                  SizedBox(
                    height: 15.h,
                  ),
                  const HomeTopSlider(),
                  SizedBox(
                    height: 70.h,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SubjectListComponent(
                          subjectList: controller.subjectList,
                          username: controller.user.value?.name == null
                              ? ('${controller.user.value?.firstName}')
                              : ('${controller.user.value?.name}'),
                        ),
                      ),
                      Positioned(
                        top: -90.h,
                        right: 40.w,
                        left: 40.w,
                        child: const LearnOMeterComponent(
                          progress: 60,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, bottom: 6.h),
                    child: Text(
                      'Continue Learning',
                      style: AppTextStyle.readexTextStyle18Medium(
                          color: Colors.white),
                    ),
                  ),
                  ContinueLearningWidget(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      bottom: 6.h,
                      top: 32.h,
                    ),
                    child: Text(
                      'Top 10 Picks for ${controller.user.value?.name == null ? ('${controller.user.value?.firstName}') : ('${controller.user.value?.name}')}',
                      style: AppTextStyle.readexTextStyle18Medium(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Top10PicksWidget(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      bottom: 6.h,
                      top: 32.h,
                    ),
                    child: Text(
                      'Most Trending Among Learners',
                      style: AppTextStyle.readexTextStyle18Medium(
                          color: Colors.white),
                    ),
                  ),
                  MostTrendingAmongLearner(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      bottom: 6.h,
                      top: 32.h,
                    ),
                    child: Text(
                      'Binge Watch To Learn',
                      style: AppTextStyle.readexTextStyle18Medium(
                          color: Colors.white),
                    ),
                  ),
                  BingeWatchToLearn(),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
