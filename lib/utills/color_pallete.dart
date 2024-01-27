import 'package:flutter/material.dart';

class ColorPalette {
  static var primaryThemeGradient = LinearGradient(
    colors: [
      Color(0xFF2E3B4E),
      Color(0xFF394A5A),
      Color(0xFF3E4D63),
      Color(0xFF394A5A),
      Color(0xFF2E3B4E),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static var primaryColor = Color(0xFF2E3B4E);
  static var secondaryColor = Color(0xFFE57373);
  static var primaryButtonColor = Color(0xFF81C784);
  static var authenticationButtonColor = Color(0xFF546E7A);
  static var authenticationButtonTextColor = Colors.white;
  static var textColor = Colors.white;
  static var dashboardLoadingBarColor = Color(0xFFFFC107);
  static var workoutCounterText = Color(0xFFFF9800);
  static var dashboardUsernameTextColor = Color(0xFF9C27B0);
  static var errorTextColor = Color(0xFFD32F2F);
  static var warningTextColor = Color(0xFFFF5722);
  static var naviBarSelectedColor = Color(0xFF546E7A);
  static var naviBarUnselectedColor = Color(0xFF394A5A);
  static var textFormFieldColor = Color(0xFF546E7A);
  static var textFormFieldTextColor = Colors.white;
  static var textFormFieldHintColor = Color(0xFF78909C);
  static var logoTextColor = Color(0xFF81C784);
  static var settingAppBarColor = Color(0xFFE57373);
  static var accountDeleteSliderInnerColor = Color(0xFFD32F2F);
  static var accountDeleteSliderOuterColor = Color(0xFF512DA8);
  static var timerDisplayerBoxColor = Colors.green;
  static var subtitleRowColor = Colors.white70;
  static var createRoutineButtonColor = Color(0xFFE57373);
  static var backToHomeButtonColor = Color(0xFF546E7A);
}
