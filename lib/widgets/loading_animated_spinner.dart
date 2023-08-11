import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimatedSpinner extends StatelessWidget {
  final Color color;
  final double size;

  const LoadingAnimatedSpinner({
    this.color = Colors.lightBlueAccent,
    this.size = 50,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(color: color, size: size),
    );
  }
}
