import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_event.dart';

import '../../../data/models/training_routine.dart';
import '../../training_session/training_session_creator/training_session_creator_page.dart';

class TrainingRoutineCard extends StatelessWidget {
  final TrainingRoutine trainingRoutine;
  final VoidCallback onTap;

  TrainingRoutineCard({required this.trainingRoutine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPressStart: (details) => _showLongPressMenu(context, details),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      color: Color.fromRGBO(43, 138, 132, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          _buildExerciseIcon(),
          _buildExerciseTitle(),
          _buildExerciseDetails(),
        ],
      ),
    );
  }

  Widget _buildExerciseIcon() {
    return Expanded(
      child: Icon(
        Icons.fitness_center,
        size: 48,
        color: Color.fromARGB(255, 71, 67, 67),
      ),
    );
  }

  Widget _buildExerciseTitle() {
    return Text(
      trainingRoutine.routineName,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildExerciseDetails() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Text(
        '${trainingRoutine.exerciseList.length} exercises',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }

  void _showLongPressMenu(BuildContext context, LongPressStartDetails details) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.play_arrow),
            title: Text('Start'),
            onTap: () => _startTrainingSession(context),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
            onTap: () {
              BlocProvider.of<TrainingRoutineBloc>(context, listen: false)
                  .add(ArchiveTrainingRoutine(trainingRoutine.id));
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  void _startTrainingSession(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingSessionCreatorPage(
          routine: trainingRoutine,
        ),
      ),
    );
  }
}
