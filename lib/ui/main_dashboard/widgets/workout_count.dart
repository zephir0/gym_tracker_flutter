import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_state.dart';

class WorkoutCount extends StatelessWidget {
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
              child: _buildWorkoutCountText(context),
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
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(29, 72, 69, 1), 
          offset: Offset(4, 4), 
          blurRadius: 10, 
          spreadRadius: 2, 
        ),
      ],
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
      style: GlobalVariables.fontStyle.copyWith(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildWorkoutCountText(BuildContext context) {
    return BlocBuilder<TrainingSessionBloc, TrainingSessionState>(
      builder: (context, state) {
        if (state is TrainingSessionInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TrainingSessionLoaded) {
          return _buildCountText(state.sessions.length.toString());
        } else if (state is TrainingSessionError) {
          return Text(
            "Error loading sessions",
            style: TextStyle(color: Colors.red),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Text _buildCountText(String count) {
    return Text(
      count,
      style: GlobalVariables.fontStyle.copyWith(
        color: Color.fromRGBO(43, 238, 225, 1),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
