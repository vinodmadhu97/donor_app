import 'package:donor_app/screens/main/profile_screen.dart';
import 'package:donor_app/screens/main/setting_screen.dart';
import 'package:donor_app/widgets/template/main/dash_board_template.dart';
import 'package:flutter/material.dart';
class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashBoardTemplate(
        navigationData: [
          {
            'navIcon' : Icons.person,
            'navTitle': 'Home',
            'navScreen' : ProfileScreen()
          },
          {
            'navIcon' : Icons.admin_panel_settings_rounded,
            'navTitle': 'Favorite',
            'navScreen' : SettingScreen()
          },
        ]
    );
  }
}
