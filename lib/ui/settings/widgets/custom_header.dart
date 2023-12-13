import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/user_cubit.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).fetchNameFromJson();

    return Container(
      color: Color(0xFF20212C),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            radius: 70,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: BlocBuilder<UserCubit, String>(
              builder: (context, string) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Jon Done",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      string,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
