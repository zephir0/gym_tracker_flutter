import 'package:flutter/material.dart';

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
        '/home': (context) => LoginScreen(),
      },
      home: LoginScreen(),
    );
  }
}
