import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_state.dart';
import 'package:gym_tracker_flutter/data/services/training_log_service.dart';
import 'package:gym_tracker_flutter/ui/progres_tracker/widgets/action_buttons-row.dart';
import 'package:gym_tracker_flutter/ui/progres_tracker/widgets/progress_chart.dart';
import 'package:gym_tracker_flutter/ui/progres_tracker/widgets/progress_log_list.dart';

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
      body: BlocProvider(
        create: (_) => TrainingLogBloc(getIt<TrainingLogService>())
          ..add(FetchTrainingLogs(161)),
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
    return BlocBuilder<TrainingLogBloc, TrainingLogState>(
      builder: (context, state) {
        if (state is TrainingLogInitial) {
          return CircularProgressIndicator();
        } else if (state is TrainingLogsLoaded) {
          return ProgressLogsListWidget(progressLogs: state.logs);
        } else if (state is TrainingLogError) {
          return CircularProgressIndicator();
        } else
          return Text("Unknown state");
      },
    );
  }

  Widget _buildProgressChart() {
    return BlocBuilder<TrainingLogBloc, TrainingLogState>(
      builder: (context, state) {
        if (state is TrainingLogInitial) {
          return CircularProgressIndicator();
        } else if (state is TrainingLogsLoaded) {
          return ProgressChartWidget(progressLogs: state.logs);
        } else if (state is TrainingLogError) {
          return CircularProgressIndicator();
        } else
          return Text("Unknown state");
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
