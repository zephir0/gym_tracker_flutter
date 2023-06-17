import 'package:flutter/material.dart';

class BackToHomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50.0,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(51, 231, 219, 0.612),
                Color.fromRGBO(9, 209, 196, 0.612),
                Color.fromRGBO(9, 209, 196, 0.612),
                Color.fromRGBO(51, 231, 219, 0.612)
              ],
            ),
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
