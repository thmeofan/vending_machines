import 'package:flutter/material.dart';
import '../../../consts/app_text_styles/onboarding_text_style.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/chosen_action_button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  final bool? isFirstTime;

  const OnboardingScreen({
    Key? key,
    this.isFirstTime,
  }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.transparent.withOpacity(1),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                // Wrap the Column with Expanded
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.45,
                    ),
                    const Text(
                      'Welcome to Profitmate - your assistant in increasing the profitability of vending machines!',
                      style: OnboardingTextStyle.introduction,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      'Track, analyze, and optimize your business with our convenient app',
                      style: OnboardingTextStyle.description,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    Spacer(),
                    ChosenActionButton(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.start);
                      },
                      text: 'Next',
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
