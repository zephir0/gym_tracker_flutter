import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/training-log-bloc.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-details/widgets/back-button.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-details/widgets/training-log-list.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/api/models/training_log.dart';

class TrainingSessionLogsPage extends StatefulWidget {
  final trainingSessionId;
  final String routineName;

  const TrainingSessionLogsPage({
    required this.routineName,
    required this.trainingSessionId,
  });

  @override
  _TrainingSessionLogsPageState createState() =>
      _TrainingSessionLogsPageState();
}

class _TrainingSessionLogsPageState extends State<TrainingSessionLogsPage> {
  final _trainingLogBloc = TrainingLogBloc();

  @override
  void initState() {
    super.initState();
    _fetchTrainingLogs();
  }

  @override
  void dispose() {
    _trainingLogBloc.dispose();
    super.dispose();
  }

  void _fetchTrainingLogs() {
    _trainingLogBloc.fetchTrainingLogs(widget.trainingSessionId);
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
    return StreamBuilder<List<TrainingLog>>(
      stream: _trainingLogBloc.trainingLogs,
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
    );
  }
}
