import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class LoginSliderSlide1 extends StatefulWidget {
  const LoginSliderSlide1({
    Key? key,
    required this.page,
    required this.notifier,
    this.imgUrl,
  }) : super(key: key);
  final int page;
  final ValueNotifier<double> notifier;
  final String? imgUrl;

  @override
  State<LoginSliderSlide1> createState() => _LoginSliderSlide1State();
}

class _LoginSliderSlide1State extends State<LoginSliderSlide1> {
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
                    alignment: const Alignment(0.01, -0.41),
                    child: FractionallySizedBox(
                      widthFactor: 0.57,
                      heightFactor: 0.57,
                      child: CommonAppImage(
                        imagePath: AuthImageAssets.slider1BgS1,
                        height: 150,
                      ),
                    ),
                  )
                : const SizedBox(),
            Align(
              alignment: const Alignment(0.35, -1.12),
              child: FractionallySizedBox(
                widthFactor: 0.78,
                heightFactor: 0.82,
                child: SlidingContainer(
                  offset: 20,
                  child: CommonAppImage(
                    imagePath: widget.imgUrl ?? AuthImageAssets.slider1CoverImage,
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
                    imagePath: AuthImageAssets.slider1Book,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.65, -0.7),
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateX(135)
                  ..rotateZ(40),
                child: FractionallySizedBox(
                  child: SlidingContainer(
                    offset: -150,
                    child: CommonAppImage(
                      imagePath: AuthImageAssets.slider1Decorator1,
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
