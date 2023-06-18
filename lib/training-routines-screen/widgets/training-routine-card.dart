import 'package:flutter/material.dart';
import '../../model/training-routine.dart';

class TrainingRoutineCard extends StatelessWidget {
  final TrainingRoutine trainingRoutine;
  final VoidCallback onTap;

  TrainingRoutineCard({required this.trainingRoutine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(43, 138, 132, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Icon(
                Icons.fitness_center,
                size: 48,
                color: Color.fromARGB(255, 71, 67, 67),
              ),
            ),
            Text(trainingRoutine.routineName,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                '${trainingRoutine.exerciseList.length} exercises',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
