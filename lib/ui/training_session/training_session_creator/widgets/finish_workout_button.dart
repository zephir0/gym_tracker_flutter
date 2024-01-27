import 'package:flutter/material.dart';

class FinishWorkoutButton extends StatelessWidget {
  final Function() onFinishWorkout;

  const FinishWorkoutButton({
    required this.onFinishWorkout,
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
                      color: Color.fromARGB(255, 39, 7, 6)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          color: Color.fromRGBO(243, 234, 218, 1),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Finish workout',
                          style: TextStyle(
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
