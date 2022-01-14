import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:flutter/material.dart';

class CampaignCardView extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String location;
  final String time;

  CampaignCardView({
    Key? key,
    required this.title,
    required this.imgUrl,
    required this.location,
    required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Image.asset(imgUrl,fit: BoxFit.cover,),
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
                        AppLabel(text: title,
                          widgetSize: WidgetSize.large,
                          textColor: Constants.appColorBrownRed,
                          fontWeight: FontWeight.w500,
                        ),
                        AppLabel(text: location,
                          widgetSize: WidgetSize.medium,
                          textColor: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),

                        AppLabel(text: time,
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
    );
  }
}
