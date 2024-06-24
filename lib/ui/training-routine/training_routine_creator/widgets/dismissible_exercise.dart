import 'package:flutter/material.dart';

import '../../../../data/models/exercise.dart';

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
    _initializeControllers();
  }

  void _initializeControllers() {
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
      background: _buildDeleteBackground(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildDescriptionTextField(),
            ),
            SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: _buildMuscleGroupField(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
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
          _buildDeleteSlideTransition(),
        ],
      ),
    );
  }

  SlideTransition _buildDeleteSlideTransition() {
    return SlideTransition(
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
    );
  }

  TextFormField _buildDescriptionTextField() {
    return TextFormField(
      controller: descriptionController,
      validator: widget.validateDescription,
      style: TextStyle(
        fontSize: 17.0,
        color: Colors.black87, 
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54), 
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), 
        ),
        labelText: 'Description',
        labelStyle: TextStyle(color: Colors.black54), 
        border: OutlineInputBorder(),
      ),
      onChanged: _handleDescriptionSaved,
    );
  }

  Widget _buildMuscleGroupField() {
    return DropdownButtonFormField<MuscleGroup>(
      value: muscleGroupController.value,
      items: MuscleGroup.values
          .map((muscleGroup) => DropdownMenuItem<MuscleGroup>(
                value: muscleGroup,
                child: Text(muscleGroup.toString().split('.').last.toUpperCase()),
              ))
          .toList(),
      onChanged: (newValue) {
        setState(() {
          muscleGroupController.value = newValue;
          widget.onMuscleGroupChanged(newValue);
        });
      },
      validator: widget.validateMuscleGroup,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54), 
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), 
        ),
        labelText: 'Muscle Group',
        labelStyle: TextStyle(color: Colors.black54), 
        border: OutlineInputBorder(),
      ),
    );
  }

  void _handleDescriptionSaved(String newValue) {
    widget.onDescriptionSaved(newValue);
  }
}
