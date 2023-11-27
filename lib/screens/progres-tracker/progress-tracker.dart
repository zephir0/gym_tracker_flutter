import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/api/models/training_log.dart';
import 'package:gym_tracker_flutter/api/training-log-cubit.dart';
import 'package:gym_tracker_flutter/screens/progres-tracker/widgets/action-buttons-row.dart';
import 'package:gym_tracker_flutter/screens/progres-tracker/widgets/progress-chart.dart';
import 'package:gym_tracker_flutter/screens/progres-tracker/widgets/progress-log-list.dart';

class ProgressTrackerScreen extends StatefulWidget {
  @override
  _ProgressTrackerScreenState createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  bool _isChartVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress Tracker')),
      body: BlocProvider<TrainingLogCubit>(
        create: (context) => TrainingLogCubit()..fetchTrainingLogs(161),
        child: Center(
          child: Column(
            children: [
              if (_isChartVisible) _buildProgressChart(),
              _buildProgressLogList(),
              SizedBox(height: 20),
              _buildChartToggle(),
              _buildActionButtonsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressLogList() {
    return BlocBuilder<TrainingLogCubit, List<TrainingLog>>(
      builder: (context, progressLogs) {
        if (progressLogs.isEmpty) {
          return CircularProgressIndicator();
        } else {
          return ProgressLogsListWidget(progressLogs: progressLogs);
        }
      },
    );
  }

  Widget _buildProgressChart() {
    return BlocBuilder<TrainingLogCubit, List<TrainingLog>>(
      builder: (context, progressLogs) {
        return ProgressChartWidget(progressLogs: progressLogs);
      },
    );
  }

  Widget _buildChartToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Show Chart'),
        Switch(
          value: _isChartVisible,
          onChanged: (value) {
            setState(() {
              _isChartVisible = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildActionButtonsRow() {
    return ActionButtonsRowWidget(
      onOpenMiniMenu: () {},
      onOpenFilters: () {},
    );
  }
}
