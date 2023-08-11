import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class LoadingSlide2 extends StatefulWidget {
  const LoadingSlide2({Key? key}) : super(key: key);

  @override
  State<LoadingSlide2> createState() => _LoadingSlide2State();
}

class _LoadingSlide2State extends State<LoadingSlide2> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  Animation? image2Animation;
  Animation? image3Animation;
  Animation? image4Animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      _animationController?.forward();
    });

    _animationController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInUp(
        duration: const Duration(milliseconds: 1500),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                delay: const Duration(milliseconds: 300),
                child: Align(
                  alignment: const Alignment(0.1, -0.32),
                  child: FractionallySizedBox(
                    widthFactor: 0.45,
                    heightFactor: 0.45,
                    child: CommonAppImage(imagePath: AppImageAssets.slider2Image1),
                  ),
                ),
              ),
              // right side dot
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                delay: const Duration(milliseconds: 100),
                child: Align(
                  alignment: const Alignment(0.6, -0.4),
                  child: Transform(
                    transform: Matrix4.identity()..rotateZ(25),
                    child: CommonAppImage(imagePath: AppImageAssets.slider2Image2),
                  ),
                ),
              ),
              // left side dot
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                delay: const Duration(milliseconds: 500),
                child: Align(
                  alignment: const Alignment(-0.4, 0.3),
                  child: Transform(
                    transform: Matrix4.identity()..rotateZ(25),
                    child: CommonAppImage(imagePath: AppImageAssets.slider2Image3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
