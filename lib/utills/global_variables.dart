import 'package:flutter/cupertino.dart';

class GlobalVariables {
  Color iconAndHintColor = Color.fromRGBO(167, 156, 156, 100);
  Color inputFillColor = Color.fromRGBO(81, 80, 80, 100);
  // var backendApiAddress = "http://gymtracker.cytr.us/";
  var backendApiAddress = "http://192.168.0.5:8081/";

  var primaryGradient = LinearGradient(
    colors: [Color.fromARGB(255, 48, 47, 47), Color(0xff000000)],
    stops: [0, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
