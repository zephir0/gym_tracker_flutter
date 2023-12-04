import 'package:gym_tracker_flutter/data/models/training_log.dart';

abstract class TrainingLogState {}

class TrainingLogInitial extends TrainingLogState {}

class TrainingLogsLoaded extends TrainingLogState {
  final List<TrainingLog> logs;

  TrainingLogsLoaded(this.logs);
}

class TrainingLogError extends TrainingLogState {}
