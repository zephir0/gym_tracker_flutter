import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/model/exercise.dart';
import 'package:gym_tracker_flutter/model/training-routine.dart';

import '../../training-session/training-session-creator/training-session-creator-page.dart';

class TrainingRoutineDetailDialog {
  static void showRoutineDetailDialog(
      BuildContext context, TrainingRoutine routine) {
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
                                Navigator.of(context).pop();
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TrainingSessionCreatorPage(
                                          routine: routine),
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
                        _deleteConfirmation(context);
                      },
                      child: Text('Delete routine'),
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

  static Future<dynamic> _deleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(80, 207, 199, 1),
          title: Text('Delete Routine'),
          content: Text('Are you sure you want to delete this routine?'),
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
              onPressed: () {
                Navigator.of(context).pop();
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
