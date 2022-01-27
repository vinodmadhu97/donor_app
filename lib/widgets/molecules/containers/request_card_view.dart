import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:flutter/material.dart';

class RequestCardView extends StatelessWidget {
  const RequestCardView({
    Key? key,
  }) : super(key: key);

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
                  AppHeading(text: "Ragama Hospital",widgetSize: WidgetSize.small,),
                  AppLabel(text: "Main road Ragama",
                    widgetSize: WidgetSize.medium,
                    textColor: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),

                  AppLabel(
                    text: "High",
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
    );
  }
}