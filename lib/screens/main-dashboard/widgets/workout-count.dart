import 'package:flutter/material.dart';
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
    _initializeTrainingSessionBloc();
  }

  void _initializeTrainingSessionBloc() {
    _trainingSessionBloc =
        Provider.of<TrainingSessionBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
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

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(43, 138, 132, 1),
      borderRadius: BorderRadius.circular(30),
    );
  }

  Column _buildColumnHeader() {
    return Column(
      children: [
        _buildHeaderText("Workout"),
        _buildHeaderText("Count"),
      ],
    );
  }

  Text _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildWorkoutCountText() {
    return StreamBuilder<String>(
      stream: _trainingSessionBloc.workoutCounter,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return _buildCountText(snapshot.data.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return _buildErrorText('No data');
        }
      },
    );
  }

  Text _buildCountText(String count) {
    return Text(
      count,
      style: TextStyle(
        color: Color.fromRGBO(43, 238, 225, 1),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _buildErrorText(String error) {
    return Text(
      error,
      style: TextStyle(
        color: Colors.red,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
