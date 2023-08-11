import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/chapter_details/TeacherExplanatoryVideo/teacher_explanatory_video_screen.dart';
import 'package:students/view/chapter_details/chapter_details_controller.dart';
import 'package:students/view/chapter_details/concept_clarity/concept_clarity_screen.dart';
import 'package:students/view/chapter_details/concept_video/concept_video_screen.dart';
import 'package:students/view/chapter_details/keyword/keyword_screen.dart';
import 'package:students/view/chapter_details/question_widget.dart';
import 'package:students/view/chapter_details/worksheet/worksheet_screen.dart';
import 'package:students/widgets/common_appbar.dart';
import 'package:students/widgets/custom_cupertino_switch.dart';
import 'package:students/widgets/loading_spinner.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChapterDetailsPage extends GetView<ChapterDetailsController> {
  @override
  Widget build(BuildContext context) {
    Map data = {
      'book': controller.arguments.bookId,
      'subject': controller.arguments.subjectId,
      'chapter': controller.arguments.chapterId,
    };
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Stack(
        children: [
          Column(
            children: [
              HeaderComponent(),
              FutureBuilder(
                future: controller.getPDFAuthToken(data: data),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return WebViewComponent(
                      pdfAUthToken: snapshot.data?.data?.token ?? '',
                    );
                  }
                  return Expanded(
                    child: Align(child: LoadingSpinner()),
                  );
                },
              ),
              FooterComponent(),
            ],
          ),
          QuestionWidget(),
        ],
      ),
    );
  }
}

WebViewController? webViewController;

class WebViewComponent extends GetView<ChapterDetailsController> {
  WebViewComponent({Key? key, required this.pdfAUthToken}) : super(key: key);

