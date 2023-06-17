import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/training-routines-screen/training-routine-creator/widgets/submit-button.dart';

import '../../../global_variables.dart';
import 'add-exercise-button.dart';
import 'dismissible-exercise.dart';

class DismissibleRoutineForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String routineName;
  final List<Map<String, dynamic>> exercises;
  final CurvedAnimation deleteAnimationCurve;
  final VoidCallback onAddExercise;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const DismissibleRoutineForm({
    required this.formKey,
    required this.routineName,
    required this.exercises,
    required this.deleteAnimationCurve,
    required this.onAddExercise,
    required this.onSubmit,
    required this.onBack,
  });

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
              key: formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Routine Name',
                      labelStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      value = routineName;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ...exercises
                      .asMap()
                      .entries
                      .map((entry) => DismissibleExercise(
                            exerciseIndex: entry.key,
                            exercise: entry.value,
                            deleteAnimationCurve: deleteAnimationCurve,
                            onDismissed: () {
                              exercises.removeAt(entry.key);
                            },
                            onDescriptionSaved: (value) {
                              entry.value['description'] = value ?? '';
                            },
                            onMuscleGroupChanged: (value) {
                              entry.value['muscleGroup'] = value;
                            },
                          ))
                      .toList(),
                  AddExerciseButton(onAddExercise: onAddExercise),
                  SubmitButton(onSubmit: onSubmit),
                  BackButton(onPressed: onBack),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
