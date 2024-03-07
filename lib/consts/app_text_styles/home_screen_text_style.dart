import 'package:flutter/material.dart';

import '../app_colors.dart';

class HomeScreenTextStyle {
  static const TextStyle name = TextStyle(
    fontFamily: 'Inter',
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle address = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.35),
  );
  static const TextStyle appbar = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.greenColor,
  );
  static const TextStyle banner = TextStyle(
      fontFamily: 'Inter',
      fontSize: 32.0,
      fontWeight: FontWeight.w700,
      color: Colors.white);
  static const TextStyle subtitle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  static const TextStyle subtitlePurple = TextStyle(
      fontFamily: 'Inter',
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: AppColors.greenColor);
}
