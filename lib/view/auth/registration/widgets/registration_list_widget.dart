import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/models/auth/teaching.dart';
import 'package:students/view/auth/registration/registration_controller.dart';
import 'package:students/widgets/no_data_found_text.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  RegistrationController controller = Get.find<RegistrationController>();

  @override
  void initState() {
    super.initState();
  }

  //here we check next class's section is present or not
  bool isNeedToShowBottomBorder({required TeachingModal currentClass, required int index}) {
    if (controller.teachingClassSectionData.last == currentClass) {
      return false;
    } else {
      return (controller.teachingClassSectionData[index + 1].sections ?? []).isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.teachingClassSectionData.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.teachingClassSectionData.map((item) {
                int index = controller.teachingClassSectionData.indexOf(item);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 14.h,
                        direction: Axis.horizontal,
                        children: (item.sections ?? []).map((sectionItem) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (TeachingModal teachingModelItem in controller.teachingClassSectionData) {
                                    for (Sections sectionItem in (teachingModelItem.sections ?? [])) {
                                      sectionItem.isChecked = false;
                                    }
                                  }
                                  if (sectionItem.isChecked ?? false) {
                                    sectionItem.isChecked = false;
                                  } else {
                                    controller.isClassSelected.value = true;
                                    controller.selectedClassId.value = item.id ?? '';
                                    controller.selectedSectionId.value = sectionItem.id ?? '';
                                    sectionItem.isChecked = true;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (sectionItem.isChecked ?? false) ? AppColors.colorECFEF6 : AppColors.gray50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: (sectionItem.isChecked ?? false) ? AppColors.color00B3B2 : AppColors.gray200,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                child: Text(
                                  '${item.name}-${sectionItem.name}',
                                  style: (sectionItem.isChecked ?? false)
                                      ? AppTextStyle.poppinsTextStyle14Regular(color: AppColors.color17634A)
                                      : AppTextStyle.poppinsTextStyle14Regular(color: AppColors.color667085),
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                    isNeedToShowBottomBorder(currentClass: item, index: index)
                        ? Container(
                            width: double.infinity,
                            height: 3,
                            decoration: const BoxDecoration(
                              color: AppColors.colorShimmerHighlight,
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.colorE1E1E1,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                );
              }).toList(),
            )
          : NoDataFoundText(
              title: AppStrings.noTeachingDataFound,
            ),
    );
  }
}
