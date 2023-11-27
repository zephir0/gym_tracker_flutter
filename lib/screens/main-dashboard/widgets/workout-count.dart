import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/api/training-session-cubit.dart';

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

  Widget _buildWorkoutCountText(BuildContext context) {
    return BlocBuilder<TrainingSessionCubit, TrainingSessionState>(
      builder: (context, state) {
        return _buildCountText(state.workoutCount.toString());
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
}
