import 'package:flutter/material.dart';

class UserWelcomePanel extends StatefulWidget {
  @override
  _UserWelcomePanelState createState() => _UserWelcomePanelState();
}

class _UserWelcomePanelState extends State<UserWelcomePanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          welcomeUserText(),
          userAvatar(context),
        ],
      ),
    );
  }

  GestureDetector userAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _controller.forward();
        Navigator.pushNamed(context, '/user-profile');
        _controller.reset();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.14,
            child: CircleAvatar(
              minRadius: 40,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          );
        },
      ),
    );
  }

  Column welcomeUserText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good to see you here,",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
        ),
        Text(
          "Krystian Zajac",
          style: TextStyle(
              color: Color.fromRGBO(14, 233, 218, 1),
              fontSize: 30,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
