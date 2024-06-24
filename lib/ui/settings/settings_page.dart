import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/user_cubit.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/account_menu/account_view.dart';
import 'package:gym_tracker_flutter/ui/settings/sub_menu/settings_menu/settings_view.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/custom_header.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/menu_switch.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: Container(
        decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              CustomHeader(),
              SizedBox(height: 8.0),
              MenuSwitch(
                tabController: _tabController,
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AccountView(),
                    SettingsView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
