import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class LoginSliderSlide4 extends StatefulWidget {
  const LoginSliderSlide4({
    Key? key,
    required this.page,
    required this.notifier,
    this.imgUrl,
  }) : super(key: key);

  final int page;
  final ValueNotifier<double> notifier;
  final String? imgUrl;

  @override
  State<LoginSliderSlide4> createState() => _LoginSliderSlide4State();
}

class _LoginSliderSlide4State extends State<LoginSliderSlide4> {
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
                      widthFactor: 0.519,
                      heightFactor: 0.519,
                      child: CommonAppImage(
                        imagePath: AuthImageAssets.slider4BGs1,
                        height: 150,
                      ),
                    ),
                  )
                : const SizedBox(),
            Align(
              alignment: const Alignment(0.34, -0.95),
              child: FractionallySizedBox(
                widthFactor: 0.75,
                heightFactor: 0.75,
                child: FadeIn(
                  child: SlidingContainer(
                    offset: 50,
                    child: CommonAppImage(
                      imagePath: widget.imgUrl ?? AuthImageAssets.slider4CoverImage,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.65, 0.2),
              child: FractionallySizedBox(
                child: SlidingContainer(
                  offset: 150,
                  child: CommonAppImage(
                    imagePath: AuthImageAssets.slider4Decorator1,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.8, -0.5),
              child: Transform(
                transform: Matrix4.identity()..rotateZ(150 * 85.0),
                child: FractionallySizedBox(
                  child: SlidingContainer(
                    offset: -150,
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.slider4Decorator2,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.5, -0.7),
              child: Transform(
                transform: Matrix4.identity()..rotateZ(150 * 85.0),
                child: FractionallySizedBox(
                  child: SlidingContainer(
                    offset: -150,
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.slider4Decorator3,
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
