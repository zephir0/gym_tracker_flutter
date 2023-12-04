import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log_cubit.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_details/widgets/back_button.dart';
import 'package:gym_tracker_flutter/ui/training_session/training_session_details/widgets/training_log_list.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';

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
      create: (context) =>
          TrainingLogCubit()..fetchTrainingLogs(widget.trainingSessionId),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Container(
            decoration:
                BoxDecoration(gradient: GlobalVariables().primaryGradient),
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
        color: Color.fromRGBO(8, 25, 255, 0.612),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Text(
          widget.routineName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTrainingLogList() {
    return BlocBuilder<TrainingLogCubit, List<TrainingLog>>(
      builder: (context, trainingLogs) {
        if (trainingLogs.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return TrainingLogList(trainingLogs: trainingLogs);
        }
      },
    );
  }
}
