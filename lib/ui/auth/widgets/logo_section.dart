import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          "GYM TRACKER",
          style: GlobalVariables.fontStyle.copyWith(
            color: Colors.white,
            fontSize: 45,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
