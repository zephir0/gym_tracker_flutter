import 'package:flutter/cupertino.dart';

class GlobalVariables {
  Color iconAndHintColor = Color.fromRGBO(167, 156, 156, 100);
  Color inputFillColor = Color.fromRGBO(81, 80, 80, 100);
  // var backendApiAddress = "http://gymtracker.cytr.us/";
  var backendApiAddress = "http://192.168.0.5:8081/";

  var primaryGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 18, 18, 18),
      Color.fromARGB(255, 38, 38, 38),
      Color.fromARGB(255, 58, 58, 58),
      Color.fromARGB(255, 38, 38, 38),
      Color.fromARGB(255, 18, 18, 18),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
