import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../api/models/training-routine.dart';
import '../../../api/training-routine-bloc.dart';
import '../../training-session/training-session-creator/training-session-creator-page.dart';

class TrainingRoutineCard extends StatelessWidget {
  final TrainingRoutine trainingRoutine;
  final VoidCallback onTap;

  TrainingRoutineCard({required this.trainingRoutine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TrainingRoutineBloc>(context, listen: false);
    return GestureDetector(
      onTap: onTap,
      onLongPressStart: (details) => _showLongPressMenu(context, details, bloc),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
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
    return Text(trainingRoutine.routineName,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
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

  void _showLongPressMenu(
      BuildContext context, LongPressStartDetails details, bloc) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy),
      items: <PopupMenuEntry>[
        _buildPopupMenuItem(context, Icons.play_arrow, 'Start',
            () => _startTrainingSession(context)),
        _buildPopupMenuItem(context, Icons.delete, 'Delete',
            () => _deleteRoutine(context, bloc)),
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      BuildContext context, IconData icon, String text, VoidCallback? onTap) {
    return PopupMenuItem(
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }

  void _deleteRoutine(BuildContext context, bloc) {
    bloc.archiveTrainingRoutine(trainingRoutine.id);
    bloc.getTrainingRoutines();
    Navigator.of(context).pop();
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
