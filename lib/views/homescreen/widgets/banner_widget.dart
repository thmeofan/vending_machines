import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MachineBanner extends StatelessWidget {
  const MachineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.25),
      ),
      width: size.width * 0.85,
      height: size.height * 0.17,
      child: SvgPicture.asset(
        'assets/images/count.svg',
        fit: BoxFit.contain,
        width: size.width * 0.25,
        height: size.height * 0.25,
      ),
    );
  }
}
