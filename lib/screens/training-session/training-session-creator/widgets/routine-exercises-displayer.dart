import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/training-session-service.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/timer-display-widget.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/workout-summary.dart';

import 'package:provider/provider.dart';

import '../../../../api/models/exercise.dart';
import '../../../../api/models/training-routine.dart';
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

  void initState() {
    super.initState();
    controllers = ExerciseControllers(
        exercisesLength: widget.routine.exerciseList.length,
        notifyParent: updateUI);
  }

  void updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    controllers?.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Provider.of<TimerProvider>(context, listen: false).stopTimer();

      WorkoutSummary.showSummary(context);

      Map<String, dynamic> jsonData = controllers!.prepareJsonData(
        routine: widget.routine,
      );

      String json = jsonEncode(jsonData);
      TrainingSessionService().startTrainingSession(json, context);

      setState(() {
        isWorkoutFinished = true;
      });
    }
  }

  void onButtonPress() {
    if (!isWorkoutFinished) {
      onSubmit();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Stack(children: [
          Container(
            height: 555,
            child: ListView(
              children:
                  widget.routine.exerciseList.asMap().entries.map((entry) {
                int index = entry.key;
                Exercise exercise = entry.value;
                return ExerciseCardBuilder(
                  exercise: exercise,
                  index: index,
                  controllers: controllers!,
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
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
          ),
        ]),
      ),
    );
  }
}
