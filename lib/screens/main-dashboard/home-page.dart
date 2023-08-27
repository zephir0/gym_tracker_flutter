import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard/widgets/progress-tracker.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard/widgets/recent-training-sessions-display.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard/widgets/recent-workouts-header.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard/widgets/user-training-routines.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard/widgets/user-welcome-panel.dart';
import 'package:gym_tracker_flutter/screens/main-dashboard/widgets/workout-count.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';

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
    _initAnimation();
  }

  void _initAnimation() {
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
    _startRefresh();
    await Future.delayed(Duration(seconds: 1));
    _endRefresh();
  }

  void _startRefresh() {
    setState(() {
      _isRefreshing = true;
    });
  }

  void _endRefresh() {
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildContent(context),
        _buildLinearProgressIndicator() ?? SizedBox.shrink(),
      ],
    );
  }

  GestureDetector _buildContent(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (_) => _handleRefresh(),
      child: _buildContainer(context),
    );
  }

  Container _buildContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables().primaryGradient,
      ),
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
    );
  }

  LinearProgressIndicator? _buildLinearProgressIndicator() {
    if (_isRefreshing) {
      return LinearProgressIndicator(
        color: Color.fromRGBO(24, 218, 205, 0.612),
        minHeight: 8,
        backgroundColor: Colors.transparent,
      );
    }
    return null;
  }
}
