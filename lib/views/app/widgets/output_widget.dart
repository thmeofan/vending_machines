import 'package:flutter/material.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';

class OutputWidget extends StatelessWidget {
  final String text;
  const OutputWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.065,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white.withOpacity(0.15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: ConstructorTextStyle.inputText,
        ),
      ),
    );
  }
}
