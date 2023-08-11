import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/widgets/media/loading/loading_slide1.dart';
import 'package:students/widgets/media/loading/loading_slide2.dart';
import 'package:students/widgets/media/loading/loading_slide3.dart';

class LoadingSheetWidget extends StatefulWidget {
  const LoadingSheetWidget({Key? key}) : super(key: key);

  @override
  State<LoadingSheetWidget> createState() => _LoadingSheetWidgetState();
}

class _LoadingSheetWidgetState extends State<LoadingSheetWidget> {
  PageController? _pageController;

  int _currentPage = 0;
  Timer? _timer;

  bool isChange = true;

  final List<Widget> _pageList = [
    FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: const LoadingSlide1(),
    ),
    FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: const LoadingSlide2(),
    ),
    FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: const LoadingSlide3(),
    ),
  ];

  final List<Widget> _pageList3 = [
    const LoadingText1(),
    const LoadingText2(),
    const LoadingText3(),
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _pageList.length - 1) {
        _currentPage++;
        isChange = false;
      } else {
        isChange = false;
        _currentPage = 0;
      }
      setState(() {});

      _pageController?.animateToPage(
        _currentPage,
        duration: Duration.zero,
        curve: Curves.easeOutQuad,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.w),
          topRight: Radius.circular(25.w),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 30,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) => _pageList3[_currentPage]),
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const LinearProgressIndicator(
            color: Color(0xff167E71),
            backgroundColor: Color(0xffE4E7EC),
          ),
          SizedBox(
            height: 234,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) => _pageList[_currentPage]),
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingText1 extends StatelessWidget {
  const LoadingText1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 1500),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: AppStrings.higher,
          style: AppTextStyle.nunitoTextStyle18Bold(color: Colors.black),
          children: [
            TextSpan(
              text: AppStrings.learningOutcome,
              style: AppTextStyle.nunitoTextStyle18Medium(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingText2 extends StatelessWidget {
  const LoadingText2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 1500),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: AppStrings.personalised,
          style: AppTextStyle.nunitoTextStyle18Bold(color: Colors.black),
          children: [
            TextSpan(
              text: AppStrings.learningPaths,
              style: AppTextStyle.nunitoTextStyle18Medium(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingText3 extends StatelessWidget {
  const LoadingText3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 1500),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: AppStrings.twentyFourBy7,
          style: AppTextStyle.nunitoTextStyle18Bold(color: Colors.black),
          children: [
            TextSpan(
              text: AppStrings.accessToSchoolAtHome,
              style: AppTextStyle.nunitoTextStyle18Medium(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
