import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final VoidCallback onBack;

  const BackButton({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onBack,
      child: Text('Back'),
    );
  }
}
