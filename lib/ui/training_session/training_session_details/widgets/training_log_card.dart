import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';

class TrainingLogCard extends StatelessWidget {
  final TrainingLog currentLog;
  final TrainingLog? nextLog;
  final int logCounter;

  TrainingLogCard({
    required this.currentLog,
    this.nextLog,
    required this.logCounter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLogEntryCard(),
        if (_shouldShowDivider()) _buildDivider(),
      ],
    );
  }

  Widget _buildLogEntryCard() {
    return Card(
      color: Colors.grey[800],
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        leading: _buildLogCounterAvatar(),
        title: _buildLogTitle(),
        subtitle: _buildLogSubtitles(),
      ),
    );
  }

  Widget _buildLogCounterAvatar() {
    return CircleAvatar(
      radius: 22.0,
      backgroundColor: Color.fromRGBO(80, 187, 180, 0.612),
      child: Text(
        logCounter.toString(),
        style: GlobalVariables.fontStyle.copyWith(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLogTitle() {
    return Text(
      currentLog.name!,
      style: GlobalVariables.fontStyle.copyWith(
        color: Color.fromRGBO(80, 187, 180, 0.612),
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLogSubtitles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        _buildLogSubtitleRow(
          Icons.fitness_center,
          'Reps: ${currentLog.reps.toString()}',
          16.0,
        ),
        _buildLogSubtitleRow(
          Icons.fitness_center,
          'Weight: ${currentLog.weight.toString()} kg',
          16.0,
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildLogSubtitleRow(IconData icon, String text, double fontSize) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 14.0,
        ),
        SizedBox(width: 4.0),
        Text(
          text,
          style: GlobalVariables.fontStyle.copyWith(
            color: Colors.white70,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Color.fromARGB(255, 80, 78, 78),
      thickness: 1,
      indent: 21,
      endIndent: 21,
    );
  }

  bool _shouldShowDivider() {
    return nextLog == null || currentLog.name != nextLog!.name;
  }
}