  final String pdfAUthToken;
  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            WebView(
              key: webViewKey,
              zoomEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                webViewController = controller;
                controller.loadUrl(APIUrls().weblmsUrl +
                    'student/chapter-pdf/' +
                    pdfAUthToken +
                    '/preview-pdf');
              },
              onPageFinished: (value) {
                controller.url = value.toString();
                controller.isLoadedWebView.value = true;
              },
              onProgress: (value) {
                controller.progress.value = value / 100;
              },
              javascriptChannels: {
                JavascriptChannel(
                  name: 'popupHandler',
                  onMessageReceived: (JavascriptMessage message) async {
                    print('new message: ${message.message}');
                    if (message.message == '{"openPopup":true}') {
                      controller.isOpenWebViewPopup.value = true;
                    } else if (message.message == '{"openPopup":false}') {
                      controller.isOpenWebViewPopup.value = false;
                    }
                  },
                ),
              },
            ),
            Obx(
              () => controller.progress.value < 1.0
                  ? LinearProgressIndicator(value: controller.progress.value)
                  : Offstage(),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderComponent extends GetView<ChapterDetailsController> {
  const HeaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBar(
          title: controller.arguments.chapterTitle ?? '',
          actionWidgets: [
            GestureDetector(
              onTap: () {
                onLanguageChangeTap(context);
              },
              child: Column(
                children: [
                  Image.asset(
                    HomeImageAssets.language,
                    height: 24,
                    width: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        AppStrings.english,
                        style: AppTextStyle.readexTextStyle9Regular().merge(
                          TextStyle(
                            color: AppColors.color2563EB,
                            fontWeight: FontWeight.w400,
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Image.asset(
                        HomeImageAssets.drop,
                        height: 5,
                        color: AppColors.color2563EB,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 61.w,
              height: 51.h,
              child: Obx(
                () => AnimatedOpacity(
                  opacity: controller.isOpenWebViewPopup.isTrue ? 0 : 1,
                  duration: Duration(milliseconds: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.mode,
                        style: AppTextStyle.readexTextStyle18Regular().merge(
                          TextStyle(
                            color: AppColors.blueGray400,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      CustomCupertinoSwitch(
                        value: controller.isAnimatedBook.value,
                        onChanged: () {
                          if (controller.isLoadedWebView.isTrue) {
                            webViewController?.runJavascript(
                                "document.getElementsByClassName('toggle-switch-btn')[0].click()");
                            controller.isAnimatedBook.toggle();
                          }
                        },
                      ),
                      Text(
                        controller.isAnimatedBook.isTrue
                            ? AppStrings.animatedBook
                            : AppStrings.textbook,
                        style: AppTextStyle.readexTextStyle9Regular().merge(
                          TextStyle(
                            color: controller.isAnimatedBook.isTrue
                                ? AppColors.color2563EB
                                : AppColors.gray800,
                            fontWeight: FontWeight.w400,
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  onLanguageChangeTap(context) {
    showPopupLanguageMenu(context);
  }

  Future<void> showPopupLanguageMenu(BuildContext context) {
    return showMenu(
      context: context,
      position: RelativeRect.fromDirectional(
        textDirection: TextDirection.ltr,
        top: 85.h,
        end: 00,
        start: 70,
        bottom: 00,
      ),
      elevation: 5.0,
      color: AppColors.colorF5F9FF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      items: [
        PopupMenuItem<String>(
            height: 30.h,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.hindi,
                    style: AppTextStyle.readexTextStyle14Regular().copyWith(
                      color: AppColors.blueGray700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppStrings.gujarati,
                    style: AppTextStyle.readexTextStyle14Regular().copyWith(
                      color: AppColors.blueGray700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppStrings.marathi,
                    style: AppTextStyle.readexTextStyle14Regular().copyWith(
                      color: AppColors.blueGray700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppStrings.punjabi,
                    style: AppTextStyle.readexTextStyle14Regular().copyWith(
                      color: AppColors.blueGray700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppStrings.telugu,
                    style: AppTextStyle.readexTextStyle14Regular().copyWith(
                      color: AppColors.blueGray700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            value: 'Concept Map'),
      ],
    );
  }
}

class FooterComponent extends StatefulWidget {
  const FooterComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<FooterComponent> createState() => _FooterComponentState();
}

class _FooterComponentState extends State<FooterComponent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0.3, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  void onConceptVideoScreenTap() {
    Get.to(ConceptVideoScreen());
  }

  void onTeacherExplanatoryVideoTap() {
    Get.to(TeacherExplanatoryVideoScreen());
  }

  void onKeywordTap() {
    Get.to(KeywordScreen());
  }

  void onWorksheetTap() {
    Get.to(WorksheetScreen());
  }

  Future<void> showPopupMenu(
    BuildContext context,
  ) {
    return showMenu(
      context: context,
      position: RelativeRect.fromDirectional(
        textDirection: TextDirection.ltr,
        top: 500.h,
        end: 0,
        start: 0,
        bottom: 0,
      ),
      elevation: 5.0,
      color: AppColors.colorF5F9FF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      items: [
        PopupMenuItem<String>(
          height: 150.h,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  onTeacherExplanatoryVideoTap();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      HomeImageAssets.video1,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      AppStrings.teacherExplanatoryVideo,
                      style: AppTextStyle.readexTextStyle12Regular().copyWith(
                        color: AppColors.color334155,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  onConceptVideoScreenTap();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      HomeImageAssets.play,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      AppStrings.conceptVideo,
                      style: AppTextStyle.readexTextStyle12Regular().copyWith(
                        color: AppColors.color334155,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  onKeywordTap();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      HomeImageAssets.star,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      AppStrings.keyword,
                      style: AppTextStyle.readexTextStyle12Regular().copyWith(
                        color: AppColors.color334155,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  onWorksheetTap();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      HomeImageAssets.documents,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      AppStrings.worksheet,
                      style: AppTextStyle.readexTextStyle12Regular().copyWith(
                        color: AppColors.color334155,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          value: AppStrings.worksheet,
        ),
      ],
    );
  }

  void onHomeWorkAssignedTap() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onConceptClarityTap() {
    Get.to(ConceptClarityScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              onHomeWorkAssignedTap();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    Container(
                      height: 61.h,
                      width: 170.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.colorF46B0B,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          children: [
                            SlideTransition(
                              position: _offsetAnimation,
                              child: Image.asset(
                                HomeImageAssets.rightArrow,
                                height: 20.h,
                                width: 26.w,
                                color: AppColors.colorWhite,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                AppStrings.mamAssigned,
                                style: AppTextStyle.readexTextStyle12Medium()
                                    .copyWith(
                                  color: AppColors.colorWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 90),
                      child: Container(
                        child: Image.asset(
                          HomeImageAssets.triangle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Material(
          elevation: 15.0,
          child: Container(
            width: Utils.getScreenWidth,
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 15.h, top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    showPopupMenu(context);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        HomeImageAssets.worksheet,
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        AppStrings.content,
                        style: AppTextStyle.readexTextStyle12Regular().merge(
                          TextStyle(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onConceptClarityTap();
                  },
                  child: Column(
                    children: [
                      Text(
                        '45 %',
                        style: AppTextStyle.readexTextStyle20Regular().merge(
                          TextStyle(
                            color: AppColors.color0F172A,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        AppStrings.conceptClarity,
                        style: AppTextStyle.readexTextStyle12Regular().merge(
                          TextStyle(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        HomeImageAssets.lightBulb,
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        AppStrings.homework,
                        style: AppTextStyle.readexTextStyle12Regular().merge(
                          TextStyle(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LearnOMeterWidget extends StatelessWidget {
  const LearnOMeterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 150,
          endAngle: 30,
          minimum: 0,
          maximum: 100,
          tickOffset: 20,
          canScaleToFit: false,
          showLastLabel: true,
          labelOffset: 15,
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Text(
                  'Concept Cleared',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray400,
                  ),
                ),
                angle: 90,
                positionFactor: 0.5)
          ],
          majorTickStyle: const MajorTickStyle(
            color: AppColors.color586579,
            thickness: 2,
          ),
          minorTickStyle: const MinorTickStyle(
            color: AppColors.colorDFE4E9,
            thickness: 1,
          ),
          minorTicksPerInterval: 9,
          interval: 10,
          axisLabelStyle: GaugeTextStyle(
            color: AppColors.color98A2B3,
            fontSize: 7.sp,
            fontWeight: FontWeight.normal,
            fontFamily: GoogleFonts.poppins().fontFamily ?? '',
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 20,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 20,
              endValue: 50,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 50,
              endValue: 100,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10,
            )
          ],
          pointers: const <GaugePointer>[
            NeedlePointer(
              needleLength: 1.0,
              needleColor: Color.fromRGBO(16, 24, 40, 1),
              value: 72.0,
              enableAnimation: true,
              animationType: AnimationType.linear,
              animationDuration: 4000,
              needleEndWidth: 10,
              knobStyle: KnobStyle(
                //knobRadius: 0.07,
                color: Color.fromRGBO(102, 112, 133, 1),
              ),
            ),
            // RangePointer(
            //   value: 100,
            //   width: 0.24,
            //   sizeUnit: GaugeSizeUnit.factor,
            //   cornerStyle: CornerStyle.bothCurve,
            //   enableAnimation: false,
            // )
          ],
        )
      ],
    );
  }
}
