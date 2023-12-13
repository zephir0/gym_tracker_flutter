import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_avatar_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_email_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_password_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/delete_account_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/edit_username_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/widgets/profile_options_tile.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          ProfileOptionTile(
            icon: Icons.person,
            title: 'Change Avatar',
            onTap: () => _navigateToScreen(context, ChangeAvatarPage()),
          ),
          ProfileOptionTile(
            icon: Icons.edit,
            title: 'Edit Username',
            onTap: () => _navigateToScreen(context, EditUsernamePage()),
          ),
          ProfileOptionTile(
            icon: Icons.email,
            title: 'Change Email',
            onTap: () => _navigateToScreen(context, ChangeEmailPage()),
          ),
          ProfileOptionTile(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () => _navigateToScreen(context, ChangePasswordPage()),
          ),
          ProfileOptionTile(
            icon: Icons.delete_forever,
            title: 'Delete Account',
            onTap: () => _navigateToScreen(context, DeleteAccountPage()),
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
