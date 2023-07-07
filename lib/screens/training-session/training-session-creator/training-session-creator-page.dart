// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/models/training-routine.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/routine-exercises-displayer.dart';
import 'package:gym_tracker_flutter/screens/training-session/training-session-creator/widgets/routine-name-displayer.dart';

import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:provider/provider.dart';

import '../../../utills/time-provider.dart';

class TrainingSessionCreatorPage extends StatefulWidget {
  final TrainingRoutine routine;
  TrainingSessionCreatorPage({
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
    Provider.of<TimerProvider>(context, listen: false).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
        child: Column(
          children: [
            RoutineNameDisplayer(widget: widget),
            RoutineExercisesDisplayer(routine: widget.routine),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            backgroundColor: Colors.grey[850],
            title: new Text('Are you sure?',
                style: TextStyle(color: Color.fromRGBO(54, 150, 143, 1))),
            content: new Text(
                'Do you really want to cancel the training session?',
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child:
                    new Text('No', style: TextStyle(color: Colors.redAccent)),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes',
                    style: TextStyle(color: Color.fromRGBO(54, 150, 143, 1))),
              ),
            ],
          ),
        )) ??
        false;
  }
}
