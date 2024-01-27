import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/settings_menu/screens/about_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/settings_menu/screens/apperance_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/settings_menu/screens/help_support_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/settings_menu/screens/logout_page.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/settings_menu/screens/privacy_page.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/settings_tile.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';
import 'package:gym_tracker_flutter/utills/page_route_animator.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          SettingsTile(
            'Appearance',
            Icons.palette,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(AppearancePage())),
          ),
          SettingsTile(
            'Privacy',
            Icons.lock_outline,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(PrivacyPage())),
          ),
          SettingsTile(
            'Help & Support',
            Icons.help_outline,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(HelpSupportPage())),
          ),
          SettingsTile(
            'About',
            Icons.info_outline,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(AboutPage())),
          ),
          SettingsTile(
            "Logout",
            Icons.logout,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(LogoutPage())),
          ),
        ],
        color: ColorPalette.textColor.withOpacity(0.3),
      ).toList(),
    );
  }
}
