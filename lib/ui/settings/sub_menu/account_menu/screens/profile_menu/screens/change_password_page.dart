import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/data/services/user_service.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.settingAppBarColor,
        title: Text('Change Password',
            style: TextStyle(color: ColorPalette.textColor)),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: ColorPalette.primaryThemeGradient),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Image.network(
                    'https://i.ibb.co/kH0PWRL/3f9a0405-03ff-45fc-b4a9-6bd3d49307b2.webp'),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Old Password',
                    labelStyle: TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.textColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.textColor),
                    ),
                  ),
                  style: TextStyle(color: ColorPalette.textColor),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.textColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.textColor),
                    ),
                  ),
                  style: TextStyle(color: ColorPalette.textColor),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.secondaryColor,
                    foregroundColor: ColorPalette.textColor,
                  ),
                  onPressed: () {
                    UserService().attemptChangePassword(
                        _oldPasswordController.text,
                        _newPasswordController.text,
                        context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Update Password',
                      style: TextStyle(fontSize: 20),
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
