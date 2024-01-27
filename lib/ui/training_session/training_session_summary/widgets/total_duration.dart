import 'package:flutter/material.dart';

class TotalDurationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(minutes: 90); // Replace with your data

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('Total Duration'),
        subtitle: Text('${duration.inMinutes} minutes'),
        leading: Icon(Icons.timer, color: Colors.orange),
      ),
    );
  }
}
