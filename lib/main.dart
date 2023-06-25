import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/main-dashboard.dart/home-page.dart';
import 'package:gym_tracker_flutter/navi-bar/navigation_bottom-bar.dart';
import 'package:gym_tracker_flutter/settings/settings-page.dart';
import 'package:gym_tracker_flutter/user-profile-screen/user-profile-screen.dart';
import 'package:gym_tracker_flutter/utills/time-provider.dart';
import 'package:provider/provider.dart';

import 'auth/auth_screen.dart';

void main() {
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
