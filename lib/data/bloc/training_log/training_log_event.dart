abstract class TrainingLogEvent {}

class FetchTrainingLogs extends TrainingLogEvent {
  final int sessionId;

  FetchTrainingLogs(this.sessionId);
}

class FetchPreviousTrainingLogs extends TrainingLogEvent {
  final int routineId;

  FetchPreviousTrainingLogs(this.routineId);
}
