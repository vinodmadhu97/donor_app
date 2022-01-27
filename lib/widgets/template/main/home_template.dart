import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:donor_app/widgets/molecules/containers/app_drawer.dart';
import 'package:donor_app/widgets/molecules/containers/campaign_card_view.dart';
import 'package:donor_app/widgets/molecules/containers/image_carousel.dart';
import 'package:donor_app/widgets/molecules/containers/menu_box_button.dart';
import 'package:donor_app/widgets/molecules/containers/request_card_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTemplate extends StatelessWidget {
  final List<Map<String, dynamic>> menuBtnData;

  HomeTemplate({Key? key, required this.menuBtnData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*extendBodyBehindAppBar: true,*/
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height * 0.8,
            ),
            ImageCarousel(imgList: [
              "assets/images/poster-1.jpg",
              "assets/images/poster-2.jpg",
              "assets/images/poster-3.jpg",
              "assets/images/poster-4.jpg"
            ]),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuBtnData
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: MenuBoxButton(
                            title: item['title'],
                            color: item['color'],
                            imgUrl: item['imgUrl'],
                            clickEvent: item["clickEvent"]),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AppHeading(
                text: "Latest Campaign",
                widgetSize: WidgetSize.small,
                color: Constants.appColorGray,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CampaignCardView(
                title: "Kalubowila Hospital",
                imgUrl: "assets/images/campaign-1.jpg",
                location: "B229 Hospital Rd, Dehiwala-Mount Lavinia",
                time: "2022/02/04 \nat 8.00 am - 2.00 pm",
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AppHeading(
                text: "Latest Request",
                widgetSize: WidgetSize.small,
                color: Constants.appColorGray,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RequestCardView(),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}


