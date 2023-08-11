import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/media/media_utils.dart';
import 'package:students/widgets/media/media_video_player.dart';

class MediaDocument extends StatelessWidget {
  const MediaDocument({
    Key? key,
    required this.docUrl,
    this.title,
    this.margin,
    this.customWidget,
    this.size = const Size(87, 87),
    this.borderRadius,
    this.backgroundColor,
    this.thumbBoxDecoration,
    this.customIcon,
  }) : super(key: key);

  final String docUrl;
  final String? title;
  final EdgeInsets? margin;
  final Size? size;
  final BorderRadius? borderRadius;

  // when use thumbBoxDecoration then no need to use background color
  final Color? backgroundColor;

  /// if you want to use own custom box decoration for thumb container
  final BoxDecoration? thumbBoxDecoration;

  /// if you want to use own custom widget for display icon then use this parameters
  final Widget? customIcon;

  /// if you want to use own custom widget for display thumb then use this parameters
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLocalFileUrl(url: docUrl)) {
          openLocalMediaFile(path: docUrl);
        } else {
          if (isYoutubeUrl(url: docUrl)) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MediaVideoPlayer(
                  isYoutubeVideo: true,
                  videoUrl: docUrl,
                ),
              ),
            );
          } else {
            downloadOpen(docUrl);
          }
        }
      },
      child: customWidget ??
          Container(
            margin: margin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size?.height,
                  width: size?.width,
                  decoration: thumbBoxDecoration ??
                      BoxDecoration(
                        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(10)),
                        color: backgroundColor ?? AppColors.colorF5EDFD,
                      ),
                  alignment: AlignmentDirectional.center,
                  child: customIcon ??
                      CommonAppImage(
                        imagePath: AppImageAssets.docThumbIcon,
                        height: 53,
                        width: 50,
                      ),
                ),
                SizedBox(
                  height: (title ?? '').isNotEmpty ? 10.h : 0,
                ),
                (title ?? '').isNotEmpty
                    ? SizedBox(
                        width: size?.width,
                        height: 28.h,
                        child: Text(
                          title ?? '',
                          style: AppTextStyle.poppinsTextStyle12SemiBold(color: AppColors.color4D1877),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
    );
  }
}
