import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          "GYM DIARY",
          style: TextStyle(
            color: Colors.white,
            fontSize: 45,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
