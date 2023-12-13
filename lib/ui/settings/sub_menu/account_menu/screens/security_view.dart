import 'package:flutter/material.dart';

class SecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Change Password'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.phonelink_lock),
            title: Text('Two-Factor Authentication'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.fingerprint),
            title: Text('Fingerprint Lock'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Login History'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Security Questions'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
