import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_state.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_avatar_page.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showAvatarDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                          radius: 220,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChangeAvatarPage(),
                            ));
                          },
                          child: Text(
                            'Edit',
                            style: GlobalVariables.fontStyle.copyWith(color: Colors.white, fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromRGBO(43, 138, 132, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: _showAvatarDialog,
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              radius: 70,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        state.username,
                        style: GlobalVariables.fontStyle.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "jon@wp.pl",
                        style: GlobalVariables.fontStyle.copyWith(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Loading...",
                        style: GlobalVariables.fontStyle.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      CircularProgressIndicator(),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
