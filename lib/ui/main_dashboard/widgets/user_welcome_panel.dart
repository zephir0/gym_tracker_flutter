import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/bloc/user_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWelcomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(),
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<UserCubit>(context).fetchNameFromJson();
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
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300,),
        ),
        BlocBuilder<UserCubit, String>(
          builder: (context, name) {
            if (name.isNotEmpty && name.length < 15) {
              return Text(
                name,
                style: GlobalVariables.fontStyle.copyWith(
                    color: Color.fromRGBO(14, 233, 218, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              );
            } else {
              return CircularProgressIndicator();
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
            child: CircleAvatar(
              minRadius: 40,
              backgroundImage: AssetImage('assets/images/avatar.png'),
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
