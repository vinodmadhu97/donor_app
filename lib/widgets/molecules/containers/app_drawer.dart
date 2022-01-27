import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:switcher_button/switcher_button.dart';

class AppDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'EN',
      'label': 'English',
    },
    {
      'value': 'SIN',
      'label': 'Sinhala',
    },
    {
      'value': 'TAM',
      'label': 'Tamil',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: Constants.appColorWhite,
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  color: Constants.appColorWhite,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/blood_drop.png",
                        height: 70,
                        width: 70,
                      ),
                      AppHeading(
                        text: "The Donor",
                        widgetSize: WidgetSize.small,
                        color: Constants.appColorBrownRed,
                      ),
                      AppLabel(
                        text: "Version 1.1.0",
                        widgetSize: WidgetSize.medium,
                        textColor: Constants.appColorBrownRed,
                      )
                    ],
                  ),
                )),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SelectFormField(

                type: SelectFormFieldType.dropdown,
                // or can be dialog
                initialValue: 'EN',
                icon: Icon(Icons.language),
                labelText: 'Language',
                items: _items,
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(width: 10,),
                  AppLabel(text: "Notifications", widgetSize: WidgetSize.large),
                  Spacer(),
                  SwitcherButton(
                    size: 40,
                    value: true,
                    onChange: (value) {
                      print(value);
                    },
                    onColor: Constants.appColorBrownRed,
                    offColor: Constants.appColorGray,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.color_lens),
                  SizedBox(width: 10,),
                  AppLabel(text: "Dark Theme", widgetSize: WidgetSize.large),
                  Spacer(),
                  SwitcherButton(
                    size: 40,
                    value: true,
                    onChange: (value) {
                      print(value);
                    },
                    onColor: Constants.appColorBrownRed,
                    offColor: Constants.appColorGray,

                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: InkWell(
                onTap: (){print("logout");},
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10,),
                    AppLabel(text: "Log Out", widgetSize: WidgetSize.large,textColor: Constants.appColorBrownRed,)
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(thickness: 1,color: Constants.appColorBlack,),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: InkWell(
                onTap: (){print("about us");},
                child: Row(
                  children: [
                    Icon(Icons.account_box_outlined),
                    SizedBox(width: 10,),
                    AppLabel(text: "About Us", widgetSize: WidgetSize.large,)
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: InkWell(
                onTap: (){print("help");},
                child: Row(
                  children: [
                    Icon(Icons.help),
                    SizedBox(width: 10,),
                    AppLabel(text: "Help", widgetSize: WidgetSize.large,)
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: InkWell(
                onTap: (){print("share");},
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 10,),
                    AppLabel(text: "Share this App", widgetSize: WidgetSize.large,)
                  ],
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
