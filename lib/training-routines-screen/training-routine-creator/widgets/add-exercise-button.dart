import 'package:flutter/material.dart';

class AddExerciseButton extends StatelessWidget {
  final VoidCallback onAddExercise;

  const AddExerciseButton({required this.onAddExercise});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          onPressed: onAddExercise,
          icon: Icon(Icons.add),
          label: Text('Add Exercise'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
