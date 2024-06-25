import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/authorization/auth_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/authorization/auth_event.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<AnimatorWidgetState> shakeKey = GlobalKey<AnimatorWidgetState>();

    void shake() {
      shakeKey.currentState?.forward();
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
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
                style: GlobalVariables.fontStyle.copyWith(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
                  BlocProvider.of<AuthBloc>(context).add(LogoutAttempt());
                },
                child: Text(
                  'Logout',
                  style: GlobalVariables.fontStyle.copyWith(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromRGBO(138, 43, 64, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                color: Colors.grey,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Go Back',
                    style: GlobalVariables.fontStyle.copyWith(color: Colors.black, fontSize: 20),
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
