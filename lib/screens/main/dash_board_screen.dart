import 'package:donor_app/screens/main/campaigns_screen.dart';
import 'package:donor_app/screens/main/home_screen.dart';
import 'package:donor_app/screens/main/profile_screen.dart';
import 'package:donor_app/screens/main/requests_screen.dart';
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
            'navIcon' : Icons.home,
            'navTitle': 'Home',
            'navScreen' : HomeScreen()
          },
          {
            'navIcon' : Icons.call_received_sharp,
            'navTitle': 'Requests',
            'navScreen' : RequestScreen()
          },
          {
            'navIcon' : Icons.airline_seat_flat_angled_sharp,
            'navTitle': 'Campaigns',
            'navScreen' : CampaignsScreen()
          },
          {
            'navIcon' : Icons.person,
            'navTitle': 'Profile',
            'navScreen' : ProfileScreen()
          },
        ]
    );
  }
}
