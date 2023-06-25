import 'package:flutter/material.dart';
import '../../../model/training-routine.dart';

class ExerciseControllers {
  final VoidCallback notifyParent;
  final int exercisesLength;
  List<List<TextEditingController>> repsControllers = [];
  List<List<TextEditingController>> weightControllers = [];
  List<List<TextEditingController>> notesControllers = [];

  ExerciseControllers(
      {required this.notifyParent, required this.exercisesLength}) {
    initControllerLists();
  }

  void initControllerLists() {
    for (var i = 0; i < exercisesLength; i++) {
      repsControllers.add([TextEditingController()]);
      weightControllers.add([TextEditingController()]);
      notesControllers.add([TextEditingController()]);
    }
  }

  void dispose() {
    for (var i = 0; i < exercisesLength; i++) {
      disposeControllers(repsControllers[i]);
      disposeControllers(weightControllers[i]);
      disposeControllers(notesControllers[i]);
    }
  }

  void disposeControllers(List<TextEditingController> controllers) {
    controllers.forEach((controller) => controller.dispose());
  }

  void addNewSet(int exerciseIndex) {
    repsControllers[exerciseIndex].add(TextEditingController());
    weightControllers[exerciseIndex].add(TextEditingController());
    notesControllers[exerciseIndex].add(TextEditingController());
    notifyParent();
  }

  void removeSet(int exerciseIndex, int setIndex) {
    if (setIndex == 0 && repsControllers[exerciseIndex].length == 1) {
      print("Can't remove last set");
    } else {
      repsControllers[exerciseIndex][setIndex].dispose();
      weightControllers[exerciseIndex][setIndex].dispose();
      notesControllers[exerciseIndex][setIndex].dispose();

      repsControllers[exerciseIndex].removeAt(setIndex);
      weightControllers[exerciseIndex].removeAt(setIndex);
      notesControllers[exerciseIndex].removeAt(setIndex);
      notifyParent();
    }
  }

  List<Map<String, dynamic>> getJsonData({required TrainingRoutine routine}) {
    List<Map<String, dynamic>> jsonData = [];
    for (var i = 0; i < routine.exerciseList.length; i++) {
      List<Map<String, dynamic>> exerciseData = [];
      for (int j = 0; j < repsControllers[i].length; j++) {
        exerciseData.add({
          'reps': repsControllers[i][j].text,
          'weight': weightControllers[i][j].text,
          'notes': notesControllers[i][j].text,
        });
      }

      jsonData.add({
        'exerciseName': routine.exerciseList[i].name,
        'exerciseData': exerciseData,
      });
    }
    return jsonData;
  }
}
