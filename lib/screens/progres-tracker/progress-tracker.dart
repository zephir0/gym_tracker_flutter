import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/screens/progres-tracker/widgets/action-buttons-row.dart';
import 'package:gym_tracker_flutter/screens/progres-tracker/widgets/progress-chart.dart';
import 'package:gym_tracker_flutter/screens/progres-tracker/widgets/progress-log-list.dart';
import 'package:provider/provider.dart';
import '../../api/models/training_log.dart';
import '../../api/training-log-bloc.dart';

class ProgressTrackerScreen extends StatefulWidget {
  @override
  _ProgressTrackerScreenState createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  bool _isChartVisible = false;
  late List<TrainingLog> progressLogs;
  late TrainingLogBloc _progressLogBloc;

  @override
  void initState() {
    super.initState();
    progressLogs = [];
    _progressLogBloc = Provider.of<TrainingLogBloc>(context, listen: false);
    _progressLogBloc.fetchTrainingLogs(161);
  }

  @override
  void dispose() {
    _progressLogBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress Tracker')),
      body: Center(
        child: Column(
          children: [
            if (_isChartVisible) _buildProgressChart(),
            _buildProgressLogStreamBuilder(),
            SizedBox(height: 20),
            _buildChartToggle(),
            _buildActionButtonsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressLogStreamBuilder() {
    return StreamBuilder<List<TrainingLog>>(
      stream: _progressLogBloc.trainingLogs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No progress logs available.');
        } else {
          progressLogs = snapshot.data!;
          return ProgressLogsListWidget(progressLogs: progressLogs);
        }
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

  Widget _buildProgressChart() {
    return ProgressChartWidget(progressLogs: progressLogs);
  }

  Widget _buildActionButtonsRow() {
    return ActionButtonsRowWidget(
      onOpenMiniMenu: () {
        progressLogs.forEach((element) {
          print(element.name);
        });
      },
      onOpenFilters: () {
        progressLogs.forEach((element) {
          print(element.name);
        });
      },
    );
  }
}
