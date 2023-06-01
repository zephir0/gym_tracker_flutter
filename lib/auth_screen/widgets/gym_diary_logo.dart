import 'package:flutter/cupertino.dart';

class GymDiaryLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Image.asset('assets/images/app_logo.png'),
      ),
    );
  }
}
