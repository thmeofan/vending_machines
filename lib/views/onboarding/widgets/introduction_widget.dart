import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionWidget extends StatelessWidget {
  final String imagePath;

  const IntroductionWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      child: SvgPicture.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: size.height * 0.4,
      ),
    );
  }
}
