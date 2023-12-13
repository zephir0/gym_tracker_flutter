import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(43, 138, 132, 1),
        title: Text('Help & Support', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.question_answer,
                  color: Color.fromRGBO(43, 138, 132, 1)),
              title: Text('FAQ'),
              onTap: () => _navigateToFAQ(context),
            ),
            ListTile(
              leading:
                  Icon(Icons.email, color: Color.fromRGBO(43, 138, 132, 1)),
              title: Text('Email Support'),
              onTap: () => _emailSupport(),
            ),
            ListTile(
              leading:
                  Icon(Icons.message, color: Color.fromRGBO(43, 138, 132, 1)),
              title: Text('Live Chat Support'),
              onTap: () => _liveChatSupport(context),
            ),
            ListTile(
              leading: Icon(Icons.face, color: Color.fromRGBO(43, 138, 132, 1)),
              title: Text('Facebook Support'),
              onTap: () => _openFacebook(),
            ),
            ListTile(
              leading: Icon(Icons.support_agent,
                  color: Color.fromRGBO(43, 138, 132, 1)),
              title: Text('Submit a Ticket'),
              onTap: () => _submitTicket(context),
            ),
          ],
        ),
      ),
    );
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
        backgroundColor: Color.fromRGBO(43, 138, 132, 1),
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
