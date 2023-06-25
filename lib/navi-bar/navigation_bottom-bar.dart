import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_tracker_flutter/main-dashboard.dart/home-page.dart';
import 'package:gym_tracker_flutter/training-routine/training-routine-creator/training-routine-creator-page.dart';
import 'package:gym_tracker_flutter/training-routine/training-routine-page.dart';

import '../settings/settings-page.dart';

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
            bottom: 30,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: SpeedDial(
              animatedIcon: AnimatedIcons.add_event,
              animatedIconTheme: IconThemeData(size: 22.0),
              backgroundColor: Color.fromRGBO(43, 138, 132, 1),
              visible: true,
              curve: Curves.bounceIn,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.calendar_today, color: Colors.white),
                  backgroundColor: Color.fromRGBO(43, 138, 132, 1),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            TrainingRoutinePage(),
                        opaque: false,
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  label: 'Create new session',
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.white,
                ),
                SpeedDialChild(
                  child: Icon(Icons.fitness_center, color: Colors.white),
                  backgroundColor: Color.fromRGBO(43, 138, 132, 1),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            TrainingRoutineCreatorPage(),
                        opaque: false,
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
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
