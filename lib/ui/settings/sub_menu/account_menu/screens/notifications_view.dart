import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Receive Email Notifications'),
            subtitle: Text('Turn on/off email notifications'),
            value: true,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text('Receive Push Notifications'),
            subtitle: Text('Turn on/off push notifications'),
            value: false,
            onChanged: (bool value) {},
          ),
          ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text('Notification Tone'),
            subtitle: Text('Set your notification tone'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.do_not_disturb_on),
            title: Text('Do Not Disturb'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Notification History'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
