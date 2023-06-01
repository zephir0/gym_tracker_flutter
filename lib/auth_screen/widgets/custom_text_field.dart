import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;

  CustomTextField(
      {required this.hintText, required this.controller, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Icon(
              icon,
              size: 32,
              color: GlobalVariables().iconAndHintColor,
            ),
          ),
          fillColor: GlobalVariables().inputFillColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: GlobalVariables().iconAndHintColor,
          ),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
