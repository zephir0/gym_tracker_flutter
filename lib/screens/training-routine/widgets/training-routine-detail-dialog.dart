import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/api/models/exercise.dart';
import 'package:gym_tracker_flutter/api/models/training-routine.dart';
import 'package:gym_tracker_flutter/api/training-routine-cubit.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/training-session-creator-page.dart';

class TrainingRoutineDetailDialog {
  static void showRoutineDetailDialog(BuildContext context,
      TrainingRoutine routine, VoidCallback onRoutineUpdated) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<TrainingRoutineCubit>(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 1,
              backgroundColor: Color.fromARGB(255, 63, 63, 63),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: routine.exerciseList.length,
                        itemBuilder: (context, index) {
                          Exercise exercise = routine.exerciseList[index];
                          return ListTile(
                            leading: Icon(Icons.fitness_center),
                            title: Text(
                              exercise.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              exercise.MuscleGroup,
                              style: TextStyle(
                                color: Color.fromARGB(255, 138, 136, 136),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(43, 138, 132, 1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.blue,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: () {},
                                child: Text('Edit Routine'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TrainingSessionCreatorPage(
                                      routine: routine,
                                    ),
                                  ),
                                );
                              },
                              child: Text('Start Routine'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          _archiveConfirmation(
                              context, routine.id, onRoutineUpdated);
                        },
                        child: Text('Archive Routine'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> _archiveConfirmation(BuildContext dialogContext,
      int routineId, VoidCallback onRoutineUpdated) {
    return showDialog(
      context: dialogContext,
      builder: (alertDialogContext) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(80, 207, 199, 1),
          title: Text('Archive Routine'),
          content: Text('Are you sure you want to archive this routine?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(alertDialogContext).pop(),
              child: Text('No',
                  style: TextStyle(color: Color.fromARGB(255, 8, 8, 8))),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<TrainingRoutineCubit>(dialogContext)
                    .archiveTrainingRoutine(routineId);
                Navigator.of(alertDialogContext).pop();
                onRoutineUpdated();
                Navigator.of(dialogContext).pop();
              },
              child: Text('Yes',
                  style: TextStyle(color: Color.fromARGB(255, 8, 8, 8))),
            ),
          ],
        );
      },
    );
  }
}
