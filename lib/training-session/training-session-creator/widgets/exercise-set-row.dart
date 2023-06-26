import 'package:flutter/material.dart';

class ExerciseSetRow extends StatelessWidget {
  final int exerciseIndex;
  final int setIndex;
  final TextEditingController repsController;
  final TextEditingController weightController;
  final TextEditingController notesController;
  final bool canDelete;
  final Function onDelete;

  const ExerciseSetRow({
    required this.exerciseIndex,
    required this.setIndex,
    required this.repsController,
    required this.weightController,
    required this.notesController,
    required this.canDelete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (canDelete) {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (_) => onDelete(exerciseIndex, setIndex),
        child: buildSetRow(context),
      );
    } else {
      return buildSetRow(context);
    }
  }

  Row buildSetRow(context) {
    return Row(
      children: [
        buildSetNumber(),
        buildPreviousWeight(), // This appears to be a duplicate in the original code
        buildTextField('Reps', repsController, context),
        buildTextField('Weight', weightController, context),
        buildTextField('Notes', notesController, context),
      ],
    );
  }

  Expanded buildSetNumber() {
    return Expanded(
      flex: 2,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              (setIndex + 1).toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildPreviousWeight() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            "1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildTextField(
      String hint, TextEditingController controller, BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          keyboardType: hint.contains("Notes")
              ? TextInputType.text
              : TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          controller: controller,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            isDense: true,
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                ((hint == "Weight" || hint == "Reps") &&
                    double.tryParse(value) == null)) {
              return 'Error!';
            }
            return null;
          },
        ),
      ),
    );
  }
}
