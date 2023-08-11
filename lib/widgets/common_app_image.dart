import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students/widgets/common_app_shimmer.dart';

/// Common app image which handles network, assets and local file paths
class CommonAppImage extends StatelessWidget {
  final String imagePath;
  final BorderRadius radius;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;

  const CommonAppImage({
    Key? key,
    required this.imagePath,
    this.height,
    this.width,
    this.radius = BorderRadius.zero,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: radius),
      child: imagePath.startsWith('http')
          ? imagePath.endsWith('svg')
              ? SvgPicture.network(
                  imagePath,
                  height: height,
                  width: width,
                  fit: fit,
                )
              : CachedNetworkImage(
                  placeholder: (context, string) => CommonAppShimmer.rectangular(height: height ?? double.infinity, width: width ?? double.infinity),
                  imageUrl: imagePath,
                  height: height,
                  width: width,
                  fit: fit,
                  color: color,
                )
          : imagePath.contains('assets')
              ? imagePath.endsWith('svg')
                  ? SvgPicture.asset(
                      imagePath,
                      height: height,
                      width: width,
                      fit: fit,
                      // ignore: deprecated_member_use
                      color: color,
                    )
                  : Image.asset(
                      imagePath,
                      height: height,
                      width: width,
                      fit: fit,
                      color: color,
                    )
              : imagePath.endsWith('svg')
                  ? SvgPicture.file(
                      File(imagePath),
                      height: height,
                      width: width,
                      fit: fit,
                    )
                  : Image.file(
                      File(imagePath),
                      height: height,
                      width: width,
                      fit: fit,
                      color: color,
                    ),
    );
  }
}
