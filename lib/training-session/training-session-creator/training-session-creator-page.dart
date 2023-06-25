// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/model/training-routine.dart';
import 'package:gym_tracker_flutter/training-session/training-session-creator/widgets/routine-exercises-displayer.dart';
import 'package:gym_tracker_flutter/training-session/training-session-creator/widgets/routine-name-displayer.dart';

import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:provider/provider.dart';

import '../../utills/time-provider.dart';

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
    return Container(
      decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
      child: Column(
        children: [
          RoutineNameDisplayer(widget: widget),
          RoutineExercisesDisplayer(routine: widget.routine),
        ],
      ),
    );
  }
}
