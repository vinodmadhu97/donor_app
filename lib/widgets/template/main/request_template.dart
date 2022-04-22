import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/molecules/containers/request_card_view.dart';
import 'package:donor_app/widgets/shimmers/requests_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RequestTemplate extends StatelessWidget {
  const RequestTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("requests".tr),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.sort))],
      ),
      body: FutureBuilder(
          future: FirebaseServices().getDonationRequests(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const RequestShimmer();
            }
            return snapshot.data!.docs.length == 0
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/anim/no_data_anim.json',
                          width: 200, height: 100),
                      AppHeading(
                        text: "no available requests".tr,
                        widgetSize: WidgetSize.small,
                        color: Constants.appColorGray,
                      )
                    ],
                  ))
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: RequestCardView(
                          title: snapshot.data!.docs[index]['location'],
                          address: snapshot.data!.docs[index]['address'],
                          bloodGroup: snapshot.data!.docs[index]['bloodGroup'],
                          startDate: snapshot.data!.docs[index]['startDate'],
                          startTime: snapshot.data!.docs[index]['startTime']
                              .toString(),
                          endTime:
                              snapshot.data!.docs[index]['endTime'].toString(),
                        ),
                      );
                    });
          }),
    );
  }
}
