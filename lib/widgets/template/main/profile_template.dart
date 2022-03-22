import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:donor_app/widgets/molecules/containers/show_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class ProfileTemplate extends StatefulWidget {
  const ProfileTemplate({Key? key}) : super(key: key);

  @override
  State<ProfileTemplate> createState() => _ProfileTemplateState();
}

class _ProfileTemplateState extends State<ProfileTemplate> {
  var isDonated = false;

  void onEnd() {
    isDonated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder(
                future: FirebaseServices()
                    .getDonorData(FirebaseAuth.instance.currentUser!.uid),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  var date = snapshot.data!['nextDonationDate'];
                  var parsedDate =
                      date.isEmpty ? DateTime.now() : DateTime.parse(date);
                  CountdownTimerController controller =
                      CountdownTimerController(
                          endTime: parsedDate.millisecondsSinceEpoch,
                          onEnd: onEnd);

                  /*int endTime = DateTime.now().millisecondsSinceEpoch +
                      Duration(seconds: 5).inMilliseconds;

                  CountdownTimerController newcontroller =
                      CountdownTimerController(endTime: endTime, onEnd: onEnd);*/

                  return Column(
                    children: [
                      ShowProfileAvatar(
                        imagePath: snapshot.data!['profileUrl'],
                      ),
                      AppHeading(
                        text: snapshot.data!['fullName'],
                        color: Constants.appColorBlack.withOpacity(0.5),
                        widgetSize: WidgetSize.medium,
                      ),
                      AppLabel(
                        text: snapshot.data!['address'],
                        widgetSize: WidgetSize.medium,
                        textColor: Constants.appColorGray,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Constants.appColorGray,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  AppHeading(
                                    text:
                                        snapshot.data!['bloodGroup'].isNotEmpty
                                            ? snapshot.data!['bloodGroup']
                                            : "N/A",
                                    widgetSize: WidgetSize.medium,
                                    color: Constants.appColorBrownRed,
                                  ),
                                  AppLabel(
                                    text: "Blood group",
                                    widgetSize: WidgetSize.medium,
                                    textColor: Constants.appColorGray,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  AppHeading(
                                    text: snapshot.data!['numberOfDonation'],
                                    widgetSize: WidgetSize.medium,
                                    color: Constants.appColorBrownRed,
                                  ),
                                  AppLabel(
                                      text: "Donations",
                                      widgetSize: WidgetSize.medium,
                                      textColor: Constants.appColorGray)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Constants.appColorGray,
                          thickness: 1,
                        ),
                      ),
                      AppHeading(
                        text: "Next Donation",
                        widgetSize: WidgetSize.small,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Constants.appColorBrownRed),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          snapshot.data!['nextDonationDate'],
                          style: TextStyle(color: Constants.appColorBrownRed),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CountdownTimer(
                        controller: controller,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return AppHeading(
                              text: "Donate Now",
                              widgetSize: WidgetSize.small,
                              color: Constants.appColorBrownRed,
                            );
                          }

                          int days = 0;
                          int hours = 0;

                          if (time.days != null) {
                            days = time.days!;
                          }
                          if (time.hours != null) {
                            hours = time.hours!;
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    AppHeading(
                                      text: "$days",
                                      widgetSize: WidgetSize.medium,
                                    ),
                                    AppHeading(
                                        text: "Days",
                                        widgetSize: WidgetSize.small)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Constants.appColorBrownRed
                                      .withOpacity(0.3),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 100,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    AppHeading(
                                      text: "$hours",
                                      widgetSize: WidgetSize.medium,
                                    ),
                                    AppHeading(
                                        text: "Hours",
                                        widgetSize: WidgetSize.small)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Constants.appColorBrownRed
                                      .withOpacity(0.3),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Constants.appColorGray,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppHeading(
                  text: "History",
                  widgetSize: WidgetSize.small,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: FutureBuilder(
                  future: FirebaseServices()
                      .getDonorHistory(FirebaseAuth.instance.currentUser!.uid),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
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
                              ));
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
