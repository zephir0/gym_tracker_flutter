import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_state.dart';
import 'package:gym_tracker_flutter/ui/training-routine/training_routine_creator/widgets/submit_button.dart';
import 'package:gym_tracker_flutter/ui/training-routine/training_routine_page.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

import 'add_exercise_button.dart';
import 'back_button.dart';
import 'dismissible_exercise.dart';

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
    return BlocListener<TrainingRoutineBloc, TrainingRoutineState>(
      listener: (context, state) {
        if (state is TrainingRoutineCreationSuccess) {
          _handleSuccessRoutineCreation();
        } else if (state is TrainingRoutineCreationFailure) {
          _handleFailedRoutineCreation();
        }
      },
      child: BlocBuilder<TrainingRoutineBloc, TrainingRoutineState>(
          builder: (context, state) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.down,
          onDismissed: (direction) {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: ColorPalette.primaryThemeGradient,
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
      }),
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
        color: ColorPalette.textColor,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Name your routine',
        hintStyle: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: ColorPalette.textFormFieldHintColor,
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
      final routineData = _prepareRoutine();
      BlocProvider.of<TrainingRoutineBloc>(context)
          .add(CreateTrainingRoutine(routineData));
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
