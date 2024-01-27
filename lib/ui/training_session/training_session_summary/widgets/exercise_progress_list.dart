import 'package:flutter/material.dart';

class ExerciseProgressListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> exercises = [
      'Squats',
      'Deadlifts',
      'Bench Press'
    ]; // Replace with your data

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: exercises
            .map((exercise) => ListTile(
                  title: Text(exercise),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                ))
            .toList(),
      ),
    );
  }
}
