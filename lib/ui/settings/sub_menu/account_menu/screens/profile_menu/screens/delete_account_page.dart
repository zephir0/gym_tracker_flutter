import 'package:flutter/material.dart';

class DeleteAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Are you sure you want to delete your account?'),
            ElevatedButton(
              onPressed: () {},
              child: Text('Delete Account'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
