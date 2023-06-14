import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/global_variables.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/user-training-routines.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/user-welcome-panel.dart';
import 'package:gym_tracker_flutter/home-screen.dart/widgets/workout-count.dart';

class ProgressTracker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tapped = true;
          });
          Future.delayed(Duration(milliseconds: 200)).then((_) {
            setState(() {
              _tapped = false;
            });
          });
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: _tapped ? Colors.grey : Color.fromRGBO(43, 138, 132, 1),
                borderRadius: BorderRadius.circular(32),
                image: DecorationImage(
                    opacity: 0.15,
                    image:
                        AssetImage('assets/images/your-training-routines.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(70, 40, 70, 40),
              child: Text(
                "Progress Tracker",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )),
      ),
    );
  }
}
