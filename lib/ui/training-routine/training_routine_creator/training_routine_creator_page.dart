import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine_cubit.dart';
import 'package:gym_tracker_flutter/ui/training-routine/training_routine_creator/widgets/dismissible_routine_form.dart';

enum MuscleGroup {
  CHEST,
  BACK,
  LEGS,
  ARMS,
  SHOULDERS,
  ABS,
}

class TrainingRoutineCreatorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingRoutineCreatorPageState();
}

class _TrainingRoutineCreatorPageState extends State<TrainingRoutineCreatorPage>
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
        child: BlocProvider(
          create: (_) => TrainingRoutineCubit(),
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
      ),
    );
  }
}
