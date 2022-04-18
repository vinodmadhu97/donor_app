import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:flutter/material.dart';

class RequestCardView extends StatelessWidget {
  final String bloodGroup;
  final String title;
  final String address;
  final String startDate;
  final String startTime;
  final String endTime;
  const RequestCardView(
      {Key? key,
      required this.bloodGroup,
      required this.title,
      required this.address,
      required this.startDate,
      required this.startTime,
      required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  AppHeading(
                    text: title,
                    widgetSize: WidgetSize.small,
                  ),
                  AppLabel(
                    text: address,
                    widgetSize: WidgetSize.medium,
                    textColor: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  AppLabel(
                    text: "$startDate \nat $startTime.00 - $endTime.00",
                    widgetSize: WidgetSize.medium,
                    textColor: Constants.appColorBrownRed,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print("accepted");
                          },
                          child: Text("Active")),
                      SizedBox(
                        width: 5,
                      ),
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
    );
  }
}
