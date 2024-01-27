import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class PrivacyPage extends StatelessWidget {
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
            SwitchListTile(
              title: Text('Location Tracking',
                  style: TextStyle(color: ColorPalette.textColor)),
              subtitle: Text('Allow apps to access your location',
                  style: TextStyle(color: ColorPalette.textFormFieldHintColor)),
              value: true,
              onChanged: (bool value) {},
              secondary: Icon(Icons.location_on, color: ColorPalette.textColor),
            ),
            SwitchListTile(
              title: Text('Usage Data',
                  style: TextStyle(color: ColorPalette.textColor)),
              subtitle: Text('Share usage data for analytics',
                  style: TextStyle(color: ColorPalette.textColor)),
              value: false,
              onChanged: (bool value) {},
              secondary: Icon(Icons.analytics, color: ColorPalette.textColor),
            ),
            ListTile(
              title: Text('Review Personal Data',
                  style: TextStyle(color: ColorPalette.textColor)),
              subtitle: Text('Review and manage your data',
                  style: TextStyle(color: ColorPalette.textFormFieldHintColor)),
              onTap: () {},
              trailing:
                  Icon(Icons.arrow_forward_ios, color: ColorPalette.textColor),
            ),
            ListTile(
              title: Text('Data Export',
                  style: TextStyle(color: ColorPalette.textColor)),
              subtitle: Text('Export your personal data',
                  style: TextStyle(color: ColorPalette.textFormFieldHintColor)),
              onTap: () {},
              trailing:
                  Icon(Icons.cloud_download, color: ColorPalette.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
