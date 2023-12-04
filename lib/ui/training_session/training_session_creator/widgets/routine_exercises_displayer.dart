import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/models/exercise.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log_cubit.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session_cubit.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/exercise_controllers.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/widgets/exercise_card_builder.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/widgets/finish_workout_button.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/widgets/timer_displayer.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/widgets/workout_summary.dart';
import 'package:gym_tracker_flutter/utills/time_provider.dart';

class RoutineExercisesDisplayer extends StatefulWidget {
  final TrainingRoutine routine;

  const RoutineExercisesDisplayer({required this.routine, Key? key})
      : super(key: key);

  @override
  _RoutineExercisesDisplayerState createState() =>
      _RoutineExercisesDisplayerState();
}

class _RoutineExercisesDisplayerState extends State<RoutineExercisesDisplayer> {
  ExerciseControllers? controllers;
  var _formKey = GlobalKey<FormState>();
  bool isWorkoutFinished = false;
  bool isDialogShown = false;

  @override
  void initState() {
    super.initState();
    controllers = ExerciseControllers(
      exercisesLength: widget.routine.exerciseList.length,
      notifyParent: updateUI,
    );
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
    return BlocProvider<TrainingLogCubit>(
      create: (_) =>
          TrainingLogCubit()..fetchPreviousTrainingLogs(widget.routine.id),
      child: BlocBuilder<TrainingLogCubit, List<TrainingLog>>(
        builder: (context, previousTrainingLogs) {
          return Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.routine.exerciseList.length,
                      itemBuilder: (context, index) {
                        Exercise exercise = widget.routine.exerciseList[index];
                        return ExerciseCardBuilder(
                          hintWeights: extractLastEntryForExercise(
                              exercise.id, 'weight', previousTrainingLogs),
                          hintReps: extractLastEntryForExercise(
                              exercise.id, 'reps', previousTrainingLogs),
                          exercise: exercise,
                          index: index,
                          controllers: controllers!,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Column(
                      children: [
                        TimerDisplayWidget(),
                        FinishWorkoutButton(
                          onFinishWorkout: () =>
                              onButtonPress(previousTrainingLogs),
                          isWorkoutFinished: isWorkoutFinished,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String extractLastEntryForExercise(
      int exerciseId, String type, List<TrainingLog> previousLogs) {
    TrainingLog? log;
    try {
      log = previousLogs.firstWhere((log) => log.id == exerciseId);
    } catch (e) {
      log = null;
    }

    if (log != null) {
      return type == 'weight' ? log.weight.toString() : log.reps.toString();
    }
    return '0';
  }

  void onButtonPress(List<TrainingLog> previousTrainingLogs) {
    if (!isWorkoutFinished) {
      onSubmit(previousTrainingLogs);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/navi-bar', (Route<dynamic> route) => false);
    }
  }

  void onSubmit(List<TrainingLog> previousTrainingLogs) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      context.read<TimerProvider>().stopTimer();

      WorkoutSummary(trainingRoutine: widget.routine).showSummary(context);

      Map<String, dynamic> jsonData = controllers!.prepareJsonData(
        routine: widget.routine,
      );

      String jsonEncoded = jsonEncode(jsonData);

      BlocProvider.of<TrainingSessionCubit>(context)
          .createTrainingSession(jsonEncoded);

      setState(() {
        isWorkoutFinished = true;
      });
    }
  }
}
