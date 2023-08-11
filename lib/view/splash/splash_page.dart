import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/view/splash/splash_controller.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/status_color_manager.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusBarColorManager(
      color: AppColors.bgBlue,
      child: Scaffold(
        backgroundColor: AppColors.bgBlue,
        body: Center(
          child: Stack(
            children: [
              //TODO : Removed when utilize Splash Controller
              Text(controller.splashTitle.value),
              Container(
                margin: EdgeInsets.all(30.h),
                width: 250.h,
                height: 200.h,
                child: CommonAppImage(
                  imagePath: AppImageAssets.splashLogo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
