import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/widgets/shimmers/history_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../const/constants.dart';
import '../../../const/widget_size.dart';
import '../../../services/firebase_services.dart';
import '../../atoms/app_heading.dart';
import '../../atoms/app_label.dart';

class HistoryTemplate extends StatelessWidget {
  const HistoryTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("history".tr),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: FirebaseServices()
                .getDonorHistory(FirebaseAuth.instance.currentUser!.uid),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return HistoryShimmer();
              }
              return snapshot.data?.docs.length == 0
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/anim/no_data_anim.json',
                              width: 200, height: 100),
                          AppHeading(
                            text: "no available history".tr,
                            widgetSize: WidgetSize.small,
                            color: Constants.appColorGray,
                          )
                        ],
                      )),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        //color: Colors.red,
                                        child: Image.asset(
                                          "assets/images/blood_drop.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              AppLabel(
                                                text: snapshot.data?.docs[index]
                                                    ["location"],
                                                widgetSize: WidgetSize.large,
                                                textColor:
                                                    Constants.appColorBrownRed,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              AppLabel(
                                                text: snapshot.data?.docs[index]
                                                    ["barcode"],
                                                widgetSize: WidgetSize.medium,
                                                textColor:
                                                    Constants.appColorBlack,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              AppLabel(
                                                text: snapshot.data?.docs[index]
                                                    ["date"],
                                                widgetSize: WidgetSize.medium,
                                                textColor:
                                                    Constants.appColorBlack,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        );
                      });
            }),
      ),
    );
  }
}
