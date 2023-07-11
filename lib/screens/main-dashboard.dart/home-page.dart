import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/progress-tracker.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/recent-training-sessions-display.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/recent-workouts-header.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/user-training-routines.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/user-welcome-panel.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard.dart/widgets/workout-count.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:provider/provider.dart';

import '../../api/training-session-bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isRefreshing = false;
  late AnimationController _deleteAnimationController;
  late CurvedAnimation _deleteAnimationCurve;

  @override
  void initState() {
    super.initState();

    _deleteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _deleteAnimationCurve = CurvedAnimation(
      parent: _deleteAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _deleteAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onVerticalDragEnd: (details) {
            _handleRefresh();
          },
          child: Container(
            decoration:
                BoxDecoration(gradient: GlobalVariables().primaryGradient),
            child: Column(
              children: [
                UserWelcomePanel(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WorkoutCount(),
                    UserTrainingRoutines(),
                  ],
                ),
                ProgressTracker(),
                RecentWorkoutsHeader(),
                RecentTrainingSessionsDisplay(
                  deleteAnimationCurve: _deleteAnimationCurve,
                ),
              ],
            ),
          ),
        ),
        if (_isRefreshing)
          LinearProgressIndicator(
            color: Color.fromRGBO(24, 218, 205, 0.612),
            minHeight: 8,
            backgroundColor: Colors.transparent,
          ), // Shows at the top of the widget
      ],
    );
  }
}
