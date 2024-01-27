import 'package:flutter/material.dart';

class TotalWeightWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalWeight = 150.0; // Replace with your data

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('Total Weight Lifted'),
        subtitle: Text('$totalWeight kg'),
        leading: Icon(Icons.line_weight, color: Colors.orange),
      ),
    );
  }
}
