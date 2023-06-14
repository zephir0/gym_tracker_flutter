import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/global_variables.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/progress-tracker.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/recent-workouts-header.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/recent-training-sessions-display.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/user-training-routines.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/user-welcome-panel.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/workout-count.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
