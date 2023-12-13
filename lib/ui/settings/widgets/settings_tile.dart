import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingsTile(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 17, color: Colors.white)),
        leading: Icon(
          icon,
          color: Colors.white,
          size: 33,
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.white),
      ),
    );
  }
}
