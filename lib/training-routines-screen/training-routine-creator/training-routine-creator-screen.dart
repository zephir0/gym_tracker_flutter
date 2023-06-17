import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_tracker_flutter/training-routines-screen/training-routine-creator/widgets/dismissible-routine-form.dart';

import '../../global_variables.dart';

enum MuscleGroup {
  chest,
  back,
  legs,
  arms,
  shoulders,
  abs,
}

class TrainingRoutineCreatorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingRoutineCreatorScreenState();
}

class _TrainingRoutineCreatorScreenState
    extends State<TrainingRoutineCreatorScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String routineName = '';
  List<Map<String, dynamic>> exercises = [{}];
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DismissibleRoutineForm(
          formKey: _formKey,
          routineName: routineName,
          exercises: exercises,
          deleteAnimationCurve: _deleteAnimationCurve,
          onAddExercise: () {
            setState(() {
              exercises.add({});
            });
          },
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              var routine = {
                'routineName': routineName,
                'exercises': exercises
                    .map((e) => {
                          'description': e['description'],
                          'muscleGroup':
                              e['muscleGroup'].toString().split('.').last,
                        })
                    .toList(),
              };
              String routineJson = jsonEncode(routine);
              print(routineJson);
            } else
              _formKey.currentState!.save();
          },
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
