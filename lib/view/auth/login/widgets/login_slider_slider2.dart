import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class LoginSliderSlide2 extends StatefulWidget {
  const LoginSliderSlide2({
    Key? key,
    required this.page,
    required this.notifier,
    this.imgUrl,
  }) : super(key: key);

  final int page;
  final ValueNotifier<double> notifier;
  final String? imgUrl;

  @override
  State<LoginSliderSlide2> createState() => _LoginSliderSlide2State();
}

class _LoginSliderSlide2State extends State<LoginSliderSlide2> {
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
          children: [
            widget.imgUrl == null
                ? Align(
                    alignment: const Alignment(0.13, -0.31),
                    child: FractionallySizedBox(
                      widthFactor: 0.551,
                      heightFactor: 0.551,
                      child: CommonAppImage(
                        imagePath: AuthImageAssets.slider2BgS2,
                        height: 150,
                      ),
                    ),
                  )
                : const SizedBox(),
            Align(
              alignment: const Alignment(0.25, -1.1),
              child: FractionallySizedBox(
                widthFactor: 0.78,
                heightFactor: 0.78,
                child: SlidingContainer(
                  offset: 50,
                  child: CommonAppImage(
                    imagePath: widget.imgUrl ?? AuthImageAssets.slider2CoverImage,
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
                      imagePath: AuthImageAssets.slider2Decorator3,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.8, 0.25),
              child: Transform(
                transform: Matrix4.identity()..rotateZ(150 * 40.0),
                child: FractionallySizedBox(
                  child: SlidingContainer(
                    offset: 300,
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.slider2Decorator2,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.65, -0.5),
              child: FractionallySizedBox(
                child: SlidingContainer(
                  offset: -150,
                  child: CommonAppImage(
                    imagePath: AuthImageAssets.slider2Decorator1,
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
