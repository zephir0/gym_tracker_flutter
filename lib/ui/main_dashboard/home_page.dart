import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_event.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/widgets/progress_tracker.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/widgets/recent_training_sessions-display.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/widgets/recent_workouts_header.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/widgets/user_training_routines.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/widgets/user_welcome_panel.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/widgets/workout_count.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

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
    return BlocProvider(
      create: (_) => TrainingSessionBloc()..add(FetchTrainingSessions()),
      child: Stack(
        children: [
          _buildContent(context),
          _buildLinearProgressIndicator() ?? SizedBox.shrink(),
        ],
      ),
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
        gradient: ColorPalette.primaryThemeGradient,
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
        color: ColorPalette.dashboardUsernameTextColor,
        minHeight: 8,
        backgroundColor: Colors.transparent,
      );
    }
    return null;
  }
}
