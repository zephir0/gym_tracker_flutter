import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_state.dart';
class UserWelcomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: UserWelcomePanelBody(),
    );
  }
}

class UserWelcomePanelBody extends StatefulWidget {
  @override
  _UserWelcomePanelBodyState createState() => _UserWelcomePanelBodyState();
}

class _UserWelcomePanelBodyState extends State<UserWelcomePanelBody>
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
          _buildWelcomeUserText(),
          _buildUserAvatar(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeUserText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good to see you here,",
          style: GlobalVariables.fontStyle.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return CircularProgressIndicator();
            } else if (state is UserLoaded) {
              return Text(
                state.username,
                style: GlobalVariables.fontStyle.copyWith(
                  color: Color.fromRGBO(14, 233, 218, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              );
            } else {
              return Text(
                "Unknown User",
                style: GlobalVariables.fontStyle.copyWith(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  GestureDetector _buildUserAvatar(BuildContext context) {
    return GestureDetector(
      onTap: _handleAvatarTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.14,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                minRadius: 40,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleAvatarTap() async {
    await _controller.forward();
    Navigator.pushNamed(context, '/user-profile');
    _controller.reset();
  }
}
