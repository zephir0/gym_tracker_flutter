import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class AboutPage extends StatelessWidget {
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
    return GlobalVariables.fontStyle.copyWith(color: Colors.white);
  }
}
