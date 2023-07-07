import 'package:flutter/material.dart';
import '../../../../api/models/exercise.dart';
import '../exercise-controllers.dart';
import 'exercise-set-row.dart';

class ExerciseCardBuilder extends StatelessWidget {
  final Exercise exercise;
  final int index;
  final ExerciseControllers controllers;

  const ExerciseCardBuilder({
    required this.exercise,
    required this.index,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        color: Color.fromARGB(255, 48, 49, 48),
        child: Column(
          children: [
            buildTitleTile(exercise),
            buildRowHeaders(),
            ...buildRowEntries(),
            buildAddSetButton(),
          ],
        ),
      ),
    );
  }

  ListTile buildTitleTile(Exercise exercise) {
    return ListTile(
      title: Text(
        exercise.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(43, 138, 132, 1),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Padding buildRowHeaders() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          buildHeader('Set', 2),
          buildHeader('Previous', 3),
          buildHeader('Reps', 3),
          buildHeader('Weight', 3),
          buildHeader('Notes', 3),
        ],
      ),
    );
  }

  Expanded buildHeader(String title, int flex) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  List<Widget> buildRowEntries() {
    return List.generate(controllers.repsControllers[index].length, (setIndex) {
      return ExerciseSetRow(
        exerciseIndex: index,
        setIndex: setIndex,
        repsController: controllers.repsControllers[index][setIndex],
        weightController: controllers.weightControllers[index][setIndex],
        notesController: controllers.notesControllers[index][setIndex],
        canDelete: controllers.repsControllers[index].length > 1,
        onDelete: controllers.removeSet,
      );
    });
  }

  OutlinedButton buildAddSetButton() {
    return OutlinedButton.icon(
      onPressed: () => controllers.addNewSet(index),
      icon: Icon(Icons.add, size: 16),
      label: Text(
        'Add new set',
        style: TextStyle(fontSize: 12),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1.0, color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
      ),
    );
  }
}
