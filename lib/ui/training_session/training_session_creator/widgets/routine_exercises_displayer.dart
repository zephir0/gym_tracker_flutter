import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_state.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_event.dart';
import 'package:gym_tracker_flutter/data/models/exercise.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/exercise_controllers.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/widgets/exercise_card_builder.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/widgets/finish_workout_button.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/widgets/timer_displayer.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_summary/training_session_summary_page.dart';
import 'package:gym_tracker_flutter/utills/time_provider.dart';
import 'package:page_transition/page_transition.dart';

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
    return BlocBuilder<TrainingLogBloc, TrainingLogState>(
      builder: (context, state) {
        if (state is TrainingLogInitial) {
          return CircularProgressIndicator();
        } else if (state is TrainingLogsLoaded) {
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
                              exercise.id, 'weight', state.logs),
                          hintReps: extractLastEntryForExercise(
                              exercise.id, 'reps', state.logs),
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
                          onFinishWorkout: () => onSubmit(state.logs),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is TrainingLogError) {
          return CircularProgressIndicator();
        } else
          return Text("Unknown state");
      },
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

  void onSubmit(List<TrainingLog> previousTrainingLogs) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      context.read<TimerProvider>().stopTimer();

      Map<String, dynamic> jsonData = controllers!.prepareJsonData(
        routine: widget.routine,
      );

      context
          .read<TrainingSessionBloc>()
          .add(CreateTrainingSession(jsonEncode(jsonData)));
    }
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: TrainingSessionSummaryPage(),
        duration: Duration(milliseconds: 300),
      ),
    );
  }
}
