import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_details/widgets/training_log_card.dart';

class TrainingLogList extends StatelessWidget {
  final List<TrainingLog> trainingLogs;

  TrainingLogList({required this.trainingLogs});

  @override
  Widget build(BuildContext context) {
    List<Widget> logWidgets = [];
    String? lastLogName;
    int logCounter = 1;

    for (int subIndex = 0; subIndex < trainingLogs.length; subIndex++) {
      final currentLog = trainingLogs[subIndex];
      final nextLog = subIndex < trainingLogs.length - 1
          ? trainingLogs[subIndex + 1]
          : null;

      if (lastLogName != currentLog.name) {
        lastLogName = currentLog.name;
        logCounter = 1;
      } else {
        logCounter++;
      }

      logWidgets.add(TrainingLogCard(
          currentLog: currentLog, nextLog: nextLog, logCounter: logCounter));

      if (nextLog != null && nextLog.name != currentLog.name) {
        logCounter = 0;
      }
    }

    return ListView(children: logWidgets);
  }
}
