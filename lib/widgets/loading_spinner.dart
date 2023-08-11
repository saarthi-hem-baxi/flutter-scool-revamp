import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:students/constants/app_colors.dart';

class LoadingSpinner extends StatelessWidget {
  final Color color;
  const LoadingSpinner({
    this.color = AppColors.colorEB4799,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        color: color,
      );
    } else {
      return CircularProgressIndicator(
        color: color,
      );
    }
  }
}
