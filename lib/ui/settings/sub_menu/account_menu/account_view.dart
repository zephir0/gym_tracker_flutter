import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/notifications_view.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/payments_view.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/profile_view.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/security_view.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/settings_tile.dart';
import 'package:gym_tracker_flutter/utills/page_route_animator.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          SettingsTile(
            'Profile',
            Icons.person,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(ProfileView())),
          ),
          SettingsTile(
            'Security',
            Icons.security,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(SecurityView())),
          ),
          SettingsTile(
            'Payments',
            Icons.payment,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(PaymentsView())),
          ),
          SettingsTile(
            'Notifications',
            Icons.notifications,
            () => Navigator.of(context)
                .push(PageRouteAnimator.createRoute(NotificationsView())),
          ),
        ],
        color: Colors.white.withOpacity(0.3),
      ).toList(),
    );
  }
}
