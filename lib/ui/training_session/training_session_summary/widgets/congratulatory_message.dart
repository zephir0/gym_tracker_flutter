import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CongratulatoryMessageWidget extends StatefulWidget {
  @override
  _CongratulatoryMessageWidgetState createState() =>
      _CongratulatoryMessageWidgetState();
}

class _CongratulatoryMessageWidgetState
    extends State<CongratulatoryMessageWidget> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: Duration(seconds: 1));
    _controller.play();

    Timer(Duration(seconds: 5), () {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controller,
        blastDirectionality: BlastDirectionality.explosive,
      ),
    );
  }
}
