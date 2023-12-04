import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine_cubit.dart';
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
        child: BlocProvider<TrainingRoutineCubit>(
          create: (_) => TrainingRoutineCubit()..getTrainingRoutines(),
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
    return BlocBuilder<TrainingRoutineCubit, List<TrainingRoutine>>(
      builder: (context, trainingRoutines) {
        if (trainingRoutines.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
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
            itemCount: trainingRoutines.length,
            itemBuilder: (context, index) {
              var reversedList = trainingRoutines.reversed.toList();
              var routine = reversedList[index];
              return TrainingRoutineCard(
                trainingRoutine: routine,
                onTap: () {
                  TrainingRoutineDetailDialog.showRoutineDetailDialog(
                    context,
                    routine,
                    () => context
                        .read<TrainingRoutineCubit>()
                        .getTrainingRoutines(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
