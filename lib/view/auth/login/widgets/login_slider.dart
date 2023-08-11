import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/view/auth/login/widgets/login_slider_slider1.dart';
import 'package:students/view/auth/login/widgets/login_slider_slider2.dart';
import 'package:students/view/auth/login/widgets/login_slider_slider3.dart';
import 'package:students/view/auth/login/widgets/login_slider_slider4.dart';

class LoginSlider extends StatefulWidget {
  LoginSlider({Key? key}) : super(key: key);

  @override
  State<LoginSlider> createState() => _LoginSliderState();
}

class _LoginSliderState extends State<LoginSlider> {
  final PageController _pageController = PageController();
  final ValueNotifier<double> notifier = ValueNotifier(0);
  List<Widget> _pageList = [];
  double currentPage = 0;
  late Timer _timer;
  bool isReverse = false;

  List<String> sliderText = [
    AppStrings.leadingPreKnowledge,
    AppStrings.anyTimeAnyWhere,
    AppStrings.textBookAndLearning,
    AppStrings.personalisedGuided,
  ];

  @override
  void initState() {
    _pageController.addListener(_onScroll);
    _pageList = [
      LoginSliderSlide1(page: 0, notifier: notifier),
      LoginSliderSlide2(page: 1, notifier: notifier),
      LoginSliderSlide3(page: 2, notifier: notifier),
      LoginSliderSlide4(page: 3, notifier: notifier)
    ];

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage < _pageList.length - 1 && !isReverse) {
        isReverse = false;
        currentPage++;
        setState(() {});
      } else {
        if (currentPage == 0) {
          isReverse = false;
        } else {
          isReverse = true;
          currentPage--;
        }
        setState(() {});
      }
      _pageController.animateToPage(
        currentPage.toInt(),
        duration: const Duration(seconds: 2),
        curve: Curves.ease,
      );
    });

    super.initState();
  }

  void _onScroll() {
    notifier.value = _pageController.page ?? 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.95,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => _pageList[index % 4]),
            onPageChanged: (v) {
              currentPage = v.toDouble();
            },
          ),
          Align(
            alignment: const Alignment(0, 0.7),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Text(
                sliderText[currentPage.toInt() % 4],
                key: ValueKey<String>(
                  sliderText[currentPage.toInt() % 4],
                ),
                textAlign: TextAlign.center,
                style: AppTextStyle.poppinsTextStyle18SemiBold(color: AppColors.gray800),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _pageList.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 4,
                dotWidth: 6,
                spacing: 4,
                activeDotColor: Color(0xFF98A2B3),
                dotColor: Color(0xFFD0D5DD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
