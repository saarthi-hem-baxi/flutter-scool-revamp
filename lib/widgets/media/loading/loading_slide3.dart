import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class LoadingSlide3 extends StatefulWidget {
  const LoadingSlide3({Key? key}) : super(key: key);

  @override
  State<LoadingSlide3> createState() => _LoadingSlide3State();
}

class _LoadingSlide3State extends State<LoadingSlide3> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  Animation? image1Animation;
  Animation? image2Animation;
  Animation? image3Animation;
  Animation? image4Animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    image1Animation = Tween(begin: -0.011, end: -0.2).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    image2Animation = Tween(begin: -0.3, end: -0.4).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    image3Animation = Tween(begin: -0.1, end: -0.15).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    image4Animation = Tween(begin: 0.25, end: 0.2).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(milliseconds: 100), () {
      _animationController?.forward();
    });

    _animationController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1500),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment(0.1, image1Animation?.value),
                child: CommonAppImage(
                  imagePath: AppImageAssets.slider3Image1,
                  height: 100,
                ),
              ),
            ),
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment(-0.3, image2Animation?.value),
                child: CommonAppImage(
                  imagePath: AppImageAssets.slider3Image2,
                  width: 15,
                ),
              ),
            ),
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment(0.5, image3Animation?.value),
                child: CommonAppImage(
                  imagePath: AppImageAssets.slider3Image3,
                ),
              ),
            ),
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment(-0.3, image4Animation?.value),
                child: CommonAppImage(
                  imagePath: AppImageAssets.slider3Image4,
                  width: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
