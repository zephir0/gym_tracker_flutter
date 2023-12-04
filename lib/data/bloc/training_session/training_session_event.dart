abstract class TrainingSessionEvent {}

class FetchTrainingSessions extends TrainingSessionEvent {}

class CreateTrainingSession extends TrainingSessionEvent {
  final String jsonData;

  CreateTrainingSession(this.jsonData);
}

class DeleteTrainingSession extends TrainingSessionEvent {
  final int sessionId;

  DeleteTrainingSession(this.sessionId);
}
