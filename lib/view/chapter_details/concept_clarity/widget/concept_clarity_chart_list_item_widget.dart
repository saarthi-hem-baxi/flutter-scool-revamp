import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/view/chapter_details/concept_clarity/widget/sub_concept_widget.dart';

class ConceptClarityChartListItemWidget extends StatefulWidget {
  final String conceptName;
  final String conceptPercent;
  final Color containerColor;
  final Color borderColor;

  final Function onConceptTap;

  ConceptClarityChartListItemWidget({
    super.key,
    required this.conceptName,
    required this.conceptPercent,
    required this.containerColor,
    required this.borderColor,
    required this.onConceptTap,
  });

  @override
  State<ConceptClarityChartListItemWidget> createState() =>
      _ConceptClarityChartListItemWidgetState();
}

class _ConceptClarityChartListItemWidgetState
    extends State<ConceptClarityChartListItemWidget> {
  bool isSubConceptVisible = false;
  final subConceptArray = [
    AppStrings.subConcept,
    AppStrings.subConcept2,
  ];

  final containerColorArray = [AppColors.colorE11D48, AppColors.color15803D];
  final borderColorArray = [AppColors.colorE11D48, AppColors.color15803D];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSubConceptVisible = !isSubConceptVisible;
            });
          },
          child: Container(
            height: 34.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.colorDDD6FE,
              border: Border.all(color: AppColors.colorDDD6FE),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      isSubConceptVisible
                          ? Image.asset(
                              HomeImageAssets.drop1,
                              height: 14,
                              width: 14,
                            )
                          : Image.asset(
                              HomeImageAssets.side,
                              height: 14,
                              width: 14,
                            ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.conceptName,
                        style: AppTextStyle.readexTextStyle14Medium().copyWith(
                          fontSize: 14,
                          color: AppColors.color1F2937,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 19.h,
                        width: 43.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: widget.containerColor,
                          border: Border.all(
                            width: 2,
                            color: widget.borderColor,
                          ),
                        ),
                        child: Container(
                          height: 25,
                          width: 55.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: widget.containerColor,
                            border: Border.all(
                              width: 2,
                              color: AppColors.colorWhite,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.conceptPercent,
                              style: AppTextStyle.readexTextStyle12Regular()
                                  .copyWith(
                                fontSize: 12.sp,
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 10.h,
                        width: 5.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: widget.containerColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: isSubConceptVisible,
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return SubconceptWidget(
                  subConceptName: subConceptArray[index],
                  containerColor: containerColorArray[index],
                  borderColor: borderColorArray[index],
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
