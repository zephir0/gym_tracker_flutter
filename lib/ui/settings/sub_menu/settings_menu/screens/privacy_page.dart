import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(43, 138, 132, 1),
        title: Text('Privacy', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: Text('Location Tracking',
                  style: TextStyle(color: Colors.black)),
              subtitle: Text('Allow apps to access your location',
                  style: TextStyle(color: Colors.black54)),
              value: true,
              onChanged: (bool value) {},
              secondary: Icon(Icons.location_on,
                  color: Color.fromRGBO(43, 138, 132, 1)),
            ),
            SwitchListTile(
              title: Text('Usage Data', style: TextStyle(color: Colors.black)),
              subtitle: Text('Share usage data for analytics',
                  style: TextStyle(color: Colors.black54)),
              value: false,
              onChanged: (bool value) {},
              secondary:
                  Icon(Icons.analytics, color: Color.fromRGBO(43, 138, 132, 1)),
            ),
            ListTile(
              title: Text('Review Personal Data',
                  style: TextStyle(color: Colors.black)),
              subtitle: Text('Review and manage your data',
                  style: TextStyle(color: Colors.black54)),
              onTap: () {},
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            ),
            ListTile(
              title: Text('Data Export', style: TextStyle(color: Colors.black)),
              subtitle: Text('Export your personal data',
                  style: TextStyle(color: Colors.black54)),
              onTap: () {},
              trailing: Icon(Icons.cloud_download, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
