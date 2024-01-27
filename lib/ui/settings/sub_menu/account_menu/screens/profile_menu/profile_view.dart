import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_avatar_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_email_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_password_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_username_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/delete_account_page.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class ProfileView extends StatelessWidget {
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
              leading: Icon(
                Icons.person,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Change Avatar',
                style: _getTextStyle(),
              ),
              onTap: () => _navigateToScreen(context, ChangeAvatarPage()),
            ),
            ListTile(
              leading: Icon(
                Icons.edit,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Change Username',
                style: _getTextStyle(),
              ),
              onTap: () => _navigateToScreen(context, ChangeUsernamePage()),
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Change Email',
                style: _getTextStyle(),
              ),
              onTap: () => _navigateToScreen(context, ChangeEmailPage()),
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: ColorPalette.textColor,
              ),
              title: Text(
                'Change Password',
                style: _getTextStyle(),
              ),
              onTap: () => _navigateToScreen(context, ChangePasswordPage()),
            ),
            ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: ColorPalette.warningTextColor,
              ),
              title: Text(
                'Delete Account',
                style: TextStyle(color: ColorPalette.warningTextColor),
              ),
              onTap: () => _navigateToScreen(context, DeleteAccountPage()),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(color: ColorPalette.textColor);
  }
}
