import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vending_machines/consts/app_colors.dart';

import '../../../blocs/onboarding_cubit/onboarding_cubit.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/chosen_action_button_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<bool> _isSelected = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.greenColor,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: AppColors.purpleColor,
        title: const Text(
          'Back',
          style: SettingsTextStyle.back,
        ),
      ),
      body: Container(
        color: AppColors.purpleColor,
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              Text('Let’s start'),
              Text('How often do you track the number of products?'),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: _buildPeriodOption(
                                "Daily", "4-7 days per week", 0)),
                        Expanded(
                            child: _buildPeriodOption(
                                "Weekly", "1-3 days per week", 1)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: _buildPeriodOption(
                                "Monthly", "5-7 days per month", 2)),
                        Expanded(
                            child: _buildPeriodOption(
                                "Rarely", "1 day per month", 3)),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              ChosenActionButton(
                onTap: () {
                  context.read<OnboardingCubit>().setFirstTime();
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                text: 'Start',
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodOption(String title, String subtitle, int index) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          setState(() {
            for (int i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = (i == index);
            }
          });
        },
        child: Container(
          height: size.height * 0.1,
          decoration: BoxDecoration(
            color: _isSelected[index]
                ? AppColors.greenColor
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(4.0),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.005,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _isSelected[index] ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: _isSelected[index] ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                ],
              ),
              Spacer(),
              _isSelected[index]
                  ? SvgPicture.asset(
                      'assets/icons/check_circle.svg',
                      width: 24,
                      height: 24,
                    )
                  : SvgPicture.asset(
                      'assets/icons/circle.svg',
                      width: 22,
                      height: 22,
                    ),
              SizedBox(
                width: size.width * 0.005,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
