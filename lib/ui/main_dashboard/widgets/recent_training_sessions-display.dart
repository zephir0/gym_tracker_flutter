import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_state.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../data/models/training_session.dart';
import '../../training_session/training_session_details/training_session_logs_page.dart';

class RecentTrainingSessionsDisplay extends StatelessWidget {
  final CurvedAnimation deleteAnimationCurve;

  const RecentTrainingSessionsDisplay({required this.deleteAnimationCurve});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TrainingSessionBloc, TrainingSessionState>(
        builder: (context, state) {
          if (state is TrainingSessionInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TrainingSessionLoaded) {
            List<TrainingSession> reversedTrainingSessions =
                state.sessions.reversed.toList();
            return SingleChildScrollView(
              child: Column(
                children: reversedTrainingSessions
                    .map((trainingSession) => _buildDismissibleTrainingSession(
                        context, trainingSession, reversedTrainingSessions))
                    .toList(),
              ),
            );
          } else if (state is TrainingSessionError) {
            return Center(child: Text('Error'));
          }

          return Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  Widget _buildDismissibleTrainingSession(BuildContext context,
      TrainingSession trainingSession, List<TrainingSession> trainingSessions) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        BlocProvider.of<TrainingSessionBloc>(context)
            .add(DeleteTrainingSession(trainingSession.id));
      },
      background: _buildDismissibleBackground(),
      child: GestureDetector(
        onTap: () => _navigateToTrainingSessionLogsPage(
            context, trainingSession, trainingSessions),
        child: _buildTrainingSessionContainer(trainingSession),
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      color: Colors.red,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 8.0),
            ],
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(deleteAnimationCurve),
            child: Text(
              'Delete',
              style: GlobalVariables.fontStyle.copyWith(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingSessionContainer(TrainingSession trainingSession) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(80, 80, 80, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildFlexibleTrainingInfo(trainingSession, 0),
          SizedBox(width: 10),
          _buildFlexibleTrainingInfo(trainingSession, 1),
          SizedBox(width: 10),
          _buildFlexibleTrainingInfo(trainingSession, 2),
        ],
      ),
    );
  }

  Widget _buildFlexibleTrainingInfo(
      TrainingSession trainingSession, int index) {
    return Expanded(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTrainingInfo(trainingSession, index),
        ],
      ),
    );
  }

  Widget _buildTrainingInfo(TrainingSession trainingSession, int index) {
    String text = '';
    TextStyle textStyle = GlobalVariables.fontStyle.copyWith(
      fontSize: 17,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );

    switch (index) {
      case 0:
        text = trainingSession.routineName;
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.bold,
        );
        break;
      case 1:
        text = _formatTrainingDate(trainingSession.trainingDate);
        textStyle = textStyle.copyWith(
          color: Color.fromARGB(255, 0, 155, 129),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        );
        break;
      case 2:
        text = '${trainingSession.totalWeight.toString()} kg';
        textStyle = textStyle.copyWith(
          fontSize: 28,
        );
        break;
    }

    return Text(
      text,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
    );
  }

  void _navigateToTrainingSessionLogsPage(BuildContext context,
      TrainingSession trainingSession, List<TrainingSession> trainingSessions) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: TrainingSessionLogsPage(
          routineName: trainingSession.routineName,
          trainingSessionId: trainingSession.id.toString(),
        ),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  String _formatTrainingDate(String dateString) {
    DateTime selectedDate = DateFormat("dd-MM-yyyy").parse(dateString);
    String formattedDate = DateFormat('EEEE, dd MMM yyyy').format(selectedDate);

    final parts = formattedDate.split(' ');

    if (parts.length >= 3) {
      return '${parts[0]}\n${parts.sublist(1).join(' ')}';
    } else {
      return formattedDate;
    }
  }
}
