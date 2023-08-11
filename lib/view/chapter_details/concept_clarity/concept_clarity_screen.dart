import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/view/chapter_details/concept_clarity/widget/concept_clarity_chart_list_item_widget.dart';

class ConceptClarityScreen extends StatefulWidget {
  const ConceptClarityScreen({super.key});

  @override
  State<ConceptClarityScreen> createState() => _ConceptClarityScreenState();
}

class _ConceptClarityScreenState extends State<ConceptClarityScreen> {
  final conceptArray = [
    AppStrings.concept1,
    AppStrings.concept2,
  ];
  final conceptPercenArray = [
    AppStrings.perc,
    AppStrings.perc1,
  ];
  final conceptDownnArray = [
    true,
    false,
  ];
  final containerColorArray = [
    AppColors.colorCA8A04,
    AppColors.color15803D,
  ];
  final conceptBorderArray = [
    AppColors.colorCA8A04,
    AppColors.color15803D,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onBackButtonTap() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          friendsHelpWidget(),
          SizedBox(
            height: 20,
          ),
          conceptClarityChartText(),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: conceptArray.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: ConceptClarityChartListItemWidget(
                    conceptName: conceptArray[index],
                    conceptPercent: conceptPercenArray[index],
                    containerColor: containerColorArray[index],
                    borderColor: conceptBorderArray[index],
                    // isSubConceptVisible: conceptDownnArray[index],
                    onConceptTap: () {},
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget conceptClarityChartText() {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Container(
        height: 34.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColors.colorA78BFA.withOpacity(0.8),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Text(
            AppStrings.yourConceptClarity,
            style: AppTextStyle.readexTextStyle16Medium().copyWith(
              fontSize: 16,
              color: AppColors.colorWhite,
            ),
          ),
        ),
      ),
    );
  }

  Widget friendsHelpWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.colorF0FDF4,
          border: Border.all(
            color: AppColors.colorBBF7D0,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.friendsHelp,
                  style: AppTextStyle.readexTextStyle16SemiBold().copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.color0F172A,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppStrings.heyRaj,
                  style: AppTextStyle.readexTextStyle14Regular().copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueGray600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    5,
                    (index) {
                      return Container(
                        height: 30,
                        width: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.colorWhite,
                          border: Border.all(color: AppColors.colorB2E6C2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: ExactAssetImage(
                                  HomeImageAssets.profile,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Name',
                                style: AppTextStyle.readexTextStyle14Medium()
                                    .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blueGray600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget leadingIconWidget() {
    return GestureDetector(
      onTap: () {
        onBackButtonTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColors.gray300,
            ),
          ),
          child: Center(
            child: Image.asset(
              HomeImageAssets.arrowBack,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColors.colorWhite,
      elevation: 0,
      centerTitle: false,
      leading: leadingIconWidget(),
      title: Text(
        AppStrings.whyElectornsImp,
        style: AppTextStyle.readexTextStyle16Medium().copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.gray900,
        ),
      ),
    );
  }
}
