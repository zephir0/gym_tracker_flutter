import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Color.fromRGBO(80, 207, 199, 0.612),
              minimumSize: Size(double.infinity, 50),
              foregroundColor: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/navi-bar', (Route<dynamic> route) => false);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home),
              SizedBox(width: 8),
              Text(
                'Back to Home',
                style: GlobalVariables.fontStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
