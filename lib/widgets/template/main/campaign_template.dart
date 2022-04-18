import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/molecules/containers/campaign_card_view.dart';
import 'package:donor_app/widgets/shimmers/campaign_shimmer.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../const/constants.dart';

class CampaignTemplate extends StatelessWidget {
  const CampaignTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          FirebaseServices().getLatestCampaign(),
          FirebaseServices().getCampaignPromotions(),
        ]), //FirebaseServices().getCampaignPromotions(),
        builder: (context,
            AsyncSnapshot<List<QuerySnapshot<Map<String, dynamic>>>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CampaignShimmer();
          }
          return snapshot.data![0].docs.length == 0
              ? Scaffold(
                  appBar: AppBar(
                    title: Text("Campaigns"),
                  ),
                  body: Center(
                      child: AppHeading(
                    text: "No Available Campaigns",
                    widgetSize: WidgetSize.small,
                    color: Constants.appColorGray,
                  )),
                )
              : DraggableHome(
                  title: Text("Campaigns"),
                  curvedBodyRadius: 0,
                  headerExpandedHeight: 0.3,
                  fullyStretchable: false,
                  headerWidget:
                      _buildHeader(context, snapshot.data![0].docs[0]['url']),
                  body: _buildBody(snapshot.data![1].docs));
        });
  }

  Widget _buildHeader(BuildContext context, String url) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 40),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        //color: Colors.grey,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (ctx, url) => SpinKitCircle(
              color: Constants.appColorBrownRed,
            ),
            errorWidget: (ctx, url, error) =>
                Image.asset("assets/images/img_place_holder.png"),
          ),
        ),

        //child: Image.asset(url,fit: BoxFit.cover,),
      ),
    );
  }

  List<Widget> _buildBody(List<QueryDocumentSnapshot<Object?>> snapshot) {
    return [
      ListView.builder(
        itemCount: snapshot.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: CampaignCardView(
            title: snapshot[index]['location'],
            imgUrl: snapshot[index]['url'],
            location: snapshot[index]['address'],
            time:
                "${snapshot[index]['startDate']} \nat ${snapshot[index]['startTime']}.00 - ${snapshot[index]['endTime']}.00",
          ),
        ),
      )
    ];
  }
}
