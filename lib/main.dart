import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/home_page.dart';
import 'package:gym_tracker_flutter/ui/navi_bar/navigation_bottom_bar.dart';
import 'package:gym_tracker_flutter/ui/settings/settings_page.dart';
import 'package:gym_tracker_flutter/ui/user_profile/user_profile_screen.dart';
import 'package:gym_tracker_flutter/utills/time_provider.dart';
import 'package:provider/provider.dart';

import 'ui/auth/auth_screen.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: MaterialApp(
        title: 'GymDiary',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomePage(),
          '/settings': (context) => SettingsPage(),
          '/navi-bar': (context) => NavigationBottomBar(),
          '/user-profile': (context) => UserProfileScreen(),
        },
        initialRoute: "/login",
      ),
    );
  }
}
