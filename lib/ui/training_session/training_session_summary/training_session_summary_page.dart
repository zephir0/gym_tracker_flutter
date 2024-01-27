import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_summary/widgets/congratulatory_message.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_summary/widgets/exercise_progress_list.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_summary/widgets/total_duration.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_summary/widgets/total_weight.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_summary/widgets/workout_number.dart';

class TrainingSessionSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center children
              children: <Widget>[
                WorkoutNumberWidget(),
                TotalWeightWidget(),
                TotalDurationWidget(),
                // ProgressChartWidget(),
                ExerciseProgressListWidget(),
                Align(
                  alignment: Alignment.topCenter,
                  child: CongratulatoryMessageWidget(),
                ), // Center the CongratulatoryMessageWidget
                // Add other widgets as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
