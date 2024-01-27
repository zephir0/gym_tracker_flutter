import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

import '../training_session_creator_page.dart';

class RoutineNameDisplayer extends StatelessWidget {
  const RoutineNameDisplayer({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TrainingSessionCreatorPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 35, 40, 15),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 45, 42, 1),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.routine.routineName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorPalette.textColor,
                decoration: TextDecoration.none,
                fontSize: 32),
          ),
        ),
      ),
    );
  }
}
