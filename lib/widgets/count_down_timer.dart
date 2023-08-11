import 'package:flutter/material.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';

class CountDownTimer extends AnimatedWidget {
  final Function callback;
  final Animation<int> animation;

  const CountDownTimer({
    Key? key,
    required this.animation,
    required this.callback,
  }) : super(key: key, listenable: animation);

  @override
  Text build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText = '0${clockTimer.inMinutes.remainder(60)}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    callback(timerText, animation.value);
    return Text(
      timerText,
      style: AppTextStyle.nunitoTextStyle14Regular().copyWith(
        color: AppColors.color4d1877,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
