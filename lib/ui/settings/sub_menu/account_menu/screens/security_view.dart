import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class SecurityView extends StatelessWidget {
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
          children: [
            ListTile(
              leading: Icon(
                Icons.lock_outline,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Change Password',
                style: _getTextStyle(),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.phonelink_lock,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Two-Factor Authentication',
                style: _getTextStyle(),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.fingerprint,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Fingerprint Lock',
                style: _getTextStyle(),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Login History',
                style: _getTextStyle(),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.security,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Security Questions',
                style: _getTextStyle(),
              ),
              onTap: () {},
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
