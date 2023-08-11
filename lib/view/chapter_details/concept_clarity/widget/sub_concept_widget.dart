import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/view/chapter_details/concept_clarity/widget/key_learning_widget.dart';

class SubconceptWidget extends StatefulWidget {
  final String subConceptName;
  final Color borderColor;
  final Color containerColor;

  const SubconceptWidget({
    super.key,
    required this.subConceptName,
    required this.borderColor,
    required this.containerColor,
  });

  @override
  State<SubconceptWidget> createState() => _SubconceptWidgetState();
}

class _SubconceptWidgetState extends State<SubconceptWidget> {
  bool isKeyConceptVisible = false;
  final keyLearningArray = [
    AppStrings.keyLearning,
    AppStrings.keyLearning1,
  ];

  final keyClearArray = [
    true,
    false,
  ];
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
              isKeyConceptVisible = !isKeyConceptVisible;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 25,
            ),
            child: Container(
              height: 28.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: AppColors.colorDDD6FE,
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
                        Image.asset(
                          HomeImageAssets.side,
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.subConceptName,
                          style:
                              AppTextStyle.readexTextStyle14Medium().copyWith(
                            fontSize: 14,
                            color: AppColors.color1F2937,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Row(
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
                                  AppStrings.perc,
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: isKeyConceptVisible,
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: KeyLearningWidget(
                    keyLearningName: keyLearningArray[index],
                    isConceptClear: keyClearArray[index],
                  ),
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
