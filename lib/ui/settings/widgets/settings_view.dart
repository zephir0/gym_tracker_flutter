import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          SettingsTile('Appearance', Icons.palette),
          SettingsTile('Privacy', Icons.lock_outline),
          SettingsTile('Help & Support', Icons.help_outline),
          SettingsTile('About', Icons.info_outline),
          SettingsTile("Logout", Icons.logout)
        ],
        color: Colors.white.withOpacity(0.3),
      ).toList(),
    );
  }
}
