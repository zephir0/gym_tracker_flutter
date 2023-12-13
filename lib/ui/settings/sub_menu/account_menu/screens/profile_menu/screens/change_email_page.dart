import 'package:flutter/material.dart';

class ChangeEmailPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'New Email'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Update Email'),
            ),
          ],
        ),
      ),
    );
  }
}
