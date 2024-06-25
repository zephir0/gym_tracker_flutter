import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class RecentWorkoutsHeader extends StatefulWidget {
  @override
  _RecentWorkoutsHeaderState createState() => _RecentWorkoutsHeaderState();
}

class _RecentWorkoutsHeaderState extends State<RecentWorkoutsHeader> {
  bool _isButtonTapped = false;

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
          style: GlobalVariables.fontStyle.copyWith(color: Colors.white, fontSize: 18),
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
      onTap: _handleSeeAllButtonTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: _isButtonTapped
              ? Color.fromARGB(255, 173, 171, 171)
              : Color.fromRGBO(43, 138, 132, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "See all",
            style: GlobalVariables.fontStyle.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _handleSeeAllButtonTap() {
    setState(() {
      _isButtonTapped = true;
    });
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      setState(() {
        _isButtonTapped = false;
      });
    });
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white,
      indent: 15,
      endIndent: 15,
    );
  }
}
