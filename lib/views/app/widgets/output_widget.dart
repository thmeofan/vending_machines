import 'package:flutter/material.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';

class OutputWidget extends StatelessWidget {
  final String text;
  const OutputWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Text(
        text,
        style: ConstructorTextStyle.inputText,
      ),
    );
  }
}
