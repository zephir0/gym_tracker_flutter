import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_avatar_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_email_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_password_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_username_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/delete_account_page.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 25, 25, 0.612),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.red,
              ),
              title: Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
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
    return TextStyle(color: Colors.white);
  }
}
