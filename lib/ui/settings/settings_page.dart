import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/user_cubit.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/account_view.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/custom_header.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/menu_switch.dart';
import 'package:gym_tracker_flutter/ui/settings/widgets/settings_view.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _tabs = [AccountView(), SettingsView()];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
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
        color: Color(0xFF2C2F3A),
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
