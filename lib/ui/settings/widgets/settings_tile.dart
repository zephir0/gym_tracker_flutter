import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onFunction;
  const SettingsTile(this.title, this.icon, this.onFunction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFunction,
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
        ),
        child: ListTile(
          title:
              Text(title, style: GlobalVariables.fontStyle.copyWith(fontSize: 17, color: Colors.white)),
          leading: Icon(
            icon,
            color: Colors.white,
            size: 33,
          ),
          trailing: Icon(Icons.chevron_right, color: Colors.white),
        ),
      ),
    );
  }
}
