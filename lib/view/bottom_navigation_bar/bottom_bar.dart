import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/app_gradients.dart';
import 'package:students/view/auth/login/login_controller.dart';
import 'package:students/view/home/home_controller.dart';

enum BottomTab { home, communication, event, menu }

typedef OnBottomTabSeleted = Function(BottomTab);

class BottomBar extends StatefulWidget {
  final OnBottomTabSeleted onBottomTabSelected;

  const BottomBar({Key? key, required this.onBottomTabSelected}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  BottomTab activeTab = BottomTab.home;

  LoginController _loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: Platform.isIOS ? false : true,
      child: Container(
        height: kToolbarHeight + 16.h,
        decoration: const BoxDecoration(
          gradient: AppGradients.gradientBottomBarBG,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.home,
              title: 'Home',
              activeGif: AppImageAssets.bottombarHome,
              inactiveImage: AppImageAssets.bottombarInActiveHome,
              onTap: () {
                homeController.getSubjects();
                onTabClick(BottomTab.home);
              },
            ),
            SizedBox(
              width: 15.w,
            ),
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.communication,
              title: 'Communication',
              activeGif: AppImageAssets.bottombarCommunication,
              inactiveImage: AppImageAssets.bottombarInActiveCommunication,
              onTap: () {
                onTabClick(BottomTab.communication);
              },
            ),
            SizedBox(
              width: 15.w,
            ),
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.event,
              title: 'Event',
              activeGif: AppImageAssets.bottombarEvent,
              inactiveImage: AppImageAssets.bottombarInActiveEvent,
              onTap: () {
                onTabClick(BottomTab.event);
              },
            ),
            // BottomBarItem(
            //   activeTab: activeTab,
            //   tab: BottomTab.menu,
            //   title: 'Menu',
            //   activeGif: AppImageAssets.bottombarMenu,
            //   inactiveImage: AppImageAssets.bottombarInActiveMenu,
            //   onTap: () {
            //     // onTabClick(BottomTab.menu);
            //   },
            // ),

            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.menu,
              title: 'Logout',
              activeGif: AppImageAssets.tempLogoutMenu,
              inactiveImage: AppImageAssets.tempLogoutMenu,
              onTap: () {
                _loginController.logout();
                // onTabClick(BottomTab.menu);
              },
            ),
          ],
        ),
      ),
    );
  }

  void onTabClick(BottomTab tab) {
    widget.onBottomTabSelected(tab);
    setState(() {
      activeTab = tab;
    });
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(
      {Key? key,
      required this.activeTab,
      required this.tab,
      required this.title,
      required this.activeGif,
      required this.inactiveImage,
      required this.onTap})
      : super(key: key);
  final BottomTab activeTab;
  final BottomTab tab;
  final String title;
  final String activeGif;
  final String inactiveImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 24.h,
              child: activeTab == tab
                  ? Image.asset(
                      activeGif,
                      height: 24.h,
                      width: 24.w,
                    )
                  : SvgPicture.asset(
                      inactiveImage,
                      height: activeTab == BottomTab.communication ? 14.h : 16.h,
                      width: activeTab == BottomTab.communication ? 14.w : 16.w,
                    ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              title,
              style: activeTab == tab
                  ? AppTextStyle.readexTextStyle12Regular().copyWith(
                      color: AppColors.colorF5F9FF,
                      fontWeight: FontWeight.w400,
                    )
                  : AppTextStyle.readexTextStyle12Regular().copyWith(
                      color: AppColors.blueGray400,
                      fontWeight: FontWeight.w400,
                    ),
            ),
            SizedBox(
              height: 2.h,
            ),
            AnimatedOpacity(
              opacity: activeTab == tab ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: Container(
                height: 4.h,
                width: 4.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
