import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

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
          border: Border(
              bottom:
                  BorderSide(color: ColorPalette.textColor.withOpacity(0.3))),
        ),
        child: ListTile(
          title: Text(title,
              style: TextStyle(fontSize: 17, color: ColorPalette.textColor)),
          leading: Icon(
            icon,
            color: ColorPalette.textColor,
            size: 33,
          ),
          trailing: Icon(Icons.chevron_right, color: ColorPalette.textColor),
        ),
      ),
    );
  }
}
