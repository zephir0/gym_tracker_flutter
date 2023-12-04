import 'package:gym_tracker_flutter/data/models/training_routine.dart';

abstract class TrainingRoutineState {}

class TrainingRoutineInitial extends TrainingRoutineState {}

class TrainingRoutinesLoaded extends TrainingRoutineState {
  final List<TrainingRoutine> routines;

  TrainingRoutinesLoaded(this.routines);
}

class TrainingRoutineError extends TrainingRoutineState {}

class TrainingRoutineCreationSuccess extends TrainingRoutineState {}

class TrainingRoutineCreationFailure extends TrainingRoutineState {}
