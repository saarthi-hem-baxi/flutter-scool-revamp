import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:video_player/video_player.dart';

class ConceptVideoListItemWidget extends StatefulWidget {
  const ConceptVideoListItemWidget({super.key});

  @override
  State<ConceptVideoListItemWidget> createState() =>
      _ConceptVideoListItemWidgetState();
}

class _ConceptVideoListItemWidgetState
    extends State<ConceptVideoListItemWidget> {
  bool isPlaying = false;
  late VideoPlayerController _controller;
  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0;
  bool isVisible = false;
  bool isShortTextVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    )..initialize().then((_) {
        setState(() {});
      });

    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onReadMoreTap() {
    setState(() {
      isVisible = !isVisible;
      isShortTextVisible = false;
    });
  }

  void onBackButtonTap() {
    Get.back();
  }

  void onItemtap() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void onRightSideTap() {
    scrollController.animateTo(scrollOffset = scrollOffset + 240.w,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void onLeftSideTap() {
    scrollController.animateTo(scrollOffset = scrollOffset - 240.w,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 15.w,
        ),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}.',
                      style: AppTextStyle.readexTextStyle14Regular().copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.color334155,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Expanded(
                        child: Text(
                          AppStrings.description12,
                          style:
                              AppTextStyle.readexTextStyle14Regular().copyWith(
                            fontSize: 14,
                            color: AppColors.blueGray600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isShortTextVisible,
                      child: Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.description,
                                style: AppTextStyle.readexTextStyle14Regular()
                                    .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blueGray600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: AppStrings.readMore1,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    onReadMoreTap();
                                  },
                                style: AppTextStyle.readexTextStyle12Regular()
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.color94A3B8,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Stack(
                  children: [
                    Container(
                      height: 144.h,
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          return Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              height: 174.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                color: AppColors.colorTransparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: VideoPlayer(_controller),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        left: 15,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                onItemtap();
                                                setState(() {
                                                  isPlaying = !isPlaying;
                                                });
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  color: AppColors.colorWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: isPlaying
                                                      ? Icon(
                                                          Icons.pause,
                                                          size: 12,
                                                        )
                                                      : Icon(
                                                          Icons.play_arrow,
                                                          size: 12,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Hindi',
                                              style: AppTextStyle
                                                      .readexTextStyle12Medium()
                                                  .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.colorF5F9FF,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 30,
                                          ),
                                          child: VideoProgressIndicator(
                                              _controller,
                                              allowScrubbing: true),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 75,
                      left: -7,
                      right: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  onLeftSideTap();
                                },
                                child: Image.asset(
                                  HomeImageAssets.arrowBack1,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  onRightSideTap();
                                },
                                child: Image.asset(
                                  HomeImageAssets.arrowBack12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
