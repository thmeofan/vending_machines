import 'package:flutter/material.dart';

class OnboardingTextStyle {
  static const TextStyle introduction = TextStyle(
    fontFamily: 'Inter',
    fontSize: 22.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static TextStyle description = const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle button = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 20.0 / 18.0,
  );
}
