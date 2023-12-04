abstract class TrainingRoutineEvent {}

class FetchTrainingRoutines extends TrainingRoutineEvent {}

class CreateTrainingRoutine extends TrainingRoutineEvent {
  final Map<String, dynamic> routineData;

  CreateTrainingRoutine(this.routineData);
}

class ArchiveTrainingRoutine extends TrainingRoutineEvent {
  final int routineId;

  ArchiveTrainingRoutine(this.routineId);
}
