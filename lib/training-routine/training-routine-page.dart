import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/training-routine-service.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/model/training-routine.dart';
import 'package:gym_tracker_flutter/training-routine/training-routine-creator/training-routine-creator-page.dart';
import 'package:gym_tracker_flutter/training-routine/widgets/training-routine-detail-dialog.dart';
import 'package:gym_tracker_flutter/training-routine/widgets/training-routine-card.dart';

class TrainingRoutinePage extends StatelessWidget {
  final Future<List<TrainingRoutine>> trainingRoutinesFuture =
      TrainingRoutineService().getTrainingRoutines();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: GlobalVariables().primaryGradient,
          ),
          child: FutureBuilder<List<TrainingRoutine>>(
            future: trainingRoutinesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final trainingRoutines = snapshot.data!;
                return Padding(
                  padding: EdgeInsets.only(bottom: 160), //
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
                              context, reversedList[index]);
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
        Positioned(
          bottom: 80,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Color.fromRGBO(21, 119, 184, 0.612),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        TrainingRoutineCreatorPage(),
                    opaque: false,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(0.0, 1.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text(
                    'Create Routine',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.fitness_center),
                ],
              ),
            ),
          ),
        ),

        // Back to Home Button
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Color.fromRGBO(80, 207, 199, 0.612),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 8),
                  Text(
                    'Back to Home',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
