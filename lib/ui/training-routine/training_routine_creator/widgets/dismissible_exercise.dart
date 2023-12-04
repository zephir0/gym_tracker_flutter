import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
  final TextEditingController _typeAheadController = TextEditingController();

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
        color: Colors.white,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 128, 125, 125)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(78, 180, 173, 0.612)),
        ),
        labelText: 'Description',
        labelStyle: TextStyle(color: Color.fromRGBO(78, 180, 173, 0.612)),
        border: OutlineInputBorder(),
      ),
      onChanged: _handleDescriptionSaved,
    );
  }

  ValueListenableBuilder<MuscleGroup?> _buildMuscleGroupField() {
    return ValueListenableBuilder<MuscleGroup?>(
      valueListenable: muscleGroupController,
      builder: (context, value, child) {
        return TypeAheadFormField<MuscleGroup>(
          validator: (value) {
            if (value == null) {
              return 'Muscle group is required';
            } else if (!MuscleGroup.values
                .map((e) => e.toString().split('.').last.toUpperCase())
                .contains(value)) {
              return 'Invalid muscle group';
            }
            return null;
          },
          textFieldConfiguration: _buildTypeAheadFieldConfiguration(),
          onSuggestionSelected: _handleMuscleGroupSelected,
          itemBuilder: _buildMuscleGroupListItem,
          suggestionsCallback: _getFilteredMuscleGroups,
        );
      },
    );
  }

  TextFieldConfiguration _buildTypeAheadFieldConfiguration() {
    return TextFieldConfiguration(
      style: TextStyle(
        fontSize: 17.0,
        color: Colors.white,
      ),
      controller: _typeAheadController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 128, 125, 125)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(96, 194, 187, 0.612)),
        ),
        labelText: 'Muscle Group',
        labelStyle: TextStyle(
          color: Color.fromRGBO(78, 180, 173, 0.612),
          fontSize: 17,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }

  void _handleDescriptionSaved(String newValue) {
    widget.onDescriptionSaved(newValue);
  }

  void _handleMuscleGroupSelected(MuscleGroup suggestion) {
    muscleGroupController.value = suggestion;
    widget.onMuscleGroupChanged(suggestion);
    _typeAheadController.text =
        suggestion.toString().split('.').last.toUpperCase();
  }

  ListTile _buildMuscleGroupListItem(
      BuildContext context, MuscleGroup muscleGroup) {
    return ListTile(
      tileColor: Color.fromRGBO(34, 34, 34, 1),
      title: Text(
        muscleGroup.toString().split('.').last.toUpperCase(),
        style: TextStyle(
          color: Color.fromRGBO(96, 194, 187, 0.612),
          fontSize: 16,
        ),
      ),
    );
  }

  List<MuscleGroup> _getFilteredMuscleGroups(String pattern) {
    return MuscleGroup.values
        .where((MuscleGroup muscleGroup) => muscleGroup
            .toString()
            .split('.')
            .last
            .toUpperCase()
            .contains(pattern.toUpperCase()))
        .toList();
  }
}
