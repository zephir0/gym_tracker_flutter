// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/api/models/training-routine.dart';
import 'package:gym_tracker_flutter/api/training-session-cubit.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/routine-exercises-displayer.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/routine-name-displayer.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:provider/provider.dart';

import '../../../utills/time-provider.dart';

class TrainingSessionCreatorPage extends StatefulWidget {
  final TrainingRoutine routine;

  const TrainingSessionCreatorPage({
    required this.routine,
  });

  @override
  _TrainingSessionCreatorPageState createState() =>
      _TrainingSessionCreatorPageState();
}

class _TrainingSessionCreatorPageState
    extends State<TrainingSessionCreatorPage> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Provider.of<TimerProvider>(context, listen: false).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrainingSessionCubit(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          decoration:
              BoxDecoration(gradient: GlobalVariables().primaryGradient),
          child: Column(
            children: [
              RoutineNameDisplayer(widget: widget),
              RoutineExercisesDisplayer(routine: widget.routine),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await _showConfirmationDialog()) ?? false;
  }

  Future<bool?> _showConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        backgroundColor: Colors.grey[850],
        title: Text(
          'Are you sure?',
          style: TextStyle(color: Color.fromRGBO(54, 150, 143, 1)),
        ),
        content: Text(
          'Do you really want to cancel the training session?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No', style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () {
              _stopTimerAndPop();
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Color.fromRGBO(54, 150, 143, 1)),
            ),
          ),
        ],
      ),
    );
  }

  void _stopTimerAndPop() {
    Provider.of<TimerProvider>(context, listen: false).stopTimer();
    Navigator.of(context).pop(true);
  }
}
