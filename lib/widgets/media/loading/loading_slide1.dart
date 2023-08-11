import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/widgets/common_app_image.dart';

class LoadingSlide1 extends StatefulWidget {
  const LoadingSlide1({Key? key}) : super(key: key);

  @override
  State<LoadingSlide1> createState() => _LoadingSlide1State();
}

class _LoadingSlide1State extends State<LoadingSlide1> with SingleTickerProviderStateMixin {
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

    image1Animation = Tween(begin: -0.10, end: -0.40).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    image2Animation = Tween(begin: -0.1, end: -0.2).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    image3Animation = Tween(begin: 0.28, end: 0.1).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    image4Animation = Tween(begin: -0.3, end: -0.4).animate(CurvedAnimation(
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
    return Center(
      child: FadeInUp(
        duration: const Duration(milliseconds: 1500),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment(0.01, image1Animation?.value),
                child: CommonAppImage(imagePath: AppImageAssets.slider1Image1),
              ),
            ),
            FadeIn(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment(-0.5, image2Animation?.value),
                child: CommonAppImage(
                  imagePath: AppImageAssets.slider1Image2,
                ),
              ),
            ),
            FadeIn(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment(0.4, image3Animation?.value),
                child: FractionallySizedBox(
                  child: CommonAppImage(imagePath: AppImageAssets.slider1Image3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
