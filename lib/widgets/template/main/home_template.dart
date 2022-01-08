import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/molecules/containers/image_carousel.dart';
import 'package:donor_app/widgets/molecules/containers/menu_box_button.dart';
import 'package:donor_app/widgets/molecules/containers/request_card_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTemplate extends StatelessWidget {
  final List<Map<String,dynamic>> menuBtnData;

  HomeTemplate({
    Key? key,
    required this.menuBtnData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("home"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Constants.appColorBlack,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("notification");
              },
              icon: Icon(
                Icons.notifications,
                color: Constants.appColorBrownRed,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height * 1.5,
            ),

            ImageCarousel(imgList: [
              "assets/images/banner-1.png",
              "assets/images/banner-1.png",
              "assets/images/banner-1.png"
            ]),

            SizedBox(
              height: 16,
            ),
            GridView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics() ,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0
              ),

              children: menuBtnData.map((item) => MenuBoxButton(
                  title: item['title'],
                  color: item['color'],
                  imgUrl: item['imgUrl'],
                  clickEvent: item["clickEvent"]
              )).toList(),

            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AppHeading(text: "Latest",widgetSize: WidgetSize.small,color: Constants.appColorGray,),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RequestCardView(),
            )
          ],
        ),
      ),
    );
  }
}
