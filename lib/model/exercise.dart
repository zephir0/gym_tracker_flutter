class Exercise {
  final id;
  final name;
  final MuscleGroup;
  final adminCreated;

  Exercise(
      {required this.id,
      required this.name,
      required this.MuscleGroup,
      required this.adminCreated});
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      MuscleGroup: json['MuscleGroup'],
      adminCreated: json['adminCreated'],
    );
  }
}

enum MuscleGroup { Chest, Back, Legs, Shoulders, Arms, Abs }
