import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_state.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_details/widgets/back_button.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_details/widgets/training_log_list.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class TrainingSessionLogsPage extends StatefulWidget {
  final trainingSessionId;
  final String routineName;

  const TrainingSessionLogsPage({
    Key? key,
    required this.routineName,
    required this.trainingSessionId,
  }) : super(key: key);

  @override
  _TrainingSessionLogsPageState createState() =>
      _TrainingSessionLogsPageState();
}

class _TrainingSessionLogsPageState extends State<TrainingSessionLogsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainingLogBloc()
        ..add(FetchTrainingLogs(int.parse(widget.trainingSessionId))),
      child: Scaffold(
        backgroundColor: ColorPalette.settingAppBarColor,
        body: SafeArea(
          child: Container(
            decoration:
                BoxDecoration(gradient: ColorPalette.primaryThemeGradient),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 16.0),
                Expanded(child: _buildTrainingLogList()),
                SizedBox(height: 14.0),
                BackToHomeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.secondaryColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Text(
          widget.routineName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorPalette.textColor,
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTrainingLogList() {
    return BlocBuilder<TrainingLogBloc, TrainingLogState>(
      builder: (context, state) {
        if (state is TrainingLogInitial) {
          return new Center(child: CircularProgressIndicator());
        } else if (state is TrainingLogsLoaded) {
          return TrainingLogList(trainingLogs: state.logs);
        } else if (state is TrainingLogError) {
          return Text("Error");
        } else
          return Text("Unknown state");
      },
    );
  }
}
