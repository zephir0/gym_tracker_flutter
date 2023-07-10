import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/models/exercise.dart';
import 'package:gym_tracker_flutter/api/models/training-routine.dart';

import '../../../api/training-routine-bloc.dart';
import '../../training-session/training-session-creator/training-session-creator-page.dart';

class TrainingRoutineDetailDialog {
  static void showRoutineDetailDialog(BuildContext context,
      TrainingRoutine routine, VoidCallback onRoutineArchived) {
    final bloc = TrainingRoutineBloc();

    showDialog(
      context: context,
      builder: (context) {
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
                            decoration: BoxDecoration(color: Colors.blue),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                // Add code for editing routine
                              },
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TrainingSessionCreatorPage(
                                  routine: routine,
                                );
                              }));
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
                        _deleteConfirmation(
                            context, routine, bloc, onRoutineArchived);
                      },
                      child: Text('Archive routine'),
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

  static Future<dynamic> _deleteConfirmation(
      BuildContext context,
      TrainingRoutine routine,
      TrainingRoutineBloc bloc,
      VoidCallback onRoutineArchived) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(80, 207, 199, 1),
          title: Text('Archive Routine'),
          content: Text('Are you sure you want to Archive this routine?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
              ),
            ),
            TextButton(
              onPressed: () async {
                await bloc.archiveTrainingRoutine(routine.id);
                Navigator.of(context).pop();
                onRoutineArchived();
                Navigator.of(context).pop();
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
              ),
            ),
          ],
        );
      },
    );
  }
}
