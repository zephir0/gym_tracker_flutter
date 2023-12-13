import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          ProfileOptionTile(
            icon: Icons.person,
            title: 'Change Avatar',
            onTap: () => _navigateToScreen(context, ChangeAvatarScreen()),
          ),
          ProfileOptionTile(
            icon: Icons.edit,
            title: 'Edit Username',
            onTap: () => _navigateToScreen(context, EditUsernameScreen()),
          ),
          ProfileOptionTile(
            icon: Icons.email,
            title: 'Change Email',
            onTap: () => _navigateToScreen(context, ChangeEmailScreen()),
          ),
          ProfileOptionTile(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () => _navigateToScreen(context, ChangePasswordScreen()),
          ),
          ProfileOptionTile(
            icon: Icons.delete_forever,
            title: 'Delete Account',
            onTap: () => _navigateToScreen(context, DeleteAccountScreen()),
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class ChangeAvatarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Avatar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('URL_Tutaj'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Change Avatar'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditUsernameScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Username'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'New Username'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Update Username'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeEmailScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'New Email'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Update Email'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Are you sure you want to delete your account?'),
            ElevatedButton(
              onPressed: () {},
              child: Text('Delete Account'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
