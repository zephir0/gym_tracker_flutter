import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalVariables {
  Color iconAndHintColor = Color.fromRGBO(167, 156, 156, 100);
  Color inputFillColor = Color.fromRGBO(81, 80, 80, 100);
  var primaryGradient= LinearGradient(
          colors: [
            Color.fromRGBO(43, 138, 132, 0.9),
            Color.fromRGBO(43, 42, 42, 1),   
            Color.fromRGBO(31, 30, 30, 1),   
            Color.fromRGBO(29, 29, 29, 1),   
          ],
          stops: [0.0, 0.6, 0.8, 1.0], 
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
        );
static TextStyle fontStyle =  GoogleFonts.montserrat();
}
