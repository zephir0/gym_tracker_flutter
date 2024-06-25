import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import '../../training-routine/training_routine_page.dart';

class UserTrainingRoutines extends StatefulWidget {
  @override
  _UserTrainingRoutinesState createState() => _UserTrainingRoutinesState();
}

class _UserTrainingRoutinesState extends State<UserTrainingRoutines> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: _buildDecoration(),
        child: _buildText(),
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _isTapped = true;
    });
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _navigateToTrainingRoutinePage();
      _resetTapState();
    });
  }

  void _navigateToTrainingRoutinePage() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: TrainingRoutinePage(),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  void _resetTapState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isTapped = false;
      });
    });
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: _isTapped
          ? Color.fromARGB(255, 173, 171, 171)
          : Color.fromRGBO(43, 138, 132, 1),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(29, 72, 69, 1), 
          offset: Offset(4, 4), 
          blurRadius: 10, 
          spreadRadius: 2, 
        ),
      ],
      image: DecorationImage(
        opacity: 0.15,
        image: AssetImage('assets/images/photo1.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 38, 50, 38),
      child: Text(
        "Your training\nroutines",
        style: GlobalVariables.fontStyle.copyWith(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
