import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentWorkoutsHeader extends StatefulWidget {
  @override
  _RecentWorkoutsHeaderState createState() => _RecentWorkoutsHeaderState();
}

class _RecentWorkoutsHeaderState extends State<RecentWorkoutsHeader> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _buildTitleRow(),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Your last workouts",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 10, 0),
          child: _buildSeeAllButton(),
        ),
      ],
    );
  }

  Widget _buildSeeAllButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tapped = true;
        });
        Future.delayed(Duration(milliseconds: 200)).then((_) {
          setState(() {
            _tapped = false;
          });
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: _tapped
              ? Color.fromARGB(255, 173, 171, 171)
              : Color.fromRGBO(43, 138, 132, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "See all",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white,
      indent: 15,
      endIndent: 15,
    );
  }
}
