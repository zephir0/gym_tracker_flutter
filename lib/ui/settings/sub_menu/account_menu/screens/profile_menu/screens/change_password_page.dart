import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/user/user_event.dart';


class ChangePasswordPage extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 25, 25, 0.612),
        title: Text('Change Password', style: GlobalVariables.fontStyle.copyWith(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Image.network('https://i.ibb.co/kH0PWRL/3f9a0405-03ff-45fc-b4a9-6bd3d49307b2.webp'),
                SizedBox(height: 15),
                TextField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Old Password',
                    labelStyle: GlobalVariables.fontStyle.copyWith(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: GlobalVariables.fontStyle.copyWith(color: Colors.white),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: GlobalVariables.fontStyle.copyWith(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: GlobalVariables.fontStyle.copyWith(color: Colors.white),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(43, 138, 132, 1),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    context.read<UserBloc>().add(UpdatePassword(
                     oldPassword:  _oldPasswordController.text,
                    newPassword: _newPasswordController.text,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Update Password',
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
