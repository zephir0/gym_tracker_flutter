import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';
import 'package:provider/provider.dart';

import '../../../../utills/time_provider.dart';

class TimerDisplayWidget extends StatefulWidget {
  @override
  _TimerDisplayWidgetState createState() => _TimerDisplayWidgetState();
}

class _TimerDisplayWidgetState extends State<TimerDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            color: ColorPalette.timerDisplayerBoxColor,
            borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<TimerProvider>(
            builder: (context, timer, child) {
              Duration duration = Duration(seconds: timer.start);
              String twoDigits(int n) => n.toString().padLeft(2, "0");
              String twoDigitMinutes =
                  twoDigits(duration.inMinutes.remainder(60));
              String twoDigitSeconds =
                  twoDigits(duration.inSeconds.remainder(60));
              return Text(
                "TIMER: ${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds",
                style: TextStyle(
                    fontSize: 14,
                    color: ColorPalette.textColor,
                    decoration: TextDecoration.none),
              );
            },
          ),
        ),
      ),
    );
  }
}
