// ignore_for_file: public_member_api_docs, sort_constructors_first
class TrainingLog {
  var id;
  String? name;
  var reps;
  var weight;
  String personalNotes;

  TrainingLog({
    required this.id,
    required this.name,
    required this.reps,
    required this.weight,
    required this.personalNotes,
  });
  factory TrainingLog.fromJson(Map<String, dynamic> json) {
    return TrainingLog(
      id: json['id'],
      name: json['name'],
      reps: json['reps'],
      weight: json['weight'],
      personalNotes: json['personalNotes'],
    );
  }
}
