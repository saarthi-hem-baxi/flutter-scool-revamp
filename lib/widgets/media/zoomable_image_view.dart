import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/media/media_utils.dart';

class ZoomableImageView extends StatelessWidget {
  const ZoomableImageView(
      {Key? key,
      required this.imageUrl,
      this.fit = BoxFit.cover,
      this.strokeWidth = 4,
      this.size = 30,
      this.offset = 0,
      this.title = '',
      this.imageFile})
      : super(key: key);

  final String imageUrl;
  final BoxFit fit;
  final double size;
  final double offset;
  final double strokeWidth;
  final String title;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: title == '' ? Colors.white : Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: title == '' ? Colors.transparent : Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            )),
      ),
      body: imageFile != null
          ? (imageFile?.path ?? '').contains('.svg')
              ? SvgPicture.file(imageFile!)
              : PhotoView(
                  backgroundDecoration: const BoxDecoration(color: AppColors.gray100),
                  imageProvider: FileImage(imageFile!),
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return imageUrl.contains('.svg')
                        ? SvgPicture.network(
                            imageUrl,
                            fit: BoxFit.contain,
                          )
                        : CommonAppImage(imagePath: AppImageAssets.brokenImage);
                  },
                )
          : isNetworkUrl(imageUrl)
              ? PhotoView(
                  backgroundDecoration: const BoxDecoration(color: AppColors.gray100),
                  loadingBuilder: (context, event) => Center(
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: CircularProgressIndicator(
                        color: AppColors.colorEB4899,
                        strokeWidth: strokeWidth,
                        value: event?.expectedTotalBytes != null ? (event?.cumulativeBytesLoaded)! / (event?.expectedTotalBytes)! : null,
                      ),
                    ),
                  ),
                  imageProvider: CachedNetworkImageProvider(
                    imageUrl,
                  ),
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return imageUrl.contains('.svg')
                        ? Center(
                            child: InteractiveViewer(
                              minScale: 0.1,
                              maxScale: 4.0,
                              boundaryMargin: const EdgeInsets.all(double.infinity),
                              constrained: true,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height - 70.h,
                                child: Center(
                                  child: SvgPicture.network(
                                    imageUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : CommonAppImage(imagePath: AppImageAssets.brokenImage);
                  },
                )
              : PhotoView(
                  backgroundDecoration: const BoxDecoration(color: AppColors.gray100),
                  imageProvider: FileImage(File(imageUrl)),
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return imageUrl.contains('.svg')
                        ? Center(
                            child: InteractiveViewer(
                              minScale: 0.1,
                              maxScale: 4.0,
                              boundaryMargin: const EdgeInsets.all(double.infinity),
                              constrained: true,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height - 70.h,
                                child: Center(
                                  child: SvgPicture.asset(
                                    imageUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : CommonAppImage(imagePath: AppImageAssets.brokenImage);
                  },
                ),
    );
  }
}
