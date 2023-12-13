import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/settings_tile.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          SettingsTile('Profile', Icons.person),
          SettingsTile('Security', Icons.security),
          SettingsTile('Payments', Icons.payment),
          SettingsTile('Notifications', Icons.notifications),
        ],
        color: Colors.white.withOpacity(0.3),
      ).toList(),
    );
  }
}
