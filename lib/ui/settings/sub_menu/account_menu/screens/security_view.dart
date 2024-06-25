import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class SecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 25, 25, 0.612),
        title: Text(
          'Edit Profile',
          style: GlobalVariables.fontStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.lock_outline,
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
    return GlobalVariables.fontStyle.copyWith(color: Colors.white);
  }
}
