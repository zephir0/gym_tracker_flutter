import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/training-routine-service.dart';
import 'package:gym_tracker_flutter/screens/training-routine/training-routine-creator/training-routine-creator-page.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/back-to-home-button.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/create-routine-button.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/training-routine-card.dart';
import 'package:gym_tracker_flutter/screens/training-routine/widgets/training-routine-detail-dialog.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/api/models/training-routine.dart';

class TrainingRoutinePage extends StatefulWidget {
  @override
  _TrainingRoutinePageState createState() => _TrainingRoutinePageState();
}

class _TrainingRoutinePageState extends State<TrainingRoutinePage> {
  late StreamController<List<TrainingRoutine>> _streamController;
  late Stream<List<TrainingRoutine>> _stream;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    loadRoutines();
  }

  void loadRoutines() async {
    var routines = await TrainingRoutineService().getTrainingRoutines();
    _streamController.add(routines);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoutineGridDisplayContainer(),
        CreateRoutineButton(context: context),
        BackToHomeButton(context: context),
      ],
    );
  }

  Widget RoutineGridDisplayContainer() {
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables().primaryGradient,
      ),
      child: StreamBuilder<List<TrainingRoutine>>(
        stream: _stream,
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
                          context, reversedList[index], loadRoutines);
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
