import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/help/help_controller.dart';
import 'package:students/view/auth/help/widget/information_list_tile.dart';
import 'package:students/widgets/common_app_image.dart';

class HelpPage extends GetView<HelpController> {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(
          () => AppClass().isShowLoading.isTrue
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => {Get.back()},
                              child: Container(
                                height: 32,
                                width: 32,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: const BoxDecoration(
                                  color: AppColors.colorF2F4F7,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_outlined,
                                  size: 18,
                                  color: AppColors.gray800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              Center(
                                child: CommonAppImage(
                                  imagePath: AuthImageAssets.customerCare,
                                  width: 30,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Help',
                                style: AppTextStyle.poppinsTextStyle16Regular(
                                  color: AppColors.gray800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          (controller.helpPageContactData.value.executiveName ?? '').trim().isNotEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray20,
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.helpPageContactData.value.executiveName ?? '',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.poppinsTextStyle18Regular().copyWith(
                                          color: AppColors.gray800,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppStrings.contactPerson,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.poppinsTextStyle14Regular().copyWith(
                                          color: AppColors.gray400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: Utils.getScreenWidth,
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: AppColors.gray20,
                                  ),
                                  child: Text(
                                    AppStrings.saarthiPedagogySupport,
                                    style: AppTextStyle.poppinsTextStyle20SemiBold(color: AppColors.gray800),
                                  ),
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          InformationListTile(
                            bgColor: AppColors.colorFFFDF5,
                            borderColor: AppColors.colorFFEDCC,
                            textColor: AppColors.colorBB7124,
                            iconPath: AuthImageAssets.emailYellow,
                            text: controller.helpPageContactData.value.executiveEmail ?? '',
                            onTap: () {
                              Utils.openMailApp(
                                mailAddress: controller.helpPageContactData.value.executiveEmail ?? '',
                              );
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          InformationListTile(
                            bgColor: AppColors.blue50,
                            borderColor: AppColors.blue100,
                            textColor: AppColors.color1554D1,
                            iconPath: AuthImageAssets.phoneCall,
                            text: '+91 ${controller.helpPageContactData.value.executiveContact ?? ""}',
                            onTap: () {
                              Utils.openDialer(
                                contactNumber: controller.helpPageContactData.value.executiveContact ?? '',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
