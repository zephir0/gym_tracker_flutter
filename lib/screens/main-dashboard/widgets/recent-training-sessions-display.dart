import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/api/training-session-cubit.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../api/models/training-session.dart';
import '../../training-session/training-session-details/training-session-logs-page.dart';

class RecentTrainingSessionsDisplay extends StatelessWidget {
  final CurvedAnimation deleteAnimationCurve;

  const RecentTrainingSessionsDisplay({required this.deleteAnimationCurve});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TrainingSessionCubit, TrainingSessionState>(
        builder: (context, trainingSessions) {
          if (trainingSessions.sessions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          List<TrainingSession> reversedTrainingSessions =
              trainingSessions.sessions.reversed.toList();
          return SingleChildScrollView(
            child: Column(
              children: reversedTrainingSessions
                  .map((trainingSession) => _buildDismissibleTrainingSession(
                      context, trainingSession, reversedTrainingSessions))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDismissibleTrainingSession(BuildContext context,
      TrainingSession trainingSession, List<TrainingSession> trainingSessions) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        BlocProvider.of<TrainingSessionCubit>(context)
            .deleteTrainingSession(trainingSession.id);
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
              style: TextStyle(
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
    TextStyle textStyle = TextStyle(
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
