import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final Duration duration;

  const MenuButton({
    required this.title,
    required this.isActive,
    required this.onTap,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color:
                isActive ? Color.fromRGBO(43, 138, 132, 1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GlobalVariables.fontStyle.copyWith(
                fontSize: 21,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
