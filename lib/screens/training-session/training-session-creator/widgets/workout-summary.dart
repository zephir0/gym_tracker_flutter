import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utills/time-provider.dart';

class WorkoutSummary {
  static void showSummary(BuildContext context) {
    int totalWorkoutTime =
        Provider.of<TimerProvider>(context, listen: false).totalWorkoutTime;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Total training time: $totalWorkoutTime seconds'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
