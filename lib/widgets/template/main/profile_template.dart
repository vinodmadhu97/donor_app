import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:donor_app/widgets/molecules/containers/show_profile_avatar.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';

class ProfileTemplate extends StatelessWidget {
  const ProfileTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
        title: Text("Profile"),
        curvedBodyRadius: 0,
        headerExpandedHeight: 0.06,
        fullyStretchable: true,

        headerWidget: AppBar(title: Text("Profile"),centerTitle: true,),
        body: _buildBody()
    );
  }
  List<Widget> _buildBody(){
      return [
        SizedBox(height: 10,),
        ShowProfileAvatar(),
        AppHeading(text: "Vinod Madhushan", color: Constants.appColorBlack.withOpacity(0.5),),
        AppLabel(text: "Moroththa, Madahapola" , widgetSize: WidgetSize.large,textColor: Constants.appColorGray,),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    AppHeading(text: "A+", widgetSize: WidgetSize.medium,color: Constants.appColorBrownRed,),
                    AppLabel(text: "Blood group", widgetSize: WidgetSize.medium,textColor: Constants.appColorGray,)
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    AppHeading(text: "Active", widgetSize: WidgetSize.medium,color: Constants.appColorBrownRed,),
                    AppLabel(text: "Status", widgetSize: WidgetSize.medium,textColor: Constants.appColorGray)
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    AppHeading(text: "04", widgetSize: WidgetSize.medium,color: Constants.appColorBrownRed,),
                    AppLabel(text: "Donations", widgetSize: WidgetSize.medium,textColor: Constants.appColorGray)
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        AppHeading(text: "To Next Donation",widgetSize: WidgetSize.small,),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  AppHeading(text: "02",widgetSize: WidgetSize.medium,),
                  AppHeading(text: "Mon",widgetSize: WidgetSize.small)
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Constants.appColorBrownRed.withOpacity(0.3),
              ),
            ),
            SizedBox(width: 20,),
            Container(
              width: 100,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  AppHeading(text: "21",widgetSize: WidgetSize.medium,),
                  AppHeading(text: "Days",widgetSize: WidgetSize.small)
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Constants.appColorBrownRed.withOpacity(0.3),
              ),
            ),

          ],
        ),
        SizedBox(height: 20,),
        AppHeading(text: "History",widgetSize: WidgetSize.small,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 16),
          child: Card(
              elevation: 5,
              //shadowColor: Colors.red,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
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
                        child: Image.asset("assets/images/blood_drop.png",fit: BoxFit.cover,),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppLabel(text: "Apeksha Hospital",
                                widgetSize: WidgetSize.large,
                                textColor: Constants.appColorBrownRed,
                                fontWeight: FontWeight.w500,
                              ),
                              AppLabel(text: "Maharagama",
                                widgetSize: WidgetSize.medium,
                                textColor: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),

                              AppLabel(text: "MOH 006085",
                                widgetSize: WidgetSize.medium,
                                textColor: Constants.appColorBlack,
                                fontWeight: FontWeight.w600,
                              ),

                              AppLabel(text: "2022/01/18",
                                widgetSize: WidgetSize.medium,
                                textColor: Constants.appColorBlack,
                                fontWeight: FontWeight.w600,
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        )
      ];
  }


}
