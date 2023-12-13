import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(43, 138, 132, 1),
        title: Text('About'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Version'),
              subtitle: Text('1.0.0'),
            ),
            ListTile(
              title: Text('Terms of Service'),
            ),
          ],
        ),
      ),
    );
  }
}
