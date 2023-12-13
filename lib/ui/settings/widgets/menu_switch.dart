import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/menu_button.dart';

class MenuSwitch extends StatelessWidget {
  final TabController tabController;

  const MenuSwitch({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Color.fromARGB(255, 55, 56, 66),
      child: ValueListenableBuilder(
        valueListenable: tabController.animation!,
        builder: (context, _, __) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuButton(
              title: 'Account',
              isActive: tabController.index == 0,
              onTap: () {
                tabController.animateTo(0);
              },
            ),
            MenuButton(
              title: 'Settings',
              isActive: tabController.index == 1,
              onTap: () {
                tabController.animateTo(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
