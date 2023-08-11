import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/communication_image_assets.dart';
import 'package:students/models/communication/communication_feed_model.dart';
import 'package:students/widgets/media/media_utils.dart';
import 'package:students/widgets/media/media_widget.dart';

class CommunicationFeedList extends StatelessWidget {
  const CommunicationFeedList({
    Key? key,
    required this.isScrollable,
  }) : super(key: key);
  final bool isScrollable;

  Future<List<Data>?> fetchCommunicationData() async {
    final String response =
        await rootBundle.loadString('assets/communication_feed.json');
    final data = await json.decode(response);
    CommunicationFeedModel communicationFeedModel =
        CommunicationFeedModel.fromJson(data);
    return communicationFeedModel.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>?>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            shrinkWrap: true,
            physics: isScrollable
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Data communicationData = (snapshot.data?[index] ?? Data());

              return StickyHeader(
                header: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    margin: EdgeInsets.only(top: 15.h),
                    decoration: BoxDecoration(
                      color: AppColors.blueGray100,
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray900.withOpacity(0.06),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: AppColors.gray900.withOpacity(0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      communicationData.date.toString(),
                      style: AppTextStyle.readexTextStyle10SemiBold(
                        color: AppColors.gray500,
                      ).copyWith(
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ),
                content: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Messages messages =
                        (communicationData.messages?[index] ?? Messages());
                    return MessageDetail(messages: messages);
                  },
                  itemCount: (communicationData.messages?.length ?? 0),
                ),
                overlapHeaders: false,
              );
            },
            itemCount: (snapshot.data?.length ?? 0),
          );
        } else {
          return SizedBox(
            height: 100.h,
            child: const Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: fetchCommunicationData(),
    );
  }
}

class MessageDetail extends StatelessWidget {
  const MessageDetail({Key? key, required this.messages}) : super(key: key);
  final Messages messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
        bottom: 8.h,
        left: 16.w,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          bottomLeft: Radius.circular(4.r),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: Color(0xff1018280F),
          ),
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: Color(0xff1018281A),
          )
        ],
        color: AppColors.colorWhite,
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              messages.userName.toString(),
              style: AppTextStyle.readexTextStyle12Regular(
                color: Colors.cyan.shade700,
              ).copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            Wrap(
              children: (messages.media ?? []).map(
                (media) {
                  return Container(
                    margin: EdgeInsets.only(right: 7.w, bottom: 7.h),
                    child: AppMediaWidget(
                      mediaUrl: media.medialUrl.toString(),
                      mediaType:
                          getMediaTypeFromUrl(media.medialUrl.toString()),
                      size: Size(100.w, 100.w),
                      borderRadius: BorderRadius.circular(16),
                      thumbnailBoxFit: BoxFit.cover,
                    ),
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              messages.message.toString(),
              style: AppTextStyle.readexTextStyle12Regular(
                color: AppColors.blueGray700,
              ).copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                messages.time.toString(),
                style: AppTextStyle.readexTextStyle12Regular(
                  color: AppColors.blueGray400,
                ).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
