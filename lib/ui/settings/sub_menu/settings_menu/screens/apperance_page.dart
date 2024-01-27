import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class AppearancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = false;
    bool isLargeText = false;

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
              title: Text('Dark Theme',
                  style: TextStyle(color: ColorPalette.textColor)),
              subtitle: Text('Enable dark mode',
                  style: TextStyle(color: ColorPalette.textFormFieldHintColor)),
              value: isDarkTheme,
              onChanged: (bool value) {},
              secondary:
                  Icon(Icons.brightness_6, color: ColorPalette.secondaryColor),
            ),
            SwitchListTile(
              title: Text('Large Text',
                  style: TextStyle(color: ColorPalette.textColor)),
              subtitle: Text('Enable larger text for better readability',
                  style: TextStyle(color: ColorPalette.textFormFieldHintColor)),
              value: isLargeText,
              onChanged: (bool value) {},
              secondary:
                  Icon(Icons.text_fields, color: ColorPalette.secondaryColor),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorPalette.secondaryColor,
                  onPrimary: ColorPalette.textColor,
                ),
                onPressed: () {},
                child: Text('Apply Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
