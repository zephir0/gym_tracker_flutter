import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class AuthenticationButton extends StatelessWidget {
  final String buttonText;
  final formKey;
  final onButtonPressed;
  AuthenticationButton({
    required this.buttonText,
    required this.formKey,
    required this.onButtonPressed,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.07;
    var width = MediaQuery.of(context).size.width * 0.6;
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () => {
                    if (formKey.currentState.validate())
                      {
                        onButtonPressed(),
                      }
                    else
                      {print("Not Validated")}
                  },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                backgroundColor: Color.fromRGBO(43, 138, 132, 100),
                fixedSize: Size(width, height),
              ),
              child: Text(
                buttonText,
                style: GlobalVariables.fontStyle.copyWith(color: Colors.black, fontSize: 24),
              )),
        ],
      ),
    );
  }
}
