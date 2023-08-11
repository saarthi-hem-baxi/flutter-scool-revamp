import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/auth/school_deactivation/school_deactivation_controller.dart';
import 'package:students/widgets/common_app_image.dart';

class SchoolDeactivationPopUpWidget extends StatefulWidget {
  const SchoolDeactivationPopUpWidget({
    Key? key,
    required this.isFromRegistrationLink,
    required this.schoolId,
  }) : super(key: key);

  final bool isFromRegistrationLink;
  final String schoolId;

  @override
  State<SchoolDeactivationPopUpWidget> createState() => _SchoolDeactivationPopUpWidgetState();
}

class _SchoolDeactivationPopUpWidgetState extends State<SchoolDeactivationPopUpWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  )..repeat();

  final SchoolDeactivationController controller = Get.put(SchoolDeactivationController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    controller.isOpenSubscriptionPopup.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Utils.getScreenHeight - 32.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: ((context, child) {
                    return Positioned(
                      top: -50,
                      child: Transform.rotate(
                        angle: _animationController.value * 2 * math.pi,
                        child: CommonAppImage(imagePath: AuthImageAssets.lightRays),
                      ),
                    );
                  }),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipRRect(
                        child: Container(
                          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 124),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.w),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(14.w), topRight: Radius.circular(14.w)),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xff3958C6), Color(0xff213373)],
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                  ),
                                ),
                                child: CommonAppImage(
                                  imagePath: AuthImageAssets.saarthiHangingLogo,
                                  height: 140.h,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      AppStrings.thankYouForChoosingSaarthiPedagogy,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.poppinsTextStyle16Medium(
                                        color: AppColors.gray800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Text(
                                      AppStrings.unfortunatelyYourTrialEnded,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.poppinsTextStyle14Regular(
                                        color: AppColors.gray700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CommonAppImage(
                                      imagePath: AuthImageAssets.animatedMessageIcon,
                                      width: 100,
                                      height: 100,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.navigateToHelpPage(
                                          isFromRegistrationLink: widget.isFromRegistrationLink,
                                          schoolId: widget.schoolId,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.blue50,
                                          border: Border.all(color: AppColors.color0F94FF),
                                          borderRadius: BorderRadius.circular(10.w),
                                        ),
                                        child: Text(
                                          AppStrings.talkToSupportNow,
                                          style: AppTextStyle.poppinsTextStyle14Medium(
                                            color: AppColors.blue600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      CommonAppImage(
                        imagePath: AuthImageAssets.childernGroup,
                        width: 350,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: InkWell(
                    onTap: controller.onCloseBtn,
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
