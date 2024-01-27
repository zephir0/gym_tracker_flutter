import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.settingAppBarColor,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: ColorPalette.textColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: ColorPalette.primaryThemeGradient),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Version',
                style: _getTextStyle(),
              ),
              subtitle: Text(
                '1.0.0',
                style: _getTextStyle(),
              ),
            ),
            ListTile(
              title: Text(
                'Terms of Service',
                style: _getTextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(color: ColorPalette.textColor);
  }
}
