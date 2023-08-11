import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:video_player/video_player.dart';

class KeyLearningWidget extends StatefulWidget {
  final String keyLearningName;
  final bool isConceptClear;
  const KeyLearningWidget({
    super.key,
    required this.keyLearningName,
    this.isConceptClear = true,
  });

  @override
  State<KeyLearningWidget> createState() => _KeyLearningWidgetState();
}

class _KeyLearningWidgetState extends State<KeyLearningWidget> {
  bool isPlaying = false;
  late VideoPlayerController _controller;
  bool isVideoVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  void onItemtap() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onClearAgainTap() {}

  void onClearSPTap() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isVideoVisible = !isVideoVisible;
              });
            },
            child: Container(
              height: 28.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: AppColors.colorDDD6FE,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        isVideoVisible
                            ? Image.asset(
                                HomeImageAssets.drop1,
                                height: 14,
                                width: 14,
                              )
                            : Image.asset(
                                HomeImageAssets.side,
                                height: 14,
                                width: 14,
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.keyLearningName,
                          style:
                              AppTextStyle.readexTextStyle14Medium().copyWith(
                            fontSize: 14,
                            color: AppColors.color1F2937,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 19.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: widget.isConceptClear
                            ? AppColors.color047857
                            : AppColors.colorB91C1C,
                      ),
                      child: Center(
                        child: widget.isConceptClear
                            ? Text(
                                AppStrings.clear,
                                style: AppTextStyle.readexTextStyle12Medium()
                                    .copyWith(
                                  color: AppColors.colorWhite,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                AppStrings.unclear,
                                style: AppTextStyle.readexTextStyle12Medium()
                                    .copyWith(
                                  color: AppColors.colorWhite,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: isVideoVisible,
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 93.h,
                    width: 170.w,
                    decoration: BoxDecoration(
                      color: AppColors.colorTransparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
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
                                    borderRadius: BorderRadius.circular(10),
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
                                'Addition',
                                style: AppTextStyle.readexTextStyle12Medium()
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
                            child: VideoProgressIndicator(_controller,
                                allowScrubbing: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      onClearAgainTap();
                    },
                    child: Container(
                      height: 28.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.color2563EB.withOpacity(0.9),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            HomeImageAssets.clear,
                            height: 25.h,
                            width: 25.w,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppStrings.clearAgain,
                            style:
                                AppTextStyle.readexTextStyle12Bold().copyWith(
                              fontSize: 13,
                              color: AppColors.colorWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      onClearAgainTap();
                    },
                    child: Container(
                      height: 28.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.color059669.withOpacity(0.9),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            HomeImageAssets.check,
                            height: 25.h,
                            width: 25.w,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppStrings.trySp,
                            style:
                                AppTextStyle.readexTextStyle12Bold().copyWith(
                              fontSize: 13,
                              color: AppColors.colorWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
