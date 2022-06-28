import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/custom_dialog_box.dart';
import 'package:donor_app/const/custom_snack_bar.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../screens/main/donation_qr_screen.dart';

class DashBoardTemplate extends StatefulWidget {
  final List<Map<String, dynamic>> navigationData;
  DashBoardTemplate({
    Key? key,
    required this.navigationData,
  }) : super(key: key);

  @override
  _DashBoardTemplateState createState() =>
      _DashBoardTemplateState(navigationData);
}

class _DashBoardTemplateState extends State<DashBoardTemplate>
    with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  final List<Map<String, dynamic>> navigationData;

  _DashBoardTemplateState(this.navigationData);

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Color(0xff373A36), //system navigation color
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
  }

  @override
  Widget build(BuildContext context) {
    //bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      body: NavigationScreen(
        navigationData[_bottomNavIndex]['navScreen'],
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: Constants.appColorBrownRed,
          child: Icon(
            Icons.qr_code,
            color: Constants.appColorWhite,
          ),
          onPressed: () async {
            CustomDialogBox.buildDialogBox();
            DocumentSnapshot doc = await FirebaseServices()
                .getDonorData(FirebaseAuth.instance.currentUser!.uid);
            Get.back();
            if (doc['isDonated']) {
              CustomSnackBar.buildSnackBar(
                  title: "error".tr, message: "allowDonation".tr);
            } else {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => DonationQRScreen()));
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: navigationData.length,
        tabBuilder: (int index, bool isActive) {
          final color =
              isActive ? Constants.appColorBrownRed : Constants.appColorGray;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                navigationData[index]['navIcon'],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  navigationData[index]['navTitle'],
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: Constants.appColorWhite,
        activeIndex: _bottomNavIndex,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final Widget screen;

  NavigationScreen(this.screen) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.screen;
  }
}
