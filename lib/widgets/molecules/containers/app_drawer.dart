import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/custom_dialog_box.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/screens/auth/sign_in_screen.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:system_settings/system_settings.dart';

import '../../../controllers/language_controller.dart';

class AppDrawer extends StatelessWidget {
  var languageController = Get.find<LanguageController>();
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'EN',
      'label': 'English',
    },
    {
      'value': 'SI',
      'label': 'සිංහල',
    },
    {
      'value': 'TA',
      'label': 'தமிழ்',
    },
  ];

  Future<PackageInfo> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

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
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: getAppVersion(),
                          builder: (ctx, AsyncSnapshot<PackageInfo> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("");
                            }
                            print("------->${snapshot.data!.appName}");
                            return AppLabel(
                              text: snapshot.data!.appName,
                              widgetSize: WidgetSize.medium,
                              textColor: Constants.appColorBrownRed,
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: getAppVersion(),
                          builder: (ctx, AsyncSnapshot<PackageInfo> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("");
                            }
                            print("------->${snapshot.data!.version}");
                            return AppLabel(
                              text: snapshot.data!.version,
                              widgetSize: WidgetSize.medium,
                              textColor: Constants.appColorBrownRed,
                            );
                          }),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  // or can be dialog
                  initialValue: languageController.getLanguage(),
                  icon: Icon(Icons.language),
                  labelText: 'language'.tr,
                  items: _items,
                  onChanged: (val) {
                    languageController.setLanguage(val);
                    if (val == "SI") {
                      languageController.changeLanguage("si", "LK");
                    } else if (val == "TA") {
                      languageController.changeLanguage("ta", "LK");
                    } else {
                      languageController.changeLanguage("en", "US");
                    }
                  }
                  //onSaved: (val) => print(val),
                  ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        SystemSettings.appNotifications();
                      },
                      child: AppLabel(
                          text: "notification settings".tr,
                          widgetSize: WidgetSize.large)),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: InkWell(
                onTap: () {
                  CustomDialogBox.buildOkWithCancelDialog(
                      title: "alert".tr,
                      description: "do you want to log out".tr,
                      cancelText: "no".tr,
                      confirmText: "yes".tr,
                      okOnclick: () async {
                        await FirebaseServices().deleteFcmToken();
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => SignInScreen()));
                      });
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 10,
                    ),
                    AppLabel(
                      text: "logout".tr,
                      widgetSize: WidgetSize.large,
                      textColor: Constants.appColorBrownRed,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 1,
                color: Constants.appColorBlack,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: InkWell(
                onTap: () => Constants.openLink(
                    url:
                        'http://www.nbts.health.gov.lk/index.php/about/about-nbts'),
                child: Row(
                  children: [
                    Icon(Icons.account_box_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    AppLabel(
                      text: "about us".tr,
                      widgetSize: WidgetSize.large,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: InkWell(
                onTap: () => Constants.openLink(
                    url:
                        'http://www.nbts.health.gov.lk/index.php/donate-blood/donate-blood-2'),
                child: Row(
                  children: [
                    Icon(Icons.help),
                    SizedBox(
                      width: 10,
                    ),
                    AppLabel(
                      text: "who can donate".tr,
                      widgetSize: WidgetSize.large,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: InkWell(
                onTap: () => Constants.openLink(
                    url: 'http://www.nbts.health.gov.lk/index.php/contact-us'),
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(
                      width: 10,
                    ),
                    AppLabel(
                      text: "contacts".tr,
                      widgetSize: WidgetSize.large,
                    )
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
