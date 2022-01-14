import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              print("notification");
            },
            icon: Icon(
              Icons.view_headline,
              color: Constants.appColorBrownRed,
            )),
        actions: [],
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Constants.appColorWhite,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.0, 0.5), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppHeading(text: "Ragama Hospital",widgetSize: WidgetSize.small,),
                            AppLabel(text: "Main road Ragama",
                              widgetSize: WidgetSize.medium,
                              textColor: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),

                            AppLabel(
                              text: "Emergency",
                              widgetSize: WidgetSize.medium,
                              textColor: Constants.appColorBrownRed,
                              fontWeight: FontWeight.w600,
                            ),
                            AppLabel(
                              text: "Today before 2.00 pm",
                              widgetSize: WidgetSize.medium,
                              textColor: Constants.appColorBrownRed,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: (){print("accepted");},
                                    child: Text("Accept")),
                                SizedBox(width: 5,),
                                ElevatedButton(
                                    onPressed: (){print("accepted");},
                                    child: Text("Share"))
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Constants.appColorBrownRed,
                    ),
                    child: AppHeading(
                      text: "A+",
                      widgetSize: WidgetSize.large,
                      color: Constants.appColorWhite,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
