import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_state.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

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
      color: ColorPalette.secondaryColor,
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
        color: ColorPalette.textColor,
        fontSize: 16,
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
          //TODO
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Text _buildCountText(String count) {
    return Text(
      count,
      style: TextStyle(
        color: ColorPalette.workoutCounterText,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
