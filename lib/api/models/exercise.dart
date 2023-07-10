import '../../screens/training-routine/training-routine-creator/training-routine-creator-page.dart';

class Exercise {
  final id;
  final String name;
  final MuscleGroup;
  final adminCreated;
  set name(String name) => name;
  set MuscleGroup(muscleGroup) => muscleGroup;
  Exercise(
      {required this.id,
      required this.name,
      required this.MuscleGroup,
      required this.adminCreated});
  Map<String, dynamic> toJson() => {
        'name': name,
        'muscleGroup': MuscleGroup.split('.').last,
      };
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      MuscleGroup: json['muscleGroup'],
      adminCreated: json['adminCreated'],
    );
  }
}

enum MuscleGroup { CHEST, BACK, LEGS, SHOULDERS, ARMS, ABS }
