import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TrainingSession {
  var id;
  String routineName;
  var trainingDate;
  int totalWeight;
  TrainingSession({
    required this.id,
    required this.routineName,
    required this.trainingDate,
    required this.totalWeight,
  });

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      id: json['id'],
      routineName: json['routineName'],
      trainingDate: json['trainingDate'],
      totalWeight: json['totalWeight'],
    );
  }
}
