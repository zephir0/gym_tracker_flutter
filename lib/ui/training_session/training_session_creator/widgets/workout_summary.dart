import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/time_provider.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:provider/provider.dart';


class WorkoutSummary {
  final TrainingRoutine trainingRoutine;

  WorkoutSummary({required this.trainingRoutine});
  void showSummary(BuildContext context) {
    int totalWorkoutTime =
        Provider.of<TimerProvider>(context, listen: false).totalWorkoutTime;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: width * 0.9,
                height: height * 0.9,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.only(
                  top: 50,
                ),
                child: build(context),
              ),
              Positioned(
                top: -30,
                child: Icon(
                  Icons.fitness_center,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _buildMetricCard('Workout Number', '303'),
                  ),
                  Expanded(
                    child: _buildMetricCard('Total Weight', '150 kg'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: _buildExerciseList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value) {
    return Card(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 5),
            Text(value,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList() {
    return ListView(
      children: trainingRoutine.exerciseList.map((element) {
        return _buildExerciseItem(element.name, true);
      }).toList(),
    );
  }

  Widget _buildExerciseItem(String exerciseName, bool progress) {
    return ListTile(
      title: Text(exerciseName, style: TextStyle(color: Colors.white)),
      trailing: Icon(
        progress ? Icons.arrow_upward : Icons.arrow_downward,
        color: progress ? Colors.green : Colors.red,
      ),
    );
  }
}
