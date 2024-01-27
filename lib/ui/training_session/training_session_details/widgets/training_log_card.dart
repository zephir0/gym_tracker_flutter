import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

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
      color: ColorPalette.settingAppBarColor,
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
      backgroundColor: ColorPalette.secondaryColor,
      child: Text(
        logCounter.toString(),
        style: TextStyle(
          color: ColorPalette.textColor,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLogTitle() {
    return Text(
      currentLog.name!,
      style: TextStyle(
        color: ColorPalette.secondaryColor,
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
          color: ColorPalette.subtitleRowColor,
          size: 14.0,
        ),
        SizedBox(width: 4.0),
        Text(
          text,
          style: TextStyle(
            color: ColorPalette.subtitleRowColor,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: ColorPalette.subtitleRowColor,
      thickness: 1,
      indent: 21,
      endIndent: 21,
    );
  }

  bool _shouldShowDivider() {
    return nextLog == null || currentLog.name != nextLog!.name;
  }
}
