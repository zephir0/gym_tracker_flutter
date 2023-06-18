import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/training-routines-screen/training-routine-creator/widgets/back-button.dart';
import 'package:gym_tracker_flutter/training-routines-screen/training-routine-creator/widgets/submit-button.dart';

import '../../../global_variables.dart';
import 'add-exercise-button.dart';
import 'dismissible-exercise.dart';

class DismissibleRoutineForm extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  final CurvedAnimation deleteAnimationCurve;
  final VoidCallback onAddExercise;
  final VoidCallback onBack;

  DismissibleRoutineForm({
    required this.exercises,
    required this.deleteAnimationCurve,
    required this.onAddExercise,
    required this.onBack,
  });

  @override
  _DismissibleRoutineFormState createState() => _DismissibleRoutineFormState();
}

class _DismissibleRoutineFormState extends State<DismissibleRoutineForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController routineNameController = TextEditingController();
  bool shouldShake = false;
  bool isFailed = false;

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var routine = {
        'routineName': routineNameController.text,
        'exercises': widget.exercises
            .map((e) => {
                  'description': e['description'],
                  'muscleGroup': e['muscleGroup'].toString().split('.').last,
                })
            .toList(),
      };
      String jsonString = jsonEncode(routine);
      print(jsonString);
    } else {
      setState(() {
        shouldShake = true;
        isFailed = true;
      });

      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            shouldShake = false;
            isFailed = false;
          });
        }
      });
    }
  }

  String? validateRoutineName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a routine name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.down,
      onDismissed: (direction) {
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: GlobalVariables().primaryGradient,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: routineNameController,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Name your routine',
                      hintStyle: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(189, 193, 194, 0.612),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: validateRoutineName,
                  ),
                  SizedBox(height: 16.0),
                  ...widget.exercises
                      .asMap()
                      .entries
                      .map((entry) => DismissibleExercise(
                            exerciseIndex: entry.key,
                            exercise: entry.value,
                            deleteAnimationCurve: widget.deleteAnimationCurve,
                            onDismissed: () {
                              widget.exercises.removeAt(entry.key);
                            },
                            onDescriptionSaved: (value) {
                              entry.value['description'] = value;
                            },
                            onMuscleGroupChanged: (value) {
                              entry.value['muscleGroup'] = value;
                            },
                            validateDescription: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                            validateMuscleGroup: (value) {
                              if (value == null) {
                                return 'Please select a muscle group.';
                              }
                              return null;
                            },
                          ))
                      .toList(),
                  AdvancedAddExerciseButton(
                      onAddExercise: widget.onAddExercise),
                  Center(
                    child: AdvancedSubmitButton(
                      shouldShake: shouldShake,
                      isFailed: isFailed,
                      onSubmit: submit,
                    ),
                  ),
                  AdvancedBackButton(onBack: widget.onBack),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}