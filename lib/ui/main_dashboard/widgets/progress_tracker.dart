import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/ui/settings/settings_page.dart';
import 'package:page_transition/page_transition.dart';

class ProgressTracker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  bool _tapped = false;
  void _handleTap() {
    setState(() {
      _tapped = true;
    });
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      setState(() {
        _tapped = false;
      });

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: SettingsPage(),
          duration: Duration(milliseconds: 300),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: _buildContainerDecoration(),
          child: _buildContent(),
        ),
      ),
    );
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
      color: _tapped ? Colors.grey : Color.fromRGBO(43, 138, 132, 1),
      borderRadius: BorderRadius.circular(32),
      image: DecorationImage(
        opacity: 0.15,
        image: AssetImage('assets/images/your-training-routines.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(70, 40, 70, 40),
      child: Text(
        "Progress Tracker",
        style: GlobalVariables.fontStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
