import 'package:flutter/material.dart';
import 'package:vending_machines/consts/app_colors.dart';

import '../../../consts/app_text_styles/settings_text_style.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<bool> _isSelected = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.greenColor,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: AppColors.lightGreyColor,
        title: Text(
          'Back',
          style: SettingsTextStyle.back,
        ),
      ),
      body: Container(
        color: AppColors.purpleColor,
        child: Column(
          children: [
            Text(''),
            Text(''),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPeriodOption("Daily", "Subtitle for Daily", 0),
                _buildPeriodOption("Weekly", "Subtitle for Weekly", 1),
                _buildPeriodOption("Monthly", "Subtitle for Monthly", 2),
                _buildPeriodOption("Annually", "Subtitle for Annually", 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodOption(String title, String subtitle, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          for (int i = 0; i < _isSelected.length; i++) {
            _isSelected[i] = (i == index);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isSelected[index] ? Colors.blue : Colors.white,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: _isSelected[index] ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              subtitle,
              style: TextStyle(
                color: _isSelected[index] ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 4.0),
            Checkbox(
              value: _isSelected[index],
              onChanged: (bool? value) {
                setState(() {
                  _isSelected[index] = value ?? false;
                });
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
