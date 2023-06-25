import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../training-routine/training-routine-page.dart';

class UserTrainingRoutines extends StatefulWidget {
  @override
  _UserTrainingRoutinesState createState() => _UserTrainingRoutinesState();
}

class _UserTrainingRoutinesState extends State<UserTrainingRoutines> {
  bool _tapped = false;

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
      _tapped = true;
    });
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: TrainingRoutinePage(),
          duration: Duration(milliseconds: 300),
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _tapped = false;
        });
      });
    });
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: _tapped
          ? Color.fromARGB(255, 173, 171, 171)
          : Color.fromRGBO(43, 138, 132, 1),
      borderRadius: BorderRadius.circular(30),
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
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
