import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/events_image_assets.dart';
import 'package:students/view/event/event_list/event_controller.dart';
import 'package:students/view/event/event_list/widget/certificate_download_dialog.dart';
import 'package:students/view/event/event_list/widget/view_event_certificate.dart';

import 'package:students/widgets/common_app_image.dart';

class CertificateViewDownlod extends StatefulWidget {
  final String title;
  final bool canDownload;
  final VoidCallback onTap;
  const CertificateViewDownlod({
    super.key,
    required this.canDownload,
    required this.title,
    required this.onTap,
  });

  @override
  State<CertificateViewDownlod> createState() => _CertificateViewDownlodState();
}

class _CertificateViewDownlodState extends State<CertificateViewDownlod> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool visibleDownloadAnimation = false;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  final EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.isCertificateVisible.value = true;
        if (widget.canDownload) {
          setState(() {
            visibleDownloadAnimation = true;
          });
        } else {
          Get.to(() => ViewEventCertificate());
        }
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.title,
                style: AppTextStyle.outFitTextStyle14Light(
                  color: AppColors.colorWhite,
                ),
              ),
              widget.canDownload
                  ? Padding(
                      padding: EdgeInsets.only(left: 5.r),
                      child: visibleDownloadAnimation == false
                          ? CommonAppImage(
                              imagePath: EventImageAssets.download,
                              color: AppColors.colorWhite,
                            )
                          : Container(
                              height: 30.h,
                              margin: EdgeInsets.symmetric(
                                vertical: 7.r,
                              ),
                              width: 30.w,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: AppColors.colorWhite,
                                shape: BoxShape.circle,
                              ),
                              child: Lottie.asset(
                                EventImageAssets.downloadLottieAnimation,
                                controller: _controller,
                                onLoaded: (composition) {
                                  _controller
                                    ..duration = composition.duration
                                    ..forward().whenComplete(
                                      () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CertificateDownloadDialog();
                                          },
                                        );
                                        setState(() {
                                          visibleDownloadAnimation = false;
                                        });
                                      },
                                    );
                                },
                              ),
                            ),
                    )
                  : SizedBox()
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: AppColors.color1E3A8A,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
