import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/models/training-routine.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/back-to-home-button.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/create-routine-button.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/training-routine-card.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/training-routine-detail-dialog.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';

import '../../api/training-routine-bloc.dart';

class TrainingRoutinePage extends StatefulWidget {
  @override
  _TrainingRoutinePageState createState() => _TrainingRoutinePageState();
}

class _TrainingRoutinePageState extends State<TrainingRoutinePage> {
  final _bloc = TrainingRoutineBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getTrainingRoutines();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _bloc.getTrainingRoutines(),
      child: Stack(
        children: [
          _routineGridDisplayContainer(),
          CreateRoutineButton(context: context),
          BackToHomeButton(context: context),
        ],
      ),
    );
  }

  Widget _routineGridDisplayContainer() {
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables().primaryGradient,
      ),
      child: StreamBuilder<List<TrainingRoutine>>(
        stream: _bloc.routines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final trainingRoutines = snapshot.data!;
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
                  return TrainingRoutineCard(
                    trainingRoutine: reversedList[index],
                    onTap: () {
                      TrainingRoutineDetailDialog.showRoutineDetailDialog(
                          context,
                          reversedList[index],
                          _bloc.getTrainingRoutines);
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
