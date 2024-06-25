import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class PaymentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.build, size: 100, color: Colors.grey),
          Text(
            'Page Under Construction',
            style: GlobalVariables.fontStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'We are working hard to bring you this feature soon!',
            style: GlobalVariables.fontStyle.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
