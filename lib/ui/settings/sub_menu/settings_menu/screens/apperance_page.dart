import 'package:flutter/material.dart';

class AppearancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = false;
    bool isLargeText = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: Text('Dark Theme', style: TextStyle(color: Colors.black)),
              subtitle: Text('Enable dark mode',
                  style: TextStyle(color: Colors.black54)),
              value: isDarkTheme,
              onChanged: (bool value) {},
              secondary: Icon(Icons.brightness_6,
                  color: Color.fromRGBO(43, 138, 132, 1)),
            ),
            SwitchListTile(
              title: Text('Large Text', style: TextStyle(color: Colors.black)),
              subtitle: Text('Enable larger text for better readability',
                  style: TextStyle(color: Colors.black54)),
              value: isLargeText,
              onChanged: (bool value) {},
              secondary: Icon(Icons.text_fields,
                  color: Color.fromRGBO(43, 138, 132, 1)),
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
