import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/global_variables.dart';
import 'package:gym_tracker_flutter/model/training_log.dart';
import 'package:gym_tracker_flutter/training-session-details-screen/widgets/back-button.dart';
import 'package:gym_tracker_flutter/training-session-details-screen/widgets/training-log-list.dart';
import 'dart:math';

import '../api/json_service.dart';
import '../model/training-session.dart';

class TrainingSessionDetails extends StatefulWidget {
  final List<TrainingSession> trainingSessions;
  final int index;
  final String routineName;

  const TrainingSessionDetails({
    required this.trainingSessions,
    required this.index,
    required this.routineName,
  });

  @override
  _TrainingSessionDetailsState createState() => _TrainingSessionDetailsState();
}

class _TrainingSessionDetailsState extends State<TrainingSessionDetails> {
  Future<List<TrainingLog>> _fetchTrainingLogs() async {
    final trainingSessionId =
        widget.trainingSessions[widget.index].id.toString();
    return JsonService().getAllLogsForTrainingSession(trainingSessionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Container(
          decoration:
              BoxDecoration(gradient: GlobalVariables().primaryGradient),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(80, 207, 199, 0.612),
                      borderRadius: BorderRadius.circular(32)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(
                      widget.routineName,
                      style: TextStyle(
                        color: Color.fromARGB(255, 70, 69, 69),
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<TrainingLog>>(
                  future: _fetchTrainingLogs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final trainingLogs = snapshot.data!;
                      return TrainingLogList(trainingLogs: trainingLogs);
                    }
                  },
                ),
              ),
              SizedBox(height: 14.0),
              BackToHomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
