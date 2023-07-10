import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/screens/training-routine/training-routine-creator/widgets/submit-button.dart';
import 'package:gym_tracker_flutter/screens/training-routine/training-routine-page.dart';

import '../../../../api/training-routine-bloc.dart';
import '../../../../utills/global_variables.dart';
import 'add-exercise-button.dart';
import 'back-button.dart';
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
  late TextEditingController routineNameController;
  bool shouldShake = false;
  bool isFailed = false;
  bool isSaved = false;
  final _bloc = TrainingRoutineBloc();

  @override
  void initState() {
    super.initState();
    routineNameController = TextEditingController();
  }

  Map<String, dynamic> _prepareRoutine() {
    return {
      'routineName': routineNameController.text,
      'exerciseList': widget.exercises
          .map((e) => {
                'name': e['description'],
                'muscleGroup':
                    e['muscleGroup'].toString().split('.').last.toUpperCase(),
              })
          .toList(),
    };
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
                  _buildNameFormField(),
                  SizedBox(height: 16.0),
                  ..._buildDismissibleExercises(),
                  AdvancedAddExerciseButton(
                      onAddExercise: widget.onAddExercise),
                  Center(
                    child: AdvancedSubmitButton(
                      shouldShake: shouldShake,
                      isFailed: isFailed,
                      isSaved: isSaved, // pass the new state
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

  List<Widget> _buildDismissibleExercises() {
    return widget.exercises
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
        .toList();
  }

  Widget _buildNameFormField() {
    return TextFormField(
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
    );
  }

  String? validateRoutineName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a routine name';
    }
    return null;
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _createRoutine();
      setState(() {
        isSaved = true;
      });
    } else {
      _handleFailedRoutineCreation();
    }
  }

  Future<void> _createRoutine() async {
    final routine = _prepareRoutine();
    bool isRoutineCreated = await _bloc.createTrainingRoutine(routine);

    if (isRoutineCreated) {
      await _handleSuccessRoutineCreation();
    } else {
      _handleFailedRoutineCreation();
    }
  }

  Future<void> _handleSuccessRoutineCreation() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Training routine created successfully'),
        duration: Duration(seconds: 2),
      ),
    );
    setState(() {
      isSaved = true;
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TrainingRoutinePage()));
      });
    });
  }

  void _handleFailedRoutineCreation() {
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
