import 'package:flutter/material.dart';

class WorkoutCount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkoutCountState();
}

class _WorkoutCountState extends State<WorkoutCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(43, 138, 132, 1),
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
          child: Column(children: [
            Column(
              children: [
                Text(
                  "Workout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text("Count",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("41",
                  style: TextStyle(
                      color: Color.fromRGBO(43, 238, 225, 1),
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
            )
          ]),
        ));
  }
}
