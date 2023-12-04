class TrainingSession {
  var id;
  String routineName;
  var trainingDate;
  var totalWeight;
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
