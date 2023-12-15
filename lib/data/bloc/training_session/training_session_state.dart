import 'package:gym_tracker_flutter/data/models/training_session.dart';

abstract class TrainingSessionState {}

class TrainingSessionInitial extends TrainingSessionState {}

class TrainingSessionLoaded extends TrainingSessionState {
  final List<TrainingSession> sessions;

  TrainingSessionLoaded(this.sessions);
}

class TrainingSessionError extends TrainingSessionState {}
