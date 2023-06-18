import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/training-routines-screen/training-routine-creator/widgets/dismissible-routine-form.dart';

enum MuscleGroup {
  chest,
  back,
  legs,
  arms,
  shoulders,
  abs,
}

class TrainingRoutineCreatorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingRoutineCreatorScreenState();
}

class _TrainingRoutineCreatorScreenState
    extends State<TrainingRoutineCreatorScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> exercises = [{}];
  late AnimationController _deleteAnimationController;
  late CurvedAnimation _deleteAnimationCurve;

  @override
  void initState() {
    super.initState();
    _deleteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _deleteAnimationCurve = CurvedAnimation(
      parent: _deleteAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _deleteAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onPanEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: DismissibleRoutineForm(
            exercises: exercises,
            deleteAnimationCurve: _deleteAnimationCurve,
            onAddExercise: () {
              setState(() {
                exercises.add({});
              });
            },
            onBack: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
