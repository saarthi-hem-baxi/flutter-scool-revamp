import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/media/media_utils.dart';
import 'package:students/widgets/media/zoomable_image_view.dart';

class MediaImage extends StatelessWidget {
  const MediaImage({
    Key? key,
    required this.thumbUrl,
    required this.imageUrl,
    this.title,
    this.customWidget,
    this.margin,
    this.size = const Size(87, 87),
    this.borderRadius,
    this.fit,
  }) : super(key: key);

  final String imageUrl;
  final String thumbUrl;
  final String? title;
  final EdgeInsets? margin;
  final Size? size;
  final BorderRadius? borderRadius;
  final BoxFit? fit;

  /// if you want to use own custom widget for display thumb then use this parameters
  final Widget? customWidget;

  String getThumbUrl() {
    if (thumbUrl.isNotEmpty) {
      return thumbUrl;
    }
    return imageUrl;
  }

  Widget getThumbWidget() {
    if (thumbUrl.isEmpty && imageUrl.isEmpty) {
      return CommonAppImage(
        imagePath: AppImageAssets.brokenImage,
        fit: fit ?? BoxFit.contain,
      );
    } else if (getThumbUrl().isEmpty) {
      return CommonAppImage(
        imagePath: AppImageAssets.brokenImage,
        fit: fit ?? BoxFit.contain,
      );
    } else {
      return CommonAppImage(
        imagePath: getThumbUrl(),
        fit: fit ?? BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (imageUrl.isNotEmpty) {
          if (isLocalFileUrl(url: imageUrl)) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZoomableImageView(
                  imageUrl: '',
                  imageFile: File(imageUrl),
                  title: title ?? '',
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZoomableImageView(
                  imageUrl: imageUrl,
                  title: title ?? '',
                ),
              ),
            );
          }
        }
      },
      child: customWidget ??
          Container(
            margin: margin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size?.height,
                  width: size?.width,
                  child: ClipRRect(
                    borderRadius: borderRadius ?? BorderRadius.circular(10),
                    child: getThumbWidget(),
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
