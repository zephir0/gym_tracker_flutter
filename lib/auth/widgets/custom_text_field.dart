import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool isPasswordField;

  CustomTextField(
      {required this.hintText,
      required this.controller,
      required this.icon,
      required this.isPasswordField});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color.fromRGBO(207, 209, 209, 0.612),
        ),
        obscureText: widget.isPasswordField ? _obscureText : false,
        validator: _validate,
        decoration: _getInputDecoration(),
      ),
    );
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Icon(
          widget.icon,
          size: 32,
          color: GlobalVariables().iconAndHintColor,
        ),
      ),
      suffixIcon: widget.isPasswordField
          ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: _toggleObscureText,
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: GlobalVariables().iconAndHintColor,
                ),
              ),
            )
          : null,
      fillColor: GlobalVariables().inputFillColor,
      filled: true,
      hintText: widget.hintText,
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
    );
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
