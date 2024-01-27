import 'package:flutter/material.dart';

class WorkoutNumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int workoutNumber = 5; // Replace with your data

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          'Workout #$workoutNumber',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.fitness_center, color: Colors.blue),
        trailing: Text(
          'Completed', // Can be dynamic based on workout status
          style: TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}
