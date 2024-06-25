import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_event.dart';

class ChangeUsernamePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 25, 25, 0.612),
        title: Text('Edit Username', style: GlobalVariables.fontStyle.copyWith(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Image.network('https://i.ibb.co/mbMcFv0/1282e020-795e-4d9c-b4b4-d16db236a516.webp'),
                SizedBox(height: 15),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'New Username',
                    labelStyle: GlobalVariables.fontStyle.copyWith(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: GlobalVariables.fontStyle.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(43, 138, 132, 1),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    context.read<UserBloc>().add(UpdateUsername(newUsername: _usernameController.text));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Update Username',
                      style: GlobalVariables.fontStyle.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
