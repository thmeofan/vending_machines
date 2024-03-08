import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../app/views/my_in_app_web_view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: AppColors.lightGreyColor),
                ),
              ),
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/back.svg',
                      width: size.height * 0.03,
                      height: size.height * 0.03,
                    ),
                    label: const Text(
                      'Share with friends ',
                      style: SettingsTextStyle.tile,
                    )),
                trailing: SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  width: size.height * 0.015,
                  height: size.height * 0.015,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: AppColors.lightGreyColor),
                ),
              ),
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/human.svg',
                      width: size.height * 0.03,
                      height: size.height * 0.03,
                    ),
                    label: const Text(
                      'Subscription info',
                      style: SettingsTextStyle.tile,
                    )),
                trailing: SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  width: size.height * 0.015,
                  height: size.height * 0.015,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: AppColors.lightGreyColor),
                ),
              ),
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/shield.svg',
                      width: size.height * 0.03,
                      height: size.height * 0.03,
                    ),
                    label: const Text(
                      'Privacy policy',
                      style: SettingsTextStyle.tile,
                    )),
                trailing: SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  width: size.height * 0.015,
                  height: size.height * 0.015,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: AppColors.lightGreyColor),
                ),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/note.svg',
                      width: size.height * 0.03,
                      height: size.height * 0.03,
                    ),
                    label: const Text(
                      'Terms of use',
                      style: SettingsTextStyle.tile,
                    )),
                trailing: SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  width: size.height * 0.015,
                  height: size.height * 0.015,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
