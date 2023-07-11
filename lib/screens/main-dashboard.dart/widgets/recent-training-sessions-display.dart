import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/training-session-bloc.dart';
import 'package:provider/provider.dart';

import '../../../api/models/training-session.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../training-session/training-session-details/training-session-logs-page.dart';

class RecentTrainingSessionsDisplay extends StatefulWidget {
  final CurvedAnimation deleteAnimationCurve;

  const RecentTrainingSessionsDisplay({required this.deleteAnimationCurve});
  @override
  _RecentTrainingSessionsDisplayState createState() =>
      _RecentTrainingSessionsDisplayState();
}

class _RecentTrainingSessionsDisplayState
    extends State<RecentTrainingSessionsDisplay> {
  late TrainingSessionBloc _trainingSessionBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _trainingSessionBloc = Provider.of<TrainingSessionBloc>(context);
    _trainingSessionBloc.fetchRecentTrainingSessions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<TrainingSession>>(
        stream: _trainingSessionBloc.recentTrainingSessions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<TrainingSession> trainingSessions =
                snapshot.data!.reversed.toList();
            return SingleChildScrollView(
              child: Column(
                children: trainingSessions.map((trainingSession) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      _trainingSessionBloc
                          .deleteTrainingSession(trainingSession.id);
                      trainingSessions.remove(trainingSession);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              SizedBox(width: 8.0),
                            ],
                          ),
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(widget.deleteAnimationCurve),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: TrainingSessionLogsPage(
                                routineName: trainingSession.routineName,
                                trainingSessionId: trainingSessions[
                                        trainingSessions
                                            .indexOf(trainingSession)]
                                    .id
                                    .toString()),
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
                              _buildTrainingRoutineName(trainingSessions,
                                  trainingSessions.indexOf(trainingSession)),
                              _buildTrainingRoutineDate(trainingSessions,
                                  trainingSessions.indexOf(trainingSession)),
                              _buildTotalWeightLifted(trainingSessions,
                                  trainingSessions.indexOf(trainingSession))
                            ]),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
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
