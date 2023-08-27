import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../screens/main-dashboard/home-page.dart';
import '../screens/settings/settings-page.dart';
import '../screens/training-routine/training-routine-creator/training-routine-creator-page.dart';
import '../screens/training-routine/training-routine-page.dart';

class NavigationBottomBar extends StatefulWidget {
  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  final List<Widget> _pages = [HomePage(), SettingsPage()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildSpeedDial(),
    );
  }

  IndexedStack _buildBody() {
    return IndexedStack(
      index: _selectedIndex,
      children: _pages,
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      selectedItemColor: Color.fromRGBO(8, 243, 227, 1),
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  SpeedDial _buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(size: 22.0),
      backgroundColor: Color.fromRGBO(43, 138, 132, 1),
      curve: Curves.bounceIn,
      children: [
        _buildSpeedDialChild(
          Icons.calendar_today,
          () {
            _navigateToPage(TrainingRoutinePage());
          },
          'Create new session',
        ),
        _buildSpeedDialChild(
          Icons.fitness_center,
          () {
            _navigateToPage(TrainingRoutineCreatorPage());
          },
          'Create new routine',
        ),
      ],
    );
  }

  SpeedDialChild _buildSpeedDialChild(
    IconData icon,
    Function() onTap,
    String label,
  ) {
    return SpeedDialChild(
      child: Icon(icon, color: Colors.white),
      backgroundColor: Color.fromRGBO(43, 138, 132, 1),
      onTap: onTap,
      label: label,
      labelStyle: TextStyle(fontWeight: FontWeight.w500),
      labelBackgroundColor: Colors.white,
    );
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        opaque: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
