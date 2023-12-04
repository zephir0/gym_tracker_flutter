import 'package:flutter/material.dart';

class ActionButtonsRowWidget extends StatelessWidget {
  final VoidCallback onOpenMiniMenu;
  final VoidCallback onOpenFilters;

  ActionButtonsRowWidget(
      {required this.onOpenMiniMenu, required this.onOpenFilters});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onOpenMiniMenu,
          child: Text('Open Mini Menu'),
        ),
        ElevatedButton(
          onPressed: onOpenFilters,
          child: Text('Open Filters'),
        ),
      ],
    );
  }
}
