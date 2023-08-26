import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/training-session-bloc.dart';
import 'package:provider/provider.dart';

import '../../../api/models/training-session.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../training-session/training-session-details/training-session-logs-page.dart';

class RecentTrainingSessionsDisplay extends StatefulWidget {
  final CurvedAnimation deleteAnimationCurve;

  const RecentTrainingSessionsDisplay({required this.deleteAnimationCurve});

  @override
  _RecentTrainingSessionsDisplayState createState() =>
      _RecentTrainingSessionsDisplayState();
}

class _RecentTrainingSessionsDisplayState
    extends State<RecentTrainingSessionsDisplay> {
  late TrainingSessionBloc _trainingSessionBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _trainingSessionBloc = Provider.of<TrainingSessionBloc>(context);
    _trainingSessionBloc.fetchRecentTrainingSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _buildRecentTrainingSessionsList(),
    );
  }

  Widget _buildRecentTrainingSessionsList() {
    return StreamBuilder<List<TrainingSession>>(
      stream: _trainingSessionBloc.recentTrainingSessions,
      builder: _buildTrainingSessionsColumn,
    );
  }

  Widget _buildTrainingSessionsColumn(
      BuildContext context, AsyncSnapshot<List<TrainingSession>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      List<TrainingSession> trainingSessions = snapshot.data!.reversed.toList();
      return SingleChildScrollView(
        child: Column(
          children: trainingSessions
              .map((trainingSession) => _buildDismissibleTrainingSession(
                  trainingSession, trainingSessions))
              .toList(),
        ),
      );
    }
  }

  Widget _buildDismissibleTrainingSession(
      TrainingSession trainingSession, List<TrainingSession> trainingSessions) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => _deleteTrainingSession(trainingSession.id),
      background: _buildDismissibleBackground(),
      child: GestureDetector(
        onTap: () => _navigateToTrainingSessionLogsPage(
            trainingSession, trainingSessions),
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
            ).animate(widget.deleteAnimationCurve),
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(80, 80, 80, 100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 50,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 0.0,
        ),
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _buildTrainingInfo(trainingSession, index);
        },
      ),
    );
  }

  void _navigateToTrainingSessionLogsPage(
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

  void _deleteTrainingSession(int sessionId) {
    _trainingSessionBloc.deleteTrainingSession(sessionId);
  }

  String _formatTrainingDate(String dateString) {
    DateTime selectedDate = DateFormat("dd-MM-yyyy").parse(dateString);
    String formattedDate = DateFormat('EEEE, dd MMM yyyy').format(selectedDate);
    return formattedDate;
  }

  Widget _buildTrainingInfo(TrainingSession trainingSession, int index) {
    String text = '';
    switch (index) {
      case 0:
        text = trainingSession.routineName;
        break;
      case 1:
        text = _formatTrainingDate(trainingSession.trainingDate);
        break;
      case 2:
        text = '${trainingSession.totalWeight.toString()} kg';
        break;
    }
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(80, 187, 180, 0.612),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
