import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/models/training_log.dart';
import 'package:gym_tracker_flutter/api/training-log-bloc.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/timer-display-widget.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/workout-summary.dart';

import 'package:provider/provider.dart';

import '../../../../api/models/exercise.dart';
import '../../../../api/models/training-routine.dart';
import '../../../../api/training-session-bloc.dart';
import '../../../../utills/time-provider.dart';
import '../exercise-controllers.dart';
import 'exercise-card-builder.dart';
import 'finish-workout-button.dart';

class RoutineExercisesDisplayer extends StatefulWidget {
  final TrainingRoutine routine;

  const RoutineExercisesDisplayer({required this.routine});
  @override
  _RoutineExercisesDisplayerState createState() =>
      _RoutineExercisesDisplayerState();
}

class _RoutineExercisesDisplayerState extends State<RoutineExercisesDisplayer> {
  ExerciseControllers? controllers;
  var _formKey = GlobalKey<FormState>();
  bool isWorkoutFinished = false;
  late TrainingLogBloc _trainingLogBloc;
  Map<int, TrainingLog> previousTrainingLogs = {};

  void initState() {
    super.initState();
    controllers = ExerciseControllers(
        exercisesLength: widget.routine.exerciseList.length,
        notifyParent: updateUI);
    _trainingLogBloc = Provider.of<TrainingLogBloc>(context, listen: false);
    _fetchPreviousTrainingLogs();
  }

  void _fetchPreviousTrainingLogs() async {
    try {
      Map<int, TrainingLog> logs =
          await _trainingLogBloc.fetchPreviousTrainingLogs();
      setState(() {
        previousTrainingLogs = logs;
      });
    } catch (e) {
      print('Error fetching previous training logs: $e');
    }
  }

  void updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    controllers?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(children: [
          Expanded(
            child: ListView(
              children:
                  widget.routine.exerciseList.asMap().entries.map((entry) {
                int index = entry.key;
                Exercise exercise = entry.value;
                return ExerciseCardBuilder(
                  hintWeights:
                      extractLastEntryForExercise(exercise.id, 'weight'),
                  hintReps: extractLastEntryForExercise(exercise.id, 'reps'),
                  exercise: exercise,
                  index: index,
                  controllers: controllers!,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Container(
              child: Column(
                children: [
                  TimerDisplayWidget(),
                  FinishWorkoutButton(
                    onFinishWorkout: (() => onButtonPress()),
                    isWorkoutFinished: isWorkoutFinished,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  String extractLastEntryForExercise(int exerciseId, String type) {
    if (previousTrainingLogs.containsKey(exerciseId)) {
      if (type == 'weight') {
        int weight = previousTrainingLogs[exerciseId]?.weight ?? 0;
        return weight.toString();
      } else if (type == 'reps') {
        int reps = previousTrainingLogs[exerciseId]?.reps ?? 0;
        return reps.toString();
      }
    }
    return '0';
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Provider.of<TimerProvider>(context, listen: false).stopTimer();

      WorkoutSummary.showSummary(context);

      Map<String, dynamic> jsonData = controllers!.prepareJsonData(
        routine: widget.routine,
      );

      String jsonEncoded = jsonEncode(jsonData);

      var bloc = TrainingSessionBloc();
      bloc.createTrainingSession(jsonEncoded, context);
      setState(() {
        isWorkoutFinished = true;
      });
    }
  }

  void onButtonPress() {
    if (!isWorkoutFinished) {
      onSubmit();
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/navi-bar', (Route<dynamic> route) => false);
    }
  }
}
