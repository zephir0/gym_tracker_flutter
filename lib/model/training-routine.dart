import 'exercise.dart';

class TrainingRoutine {
  final id;
  final routineName;
  List<Exercise> exerciseList;

  TrainingRoutine(
      {required this.id,
      required this.routineName,
      required this.exerciseList});

  factory TrainingRoutine.fromJson(Map<String, dynamic> json) {
    var exerciseListFromJson = json['exerciseList'] as List;
    List<Exercise> exerciseList =
        exerciseListFromJson.map((i) => Exercise.fromJson(i)).toList();

    return TrainingRoutine(
        id: json['id'],
        routineName: json['routineName'],
        exerciseList: exerciseList);
  }
}
