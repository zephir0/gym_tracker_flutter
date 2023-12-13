import 'package:flutter/material.dart';

class EditUsernamePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Username'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'New Username'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Update Username'),
            ),
          ],
        ),
      ),
    );
  }
}
