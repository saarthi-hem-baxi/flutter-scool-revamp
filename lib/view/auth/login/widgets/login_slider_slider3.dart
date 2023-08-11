import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class LoginSliderSlide3 extends StatefulWidget {
  const LoginSliderSlide3({
    Key? key,
    required this.page,
    required this.notifier,
    this.imgUrl,
  }) : super(key: key);

  final int page;
  final ValueNotifier<double> notifier;
  final String? imgUrl;

  @override
  State<LoginSliderSlide3> createState() => _LoginSliderSlide3State();
}

class _LoginSliderSlide3State extends State<LoginSliderSlide3> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      page: widget.page,
      notifier: widget.notifier,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            widget.imgUrl == null
                ? Align(
                    alignment: const Alignment(0.1, -0.32),
                    child: FractionallySizedBox(
                      widthFactor: 0.52,
                      heightFactor: 0.52,
                      child: CommonAppImage(
                        imagePath: AuthImageAssets.slider3BgS1,
                        width: 150,
                      ),
                    ),
                  )
                : const SizedBox(),
            Align(
              alignment: const Alignment(0.195, -1.0),
              child: FractionallySizedBox(
                widthFactor: 0.758,
                heightFactor: 0.758,
                child: FadeIn(
                  child: SlidingContainer(
                    offset: 50,
                    child: CommonAppImage(
                      imagePath: widget.imgUrl ?? AuthImageAssets.slider3CoverImage,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.9, 0.2),
              child: FractionallySizedBox(
                child: SlidingContainer(
                  offset: 150,
                  child: CommonAppImage(
                    imagePath: AuthImageAssets.slider3Magnet,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.6, 0.2),
              child: Transform(
                transform: Matrix4.identity()..rotateZ(150 * 70.0),
                child: FractionallySizedBox(
                  child: SlidingContainer(
                    offset: 300,
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.slider3Decorator1,
                      width: 10.w,
                      height: 10.w,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.9, -0.7),
              child: Transform(
                transform: Matrix4.identity()..rotateZ(150 * 85.0),
                child: FractionallySizedBox(
                  child: SlidingContainer(
                    offset: -150,
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.slider3Decorator2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
