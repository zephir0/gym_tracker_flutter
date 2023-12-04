import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_state.dart';
import 'package:gym_tracker_flutter/data/services/training_routine_service.dart';
import 'package:gym_tracker_flutter/ui/training-routine/widgets/back_to_home_button.dart';
import 'package:gym_tracker_flutter/ui/training-routine/widgets/create_routine_button.dart';
import 'package:gym_tracker_flutter/ui/training-routine/widgets/training_routine_card.dart';
import 'package:gym_tracker_flutter/ui/training-routine/widgets/training_routine_detail_dialog.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';

class TrainingRoutinePage extends StatefulWidget {
  @override
  _TrainingRoutinePageState createState() => _TrainingRoutinePageState();
}

class _TrainingRoutinePageState extends State<TrainingRoutinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
        child: BlocProvider(
          create: (_) => TrainingRoutineBloc(getIt<TrainingRoutineService>())
            ..add(FetchTrainingRoutines()),
          child: Stack(
            children: [
              _routineGridDisplayContainer(),
              CreateRoutineButton(
                context: context,
              ),
              BackToHomeButton(
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _routineGridDisplayContainer() {
    return BlocBuilder<TrainingRoutineBloc, TrainingRoutineState>(
      builder: (context, state) {
        if (state is TrainingRoutineInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TrainingRoutinesLoaded) {
          return Padding(
            padding: EdgeInsets.only(bottom: 160),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              padding: EdgeInsets.all(20),
              itemCount: state.routines.length,
              itemBuilder: (context, index) {
                var reversedList = state.routines.reversed.toList();
                var routine = reversedList[index];
                return TrainingRoutineCard(
                  trainingRoutine: routine,
                  onTap: () {
                    TrainingRoutineDetailDialog.showRoutineDetailDialog(
                        context, routine);
                  },
                );
              },
            ),
          );
        } else if (state is TrainingRoutineError) {
          return Text("Error");
        } else
          return new Text("Unknown state");
      },
    );
  }
}
