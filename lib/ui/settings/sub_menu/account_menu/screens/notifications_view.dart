import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class NotificationsView extends StatelessWidget {
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
            SwitchListTile(
              title:
                  Text('Receive Email Notifications', style: _getTextStyle()),
              subtitle: Text('Turn on/off email notifications',
                  style: _getTextStyle()),
              value: true,
              onChanged: (bool value) {},
            ),
            SwitchListTile(
              title: Text('Receive Push Notifications', style: _getTextStyle()),
              subtitle: Text('Turn on/off push notifications',
                  style: _getTextStyle()),
              value: false,
              onChanged: (bool value) {},
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
              title: Text('Notification Tone', style: _getTextStyle()),
              subtitle:
                  Text('Set your notification tone', style: _getTextStyle()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.do_not_disturb_on,
                color: Colors.white,
              ),
              title: Text('Do Not Disturb', style: _getTextStyle()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.white,
              ),
              title: Text(
                'Notification History',
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
    return TextStyle(color: Colors.white);
  }
}
