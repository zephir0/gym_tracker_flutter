import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialIconsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          'assets/images/twitter.png',
          'assets/images/fb.png',
          'assets/images/google.png'
        ]
            .map((path) => Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: GestureDetector(
                    onTap: () => print(path),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset(path),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
