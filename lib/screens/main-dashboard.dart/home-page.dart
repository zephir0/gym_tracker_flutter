import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/progress-tracker.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/recent-training-sessions-display.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/recent-workouts-header.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/user-training-routines.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/user-welcome-panel.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/workout-count.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
      child: Column(
        children: [
          UserWelcomePanel(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WorkoutCount(),
              UserTrainingRoutines(),
            ],
          ),
          ProgressTracker(),
          RecentWorkoutsHeader(),
          RecentTrainingSessionsDisplay(),
        ],
      ),
    );
  }
}
