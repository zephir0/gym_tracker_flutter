import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/home-screen.dart/home-screen.dart';
import 'package:gym_tracker_flutter/navi-bar/navigation_bottom-bar.dart';
import 'package:gym_tracker_flutter/setting-screen/setting-screen.dart';
import 'package:gym_tracker_flutter/user-profile-screen/user-profile-screen.dart';

import 'auth_screen/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymDiary',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingScreen(),
        '/navi-bar': (context) => NavigationBottomBar(),
        '/user-profile': (context) => UserProfileScreen(),
      },
      initialRoute: "/login",
    );
  }
}
