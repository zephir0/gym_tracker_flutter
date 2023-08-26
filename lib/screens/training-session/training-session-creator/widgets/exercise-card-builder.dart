import 'package:flutter/material.dart';
import '../../../../api/models/exercise.dart';
import '../exercise-controllers.dart';
import 'exercise-set-row.dart';

class ExerciseCardBuilder extends StatefulWidget {
  final String hintReps;
  final String hintWeights;
  final Exercise exercise;
  final int index;
  final ExerciseControllers controllers;
  @override
  _ExerciseCardBuilderState createState() => _ExerciseCardBuilderState();
  const ExerciseCardBuilder({
    required this.hintReps,
    required this.hintWeights,
    required this.exercise,
    required this.index,
    required this.controllers,
  });
}

class _ExerciseCardBuilderState extends State<ExerciseCardBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
      child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        color: Color.fromARGB(255, 48, 49, 48),
        child: Column(
          children: [
            buildTitleTile(widget.exercise),
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
    return List.generate(
        widget.controllers.repsControllers[widget.index].length, (setIndex) {
      return ExerciseSetRow(
        exerciseIndex: widget.index,
        setIndex: setIndex,
        repsController: widget.controllers.repsControllers[widget.index]
            [setIndex],
        weightController: widget.controllers.weightControllers[widget.index]
            [setIndex],
        notesController: widget.controllers.notesControllers[widget.index]
            [setIndex],
        canDelete: widget.controllers.repsControllers[widget.index].length > 1,
        onDelete: widget.controllers.removeSet,
        hintsReps: widget.hintReps,
        hintsWeight: widget.hintWeights,
      );
    });
  }

  OutlinedButton buildAddSetButton() {
    return OutlinedButton.icon(
      onPressed: () => widget.controllers.addNewSet(widget.index),
      icon: Icon(Icons.add, size: 19, color: Colors.white),
      label: Text(
        'ADD SET',
        style:
            TextStyle(fontSize: 17, color: Color.fromARGB(255, 177, 189, 182)),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 3.0, color: Color.fromARGB(255, 6, 53, 31)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Color.fromARGB(255, 14, 61, 41),
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
      ),
    );
  }
}
