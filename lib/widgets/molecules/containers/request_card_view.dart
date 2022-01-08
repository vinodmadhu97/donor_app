import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestCardView extends StatelessWidget {
  /*final String imgUrl;
  final String title;
  final String location;
  final String price;
  final String time;*/

  RequestCardView(
      {Key? key,
      /*required this.title,
      required this.imgUrl,
      required this.price,
      required this.location,
      required this.time*/})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        //shadowColor: Colors.red,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          color: Color(0xffFFB4B4).withOpacity(0.5),
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: 180,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLabel(
                        text: "Location",
                        widgetSize: WidgetSize.medium,
                        textColor: Constants.appColorGray,

                      ),
                      AppLabel(
                        text: "Kalubowila Hospital",
                        widgetSize: WidgetSize.large,
                        textColor: Constants.appColorBlack,
                        fontWeight: FontWeight.bold,
                      ),
                      AppLabel(
                        text: "Date",
                        widgetSize: WidgetSize.medium,
                        textColor: Constants.appColorGray,
                      ),
                      AppLabel(
                        text: "2022/01/06",
                        widgetSize: WidgetSize.large,
                        textColor: Constants.appColorBlack,

                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: (){}, child: Text("Accept"))
                        ],
                      )
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text("A+",style: TextStyle(fontSize: 16),),
                      ),),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/blood_bubble.png",),

                          )
                      ),
                      height: 70,
                      width: 70,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: (){}, child: Text("Share"))
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        ));
  }
}
