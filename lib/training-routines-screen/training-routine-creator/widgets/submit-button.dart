import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const SubmitButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onSubmit,
      icon: Icon(Icons.check),
      label: Text('Submit'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
