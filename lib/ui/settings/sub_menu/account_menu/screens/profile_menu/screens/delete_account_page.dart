import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/data/services/user_service.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';
import 'package:slide_to_act/slide_to_act.dart';

class DeleteAccountPage extends StatefulWidget {
  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.settingAppBarColor,
        title: Text('Delete Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://i.ibb.co/B49tfbz/e4dc6b29-8280-4104-93cb-4cbd3ea66382.webp'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SlideAction(
                key: _key,
                text: 'Slide to delete',
                innerColor: ColorPalette.accountDeleteSliderInnerColor,
                outerColor: ColorPalette.accountDeleteSliderOuterColor,
                sliderButtonIcon: Icon(Icons.delete_forever),
                onSubmit: () {
                  UserService().attemptDeleteAccount(context);
                  _key.currentState?.reset();
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Warning: Deleting your account will result in the loss of all your workout routines, progress data, and account history. This action is irreversible.',
              style:
                  TextStyle(fontSize: 16, color: ColorPalette.warningTextColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
