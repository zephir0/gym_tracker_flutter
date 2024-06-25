import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class FinishWorkoutButton extends StatelessWidget {
  final Function() onFinishWorkout;
  final bool isWorkoutFinished;

  const FinishWorkoutButton({
    required this.onFinishWorkout,
    this.isWorkoutFinished = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
        child: Center(
          child: Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: onFinishWorkout,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isWorkoutFinished
                        ? Color.fromARGB(255, 39, 7, 6)
                        : Color.fromRGBO(0, 45, 42, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isWorkoutFinished ? Icons.home : Icons.fitness_center,
                          color: isWorkoutFinished
                              ? Color.fromRGBO(243, 234, 218, 1)
                              : Color.fromRGBO(54, 150, 143, 1),
                        ),
                        SizedBox(width: 8),
                        Text(
                          isWorkoutFinished ? 'Back to Home' : 'Finish workout',
                          style: GlobalVariables.fontStyle.copyWith(
                            color: Color.fromRGBO(243, 234, 218, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
