import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.settingAppBarColor,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: ColorPalette.textColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: ColorPalette.primaryThemeGradient),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading:
                  Icon(Icons.question_answer, color: ColorPalette.textColor),
              title: Text(
                'FAQ',
                style: _getTextStyle(),
              ),
              onTap: () => _navigateToFAQ(context),
            ),
            ListTile(
              leading: Icon(Icons.email, color: ColorPalette.textColor),
              title: Text(
                'Email Support',
                style: _getTextStyle(),
              ),
              onTap: () => _emailSupport(),
            ),
            ListTile(
              leading: Icon(Icons.message, color: ColorPalette.textColor),
              title: Text(
                'Live Chat Support',
                style: _getTextStyle(),
              ),
              onTap: () => _liveChatSupport(context),
            ),
            ListTile(
              leading: Icon(Icons.face, color: ColorPalette.textColor),
              title: Text(
                'Facebook Support',
                style: _getTextStyle(),
              ),
              onTap: () => _openFacebook(),
            ),
            ListTile(
              leading: Icon(Icons.support_agent, color: ColorPalette.textColor),
              title: Text(
                'Submit a Ticket',
                style: _getTextStyle(),
              ),
              onTap: () => _submitTicket(context),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(color: ColorPalette.textColor);
  }

  void _navigateToFAQ(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => _FAQPage()));
  }

  void _emailSupport() async {}

  void _liveChatSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Live Chat Support'),
        content: Text('Live chat support is not available now.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _openFacebook() async {}

  void _submitTicket(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Submit a Ticket'),
        content: Text('Ticket submission is not available now.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: ColorPalette.secondaryColor,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Question 1'),
            subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          ),
          ListTile(
            title: Text('Question 2'),
            subtitle: Text(
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
          ),
        ],
      ),
    );
  }
}
