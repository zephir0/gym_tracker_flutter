import 'package:flutter/material.dart';

import '../../../model/exercise.dart';

class DismissibleExercise extends StatefulWidget {
  final int exerciseIndex;
  final Map<String, dynamic> exercise;
  final CurvedAnimation deleteAnimationCurve;
  final VoidCallback onDismissed;
  final ValueChanged<String?> onDescriptionSaved;
  final ValueChanged<MuscleGroup?> onMuscleGroupChanged;
  final FormFieldValidator<String?> validateDescription;
  final FormFieldValidator<MuscleGroup?> validateMuscleGroup;

  const DismissibleExercise({
    required this.exerciseIndex,
    required this.exercise,
    required this.deleteAnimationCurve,
    required this.onDismissed,
    required this.onDescriptionSaved,
    required this.onMuscleGroupChanged,
    required this.validateDescription,
    required this.validateMuscleGroup,
  });

  @override
  _DismissibleExerciseState createState() => _DismissibleExerciseState();
}

class _DismissibleExerciseState extends State<DismissibleExercise> {
  late TextEditingController descriptionController;
  late ValueNotifier<MuscleGroup?> muscleGroupController;

  @override
  void initState() {
    super.initState();
    descriptionController =
        TextEditingController(text: widget.exercise['description']);
    muscleGroupController =
        ValueNotifier<MuscleGroup?>(widget.exercise['muscleGroup']);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    muscleGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => widget.onDismissed(),
      background: Container(
        color: Colors.red,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: Colors.white),
                SizedBox(width: 8.0),
              ],
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(widget.deleteAnimationCurve),
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: descriptionController,
                validator: widget.validateDescription,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 128, 125, 125)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(78, 180, 173, 0.612)),
                  ),
                  labelText: 'Description',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(78, 180, 173, 0.612)),
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  widget.onDescriptionSaved(newValue);
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: ValueListenableBuilder<MuscleGroup?>(
                valueListenable: muscleGroupController,
                builder: (context, value, child) {
                  return DropdownButtonFormField<MuscleGroup>(
                    validator: widget.validateMuscleGroup,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 128, 125, 125)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(96, 194, 187, 0.612)),
                      ),
                      labelText: 'Muscle Group',
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(
                            78,
                            180,
                            173,
                            0.612,
                          ),
                          fontSize: 17),
                      border: OutlineInputBorder(),
                    ),
                    value: value,
                    onChanged: (selectedValue) {
                      muscleGroupController.value = selectedValue;
                      widget.onMuscleGroupChanged(selectedValue);
                    },
                    items: MuscleGroup.values.map((MuscleGroup muscleGroup) {
                      return DropdownMenuItem<MuscleGroup>(
                        value: muscleGroup,
                        child: Text(
                          muscleGroup.toString().split('.').last,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
