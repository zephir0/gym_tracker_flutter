import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationEnabled = true;
  int _selectedFontSizeIndex = 1;

  List<double> _fontSizes = [16.0, 18.0, 20.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Color.fromRGBO(34, 43, 53, 1), // Dark Grey Color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            SwitchListTile(
              title: Text('Enable Dark Mode'),
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            SwitchListTile(
              title: Text('Enable Location Services'),
              value: _locationEnabled,
              onChanged: (value) {
                setState(() {
                  _locationEnabled = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Font Size:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: _fontSizes
                  .asMap()
                  .map(
                    (index, fontSize) => MapEntry(
                      index,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFontSizeIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: _selectedFontSizeIndex == index
                                ? Colors.green // Dark Green Color
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            fontSize.toString(),
                            style: TextStyle(
                              fontSize: fontSize,
                              color: _selectedFontSizeIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Perform sign out
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(46, 139, 87, 1), // Dark Green Color
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
