import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/training-session-details-screen/training-session-details.dart';

import '../../api/json_service.dart';
import '../../model/training-session.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class RecentTrainingSessionsDisplay extends StatefulWidget {
  @override
  _RecentTrainingSessionsDisplayState createState() =>
      _RecentTrainingSessionsDisplayState();
}

class _RecentTrainingSessionsDisplayState
    extends State<RecentTrainingSessionsDisplay> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrainingSession>>(
      future: JsonService().getRecentTrainingSessions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<TrainingSession> trainingSessions = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              itemCount: trainingSessions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: TrainingSessionDetails(
                              routineName: trainingSessions[index].routineName,
                              trainingSessions: trainingSessions,
                              index: index),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(80, 80, 80, 100),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTrainingRoutineName(trainingSessions, index),
                            _buildTrainingRoutineDate(trainingSessions, index),
                            _buildTotalWeightLifted(trainingSessions, index)
                          ]),
                    ));
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildTrainingRoutineName(
      List<TrainingSession> trainingSessions, int index) {
    return Container(
      child: Text(
        trainingSessions[index].routineName,
        style: TextStyle(
            color: Color.fromRGBO(80, 187, 180, 0.612),
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTrainingRoutineDate(
      List<TrainingSession> trainingSessions, int index) {
    DateTime selectedDate =
        DateFormat("dd-MM-yyyy").parse(trainingSessions[index].trainingDate);
    String dayName = DateFormat('EEEE').format(selectedDate);
    return Container(
      child: Column(
        children: [
          Text(dayName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Text(
            trainingSessions[index].trainingDate,
            style: TextStyle(
                color: Color.fromRGBO(80, 187, 180, 0.612),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalWeightLifted(
      List<TrainingSession> trainingSessions, int index) {
    return Container(
      child: Text(
        trainingSessions[index].totalWeight.toString() + " kg",
        style: TextStyle(
            color: Color.fromRGBO(80, 187, 180, 0.612),
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
