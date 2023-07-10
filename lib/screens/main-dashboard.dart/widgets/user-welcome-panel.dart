import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/user-bloc.dart';

class UserWelcomePanel extends StatefulWidget {
  @override
  _UserWelcomePanelState createState() => _UserWelcomePanelState();
}

class _UserWelcomePanelState extends State<UserWelcomePanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    userBloc = Provider.of<UserBloc>(context, listen: false);
    userBloc.fetchNameFromJson();
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

  Column welcomeUserText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good to see you here,",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
        ),
        StreamBuilder<String>(
          stream: userBloc.name,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!,
                style: TextStyle(
                    color: Color.fromRGBO(14, 233, 218, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              );
            } else if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
                style: TextStyle(color: Colors.red),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ],
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
}
