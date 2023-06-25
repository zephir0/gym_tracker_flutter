import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            Icons.error,
            color: Colors.red,
            size: 30,
          ),
          backgroundColor: Color.fromARGB(255, 48, 47, 47),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          title: Center(
              child: Text(
            message,
            style: TextStyle(color: Colors.white),
          )),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color.fromRGBO(43, 138, 132, 100)),
              child: Text('RETRY'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
