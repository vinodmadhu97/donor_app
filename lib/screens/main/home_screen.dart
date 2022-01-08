import 'package:donor_app/const/constants.dart';
import 'package:donor_app/widgets/template/main/home_template.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      menuBtnData: [

        {
          "title": "Donate",
          "color": Constants.appColorGray,
          "imgUrl": "assets/icons/home-menu-1.png",
          "clickEvent": (){print("donate");}
        },
        {
          "title": "Records",
          "color": Constants.appColorGray,
          "imgUrl": "assets/icons/home-menu-2.png",
          "clickEvent": (){print("records");}
        },
        {
          "title": "Requests",
          "color": Constants.appColorGray,
          "imgUrl": "assets/icons/home-menu-3.png",
          "clickEvent": (){print("Requests");}
        },
        {
          "title": "Campaigns",
          "color": Constants.appColorGray,
          "imgUrl": "assets/icons/home-menu-4.png",
          "clickEvent": (){print("Campaigns");}
        },
        {
          "title": "Locations",
          "color": Constants.appColorGray,
          "imgUrl": "assets/icons/home-menu-5.png",
          "clickEvent": (){print("locations");}
        },
        {
          "title": "BMI",
          "color": Constants.appColorGray,
          "imgUrl": "assets/icons/home-menu-6.png",
          "clickEvent": (){print("BMI");}
        },

      ],
    );
  }
}
