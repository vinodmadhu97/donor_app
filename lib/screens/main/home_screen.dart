import 'package:donor_app/const/constants.dart';
import 'package:donor_app/screens/main/BMI_calculation_screen.dart';
import 'package:donor_app/screens/main/history_screen.dart';
import 'package:donor_app/widgets/template/main/home_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      menuBtnData: [
        /*{
          "title": "Donate",
          "color": Constants.appColorWhite,
          "imgUrl": "assets/icons/home-menu-1.png",
          "clickEvent": () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => DonationQRScreen()));
          }
        },*/
        {
          "title": "history".tr,
          "color": Constants.appColorWhite,
          "imgUrl": "assets/icons/home-menu-5.png",
          "clickEvent": () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => HistoryScreen()));
          }
        },
        {
          "title": "bmi".tr,
          "color": Constants.appColorWhite,
          "imgUrl": "assets/icons/home-menu-6.png",
          "clickEvent": () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => BMICalculationScreen()));
          }
        },
      ],
    );
  }
}
