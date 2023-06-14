import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_tracker_flutter/home-screen.dart/home-screen.dart';

import '../setting-screen/setting-screen.dart';

class NavigationBottomBar extends StatefulWidget {
  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  final List<Widget> _pages = [HomeScreen(), SettingScreen()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // if (index == 1) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // } else {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
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
          ),
          Positioned(
            bottom:
                30, // you can adjust this value as per your requirement to move the FAB
            left: MediaQuery.of(context).size.width / 2 -
                28, // this will place the FAB at the center of the screen, adjust the value 28 to move the FAB along the x-axis
            child: SpeedDial(
              // icon: Icons.add,
              animatedIcon: AnimatedIcons.add_event,
              animatedIconTheme: IconThemeData(size: 22.0),
              backgroundColor: Color.fromRGBO(43, 138, 132, 1),
              visible: true,
              curve: Curves.bounceIn,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.calendar_today, color: Colors.white),
                  backgroundColor: Color.fromRGBO(43, 138, 132, 1),
                  onTap: () {},
                  label: 'Create new session',
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.white,
                ),
                SpeedDialChild(
                  child: Icon(Icons.fitness_center, color: Colors.white),
                  backgroundColor: Color.fromRGBO(43, 138, 132, 1),
                  onTap: () {},
                  label: 'Create new routine',
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
