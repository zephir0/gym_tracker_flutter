import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class PrivacyPage extends StatelessWidget {
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
              title: Text('Location Tracking',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Allow apps to access your location',
                  style: TextStyle(color: Colors.white60)),
              value: true,
              onChanged: (bool value) {},
              secondary: Icon(Icons.location_on, color: Colors.white),
            ),
            SwitchListTile(
              title: Text('Usage Data', style: TextStyle(color: Colors.white)),
              subtitle: Text('Share usage data for analytics',
                  style: TextStyle(color: Colors.white)),
              value: false,
              onChanged: (bool value) {},
              secondary: Icon(Icons.analytics, color: Colors.white),
            ),
            ListTile(
              title: Text('Review Personal Data',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Review and manage your data',
                  style: TextStyle(color: Colors.white60)),
              onTap: () {},
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
            ListTile(
              title: Text('Data Export', style: TextStyle(color: Colors.white)),
              subtitle: Text('Export your personal data',
                  style: TextStyle(color: Colors.white60)),
              onTap: () {},
              trailing: Icon(Icons.cloud_download, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
