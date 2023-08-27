import 'package:flutter/material.dart';
import '../../../api/models/training_log.dart';

class ProgressLogsListWidget extends StatelessWidget {
  final List<TrainingLog> progressLogs;

  ProgressLogsListWidget({required this.progressLogs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: progressLogs.length,
        itemBuilder: (context, index) {
          TrainingLog log = progressLogs[index];
          return ListTile(
            title: Text('Exercise: ${log.name ?? ''}'),
            subtitle: Text('Weight: ${log.weight}, Reps: ${log.reps}'),
          );
        },
      ),
    );
  }
}
