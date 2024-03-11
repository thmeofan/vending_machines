import 'package:flutter/material.dart';

import '../app_colors.dart';

class ConstructorTextStyle {
  static const TextStyle title = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle subtitle = const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: AppColors.greyColor);

  static const TextStyle inputText = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      color: Colors.white);
  static const TextStyle appBar = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppColors.greenColor);

  static const TextStyle lable = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static TextStyle snackBar = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.greenColor,
  );
}
