import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class ExerciseSetRow extends StatelessWidget {
  final int exerciseIndex;
  final int setIndex;
  final TextEditingController repsController;
  final TextEditingController weightController;
  final TextEditingController notesController;
  final bool canDelete;
  final Function onDelete;
  final String hintsReps;
  final String hintsWeight;

  const ExerciseSetRow({
    required this.exerciseIndex,
    required this.setIndex,
    required this.repsController,
    required this.weightController,
    required this.notesController,
    required this.canDelete,
    required this.onDelete,
    required this.hintsReps,
    required this.hintsWeight,
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
        buildTextField(hintsReps, repsController, context),
        buildTextField(hintsWeight, weightController, context),
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
              style: GlobalVariables.fontStyle.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
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
          style: GlobalVariables.fontStyle.copyWith(
            color: Colors.white,
            fontSize: 12,
          ),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            isDense: true,
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(),
            hintText: hint,
            hintStyle: GlobalVariables.fontStyle.copyWith(
              color: Color.fromRGBO(193, 207, 59, 0.612),
            ),
          ),
          validator: (value) {
            if (hint == "Notes" && value!.isEmpty) {
              return null;
            }
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
