import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:students/constants/app_colors.dart';

class StatusBarColorManager extends StatelessWidget {
  final Widget child;
  final Color color;
  final Brightness? statusBarIconBrightness;

  const StatusBarColorManager({
    Key? key,
    required this.child,
    this.color = AppColors.primary,
    this.statusBarIconBrightness,
  }) : super(key: key);

  Brightness getBrightnessFromStatusBarColor(Color color) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    if (brightness == Brightness.dark) {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    // create the status bar overlay style
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: statusBarIconBrightness ?? getBrightnessFromStatusBarColor(color),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: child,
    );
  }
}
