import 'package:flutter/material.dart';
import 'package:students/constants/app_colors.dart';

class AppGradients {
  static const blueDarkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.color3277F1, AppColors.color0F5BE0],
    tileMode: TileMode.mirror,
  );

  static const grayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.colorE8E8E8, AppColors.colorC4C4C4],
    tileMode: TileMode.mirror,
  );

  static const pinkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.colorF075B2, AppColors.colorEB4799],
    tileMode: TileMode.mirror,
  );

  static const gradientBottomBarBG = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.navyBlueDarkExtra, AppColors.navyBlueDarkLight],
    tileMode: TileMode.mirror,
  );

  static const redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.colorF07575, AppColors.colorEB4747],
    tileMode: TileMode.mirror,
  );

  static const orangeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.colorFCC39C, AppColors.colorFBE3D0],
    tileMode: TileMode.mirror,
  );

  static const orangeLighGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.colorFBE3D0, AppColors.colorFBE3D0],
  );
}
