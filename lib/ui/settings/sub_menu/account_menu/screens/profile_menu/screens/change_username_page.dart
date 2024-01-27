import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/data/services/user_service.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class ChangeUsernamePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.settingAppBarColor,
        title: Text('Edit Username',
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
                    'https://i.ibb.co/mbMcFv0/1282e020-795e-4d9c-b4b4-d16db236a516.webp'),
                SizedBox(height: 15),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'New Username',
                    labelStyle: TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.textColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.textColor),
                    ),
                  ),
                  style: TextStyle(color: ColorPalette.textColor),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.secondaryColor,
                    foregroundColor: ColorPalette.textColor,
                  ),
                  onPressed: () {
                    UserService().attemptChangeUsername(
                        _usernameController.text, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Update Username',
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
