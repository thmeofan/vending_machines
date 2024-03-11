import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../app/views/my_in_app_web_view.dart';
import '../widgets/settings_widget.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        title: const Text(
          'Back',
          style: ConstructorTextStyle.appBar,
        ),
        titleSpacing: -5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/leading.svg'),
        ),
      ),
      body: Container(
        color: AppColors.purpleColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.12,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                text: 'Terms of use',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MyInAppWebView(url: 'https://google.com/'),
                    ),
                  );
                },
                assetName: 'assets/icons/terms_of_use.svg',
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                  text: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyInAppWebView(url: 'https://google.com/'),
                      ),
                    );
                  },
                  assetName: 'assets/icons/privacy_policy.svg'),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                  text: 'Share with friends',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyInAppWebView(url: 'https://google.com/'),
                      ),
                    );
                  },
                  assetName: 'assets/icons/share.svg'),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                  text: 'Send notification',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyInAppWebView(url: 'https://google.com/'),
                      ),
                    );
                  },
                  assetName: 'assets/icons/notification.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
