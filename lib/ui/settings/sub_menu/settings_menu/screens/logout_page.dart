import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:gym_tracker_flutter/data/services/auth_service.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<AnimatorWidgetState> shakeKey = GlobalKey<AnimatorWidgetState>();

    void shake() {
      shakeKey.currentState?.forward();
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: ColorPalette.primaryThemeGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://i.ibb.co/Hp1V3H3/a24b22ed-9b94-488e-9f55-2207ae94cd70-5.webp'),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Are you sure you want to log out?',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Shake(
              key: shakeKey,
              preferences: AnimationPreferences(
                offset: Duration.zero,
                autoPlay: AnimationPlayStates.None,
              ),
              child: ElevatedButton(
                onPressed: () {
                  shake();
                  AuthService().attemptLogout(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary:
                      ColorPalette.warningTextColor, // Use the warning color
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                color: ColorPalette.secondaryColor, // Use the warning color
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Go Back',
                    style:
                        TextStyle(color: ColorPalette.textColor, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
