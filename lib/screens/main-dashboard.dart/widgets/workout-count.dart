import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/models/training-session.dart';
import 'package:gym_tracker_flutter/api/training-session-bloc.dart';
import 'package:provider/provider.dart';

class WorkoutCount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkoutCountState();
}

class _WorkoutCountState extends State<WorkoutCount> {
  late TrainingSessionBloc _trainingSessionBloc;

  @override
  void initState() {
    super.initState();
    _trainingSessionBloc =
        Provider.of<TrainingSessionBloc>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(43, 138, 132, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
        child: Column(
          children: [
            _buildColumnHeader(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildWorkoutCountText(),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildColumnHeader() {
    return Column(
      children: [
        Text(
          "Workout",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Count",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCountText() {
    return StreamBuilder<String>(
      stream: _trainingSessionBloc.workoutCounter,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.toString(),
            style: TextStyle(
              color: Color.fromRGBO(43, 238, 225, 1),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return Text(
            'No data',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      },
    );
  }
}
