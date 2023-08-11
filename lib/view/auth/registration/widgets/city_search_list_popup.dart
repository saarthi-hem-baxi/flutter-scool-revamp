import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/registration/registration_controller.dart';
import 'package:students/view/auth/registration/widgets/registration_city_list_tile.dart';
import 'package:students/widgets/loading_spinner.dart';
import 'package:students/widgets/no_data_found_text.dart';

class CitySearchListPopUp extends StatelessWidget {
  final RegistrationController controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCitySelected.isTrue) {
        return const SizedBox();
      } else if (controller.isCitySchoolDataLoading.isTrue) {
        return Align(
          alignment: Alignment.center,
          child: LoadingSpinner(),
        );
      } else if (controller.allCityList.isNotEmpty && controller.searchCityText.value.isNotEmpty) {
        return Expanded(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxHeight: Utils.getScreenWidth / 2),
              margin: EdgeInsets.only(left: 35.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.gray300,
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff292929).withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: controller.allCityList.map((item) {
                    return RegistrationCityListTile(
                      onTap: () {
                        controller.isCitySelected.value = true;
                        controller.selectedCityName.value = item.name ?? '';
                        controller.selectedCityId.value = item.id ?? '';
                        controller.selectedStateID.value = item.state?.id ?? '';
                        controller.selectedStateName.value = item.state?.name ?? '';
                        controller.searchSchoolTextController.value.clear();
                        controller.allSchoolList.clear();
                      },
                      title: '${item.name}, ${item.state?.name} ',
                      highlightText: controller.searchCityTextController.text.trim(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      } else if (controller.allCityList.isEmpty && controller.isCitiesSeachLoaded.isTrue && controller.searchCityText.isNotEmpty) {
        return const NoDataFoundText(title: AppStrings.cityNotFound);
      } else {
        return SizedBox();
      }
    });
  }
}
