import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({
    super.key,
    required this.gallerylist,
  });

  final List<String> gallerylist;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      margin: EdgeInsets.only(
        top: 20.r,
        bottom: 160.r,
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 11.w,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: gallerylist.length,
        itemBuilder: (context, index) {
          return Image.network(
            gallerylist.elementAt(index),
            height: 124.h,
            width: 124.w,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
