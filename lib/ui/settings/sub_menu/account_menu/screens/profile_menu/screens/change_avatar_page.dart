import 'package:flutter/material.dart';

class ChangeAvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Avatar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('URL_Tutaj'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Change Avatar'),
            ),
          ],
        ),
      ),
    );
  }
}
