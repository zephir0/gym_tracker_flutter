import 'package:flutter/material.dart';

class AdvancedBackButton extends StatelessWidget {
  final VoidCallback onBack;

  const AdvancedBackButton({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onBack,
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
