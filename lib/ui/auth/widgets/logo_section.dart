import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          "GYM TRACKER",
          style: TextStyle(
            color: ColorPalette.logoTextColor,
            fontSize: 45,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
