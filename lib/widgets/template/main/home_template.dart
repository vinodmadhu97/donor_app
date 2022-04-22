import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/molecules/containers/app_drawer.dart';
import 'package:donor_app/widgets/molecules/containers/campaign_card_view.dart';
import 'package:donor_app/widgets/molecules/containers/image_carousel.dart';
import 'package:donor_app/widgets/molecules/containers/menu_box_button.dart';
import 'package:donor_app/widgets/molecules/containers/no_data_card_view.dart';
import 'package:donor_app/widgets/shimmers/home_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../molecules/containers/request_card_view.dart';

class HomeTemplate extends StatelessWidget {
  final List<Map<String, dynamic>> menuBtnData;
  HomeTemplate({Key? key, required this.menuBtnData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //FirebaseAuth.instance.signOut();
    return Scaffold(
      /*extendBodyBehindAppBar: true,*/
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("home".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FutureBuilder(
            future: Future.wait([
              FirebaseServices().getPosters(),
              FirebaseServices().getLatestCampaign(),
              FirebaseServices().getLatestRequest()
            ]),
            builder: (context,
                AsyncSnapshot<List<QuerySnapshot<Map<String, dynamic>>>>
                    snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const HomeShimmer();
              }
              List<dynamic> posterUrls = snapshot.data![0].docs
                  .map((element) => element['url'])
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppBar().preferredSize.height * 0.8,
                  ),
                  snapshot.data![0].docs.length == 0
                      ? ImageCarousel(imgList: [
                          "http://www.nbts.health.gov.lk/images/nbts_slider/slider1.jpg"
                        ])
                      : ImageCarousel(imgList: posterUrls),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: menuBtnData
                        .map((item) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                      text: "latest camps".tr,
                      widgetSize: WidgetSize.small,
                      color: Constants.appColorGray,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: snapshot.data![1].docs.length == 0
                        ? NoDataCardView(title: "no available campaigns".tr)
                        : CampaignCardView(
                            title: snapshot.data![1].docs[0]['location'],
                            imgUrl: snapshot.data![1].docs[0]['url'],
                            location: snapshot.data![1].docs[0]['address'],
                            time:
                                "${snapshot.data![1].docs[0]['startDate']} \nat ${snapshot.data![1].docs[0]['startTime']} - ${snapshot.data![1].docs[0]['endTime']}",
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: AppHeading(
                      text: "latest requests".tr,
                      widgetSize: WidgetSize.small,
                      color: Constants.appColorGray,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: snapshot.data![2].docs.length == 0
                        ? NoDataCardView(title: "no available requests".tr)
                        : RequestCardView(
                            bloodGroup: snapshot.data![2].docs[0]['bloodGroup'],
                            endTime:
                                snapshot.data![2].docs[0]['endTime'].toString(),
                            address: snapshot.data![2].docs[0]['address'],
                            title: snapshot.data![2].docs[0]['location'],
                            startDate: snapshot.data![2].docs[0]['startDate'],
                            startTime: snapshot.data![2].docs[0]['startTime']
                                .toString(),
                          ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              );
            }),
      ),
    );
  }
}
