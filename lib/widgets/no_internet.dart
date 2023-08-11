import 'package:flutter/material.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/status_color_manager.dart';

class NoInternetConnectionPopUpWidget extends StatelessWidget {
  const NoInternetConnectionPopUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: StatusBarColorManager(
        color: Colors.white,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Utils.getScreenWidth,
                    height: Utils.getScreenHeight / 2.5,
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                    child: CommonAppImage(
                      imagePath: AppImageAssets.noInternet,
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      AppStrings.oopsNoInternetConnection,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.poppinsTextStyle20Bold(color: AppColors.color4D1877),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      AppStrings.pleaseCheckYourDataConnection,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.poppinsTextStyle14SemiBold(color: AppColors.color808080),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
