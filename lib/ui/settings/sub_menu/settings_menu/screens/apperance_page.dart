import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';

class AppearancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = false;
    bool isLargeText = false;

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
              title: Text('Dark Theme', style: TextStyle(color: Colors.white)),
              subtitle: Text('Enable dark mode',
                  style: TextStyle(color: Colors.white54)),
              value: isDarkTheme,
              onChanged: (bool value) {},
              secondary: Icon(Icons.brightness_6, color: Colors.white),
            ),
            SwitchListTile(
              title: Text('Large Text', style: TextStyle(color: Colors.white)),
              subtitle: Text('Enable larger text for better readability',
                  style: TextStyle(color: Colors.white54)),
              value: isLargeText,
              onChanged: (bool value) {},
              secondary: Icon(Icons.text_fields, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(43, 138, 132, 1),
                  onPrimary: Colors.white,
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
