import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_event.dart';
import 'package:gym_tracker_flutter/data/models/exercise.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_creator/training_session_creator_page.dart';

class TrainingRoutineDetailDialog {
  static void showRoutineDetailDialog(
      BuildContext context, TrainingRoutine routine) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
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
                        _archiveConfirmation(context, routine.id);
                      },
                      child: Text('Archive Routine'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> _archiveConfirmation(
      BuildContext dialogContext, int routineId) {
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
                dialogContext
                    .read<TrainingRoutineBloc>()
                    .add(ArchiveTrainingRoutine(routineId));
                Navigator.of(alertDialogContext).pop();
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
