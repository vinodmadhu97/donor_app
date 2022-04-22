import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../controllers/language_controller.dart';
import '../../molecules/buttons/outlined_rounded_button.dart';

class OnBoardingTemplate extends StatelessWidget {
  final List<Map<String, String>> items;
  OnBoardingTemplate({Key? key, required this.items}) : super(key: key);
  final languageController = Get.find<LanguageController>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: items
              .map((item) => PageViewModel(
                  title: item['title'],
                  body: item['body'],
                  image: buildImage(item['image']!),
                  decoration: getPageDecoration()))
              .toList(),

          done: const Text('START',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Constants.appColorBrownRed)),
          onDone: () {
            goToHome(context);
          },
          showSkipButton: true,
          skip: const Text(
            'SKIP',
            style: TextStyle(color: Constants.appColorBrownRed),
          ),
          onSkip: () {
            goToHome(context);
          },
          next: const Text("NEXT",
              style: TextStyle(
                  color:
                      Constants.appColorBrownRed)), //Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          skipFlex: 0,
          nextFlex: 0,
        ),
      ),
    );
  }

  void goToHome(context) {
    String selectedLanguage = "EN";
    print("moved to signup page");
    Constants().setAppInstalledDataInSF(Constants.IS_APP_INSTALLED, true);
    languageController.setLanguage("EN");
    //languageController.changeLanguage("si", "LK");
    Get.defaultDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        title: "Select your language",
        middleText: "",
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Constants.appColorBrownRed),
        middleTextStyle: TextStyle(color: Constants.appColorBlack),
        textConfirm: "Continue",
        confirmTextColor: Colors.white,
        buttonColor: Constants.appColorBrownRed,
        barrierDismissible: false,
        radius: 10,
        content: SizedBox(
          width: 300,
          child: SelectFormField(
            type: SelectFormFieldType.dropdown,
            // or can be dialog
            initialValue: selectedLanguage,
            icon: Icon(Icons.language),
            labelText: 'language'.tr,
            items: _items,
            onChanged: (val) {
              selectedLanguage = val;
            },
          ),
        ),
        onConfirm: () {
          Get.back();
          languageController.setLanguage(selectedLanguage);

          if (selectedLanguage == "SI") {
            languageController.setLocale("si", "LK");
            languageController.changeLanguage("si", "LK");
          } else if (selectedLanguage == "TA") {
            languageController.setLocale("ta", "LK");
            languageController.changeLanguage("ta", "LK");
          } else {
            languageController.setLocale("en", "US");
            languageController.changeLanguage("en", "US");
          }
        });
  }

  Widget bottomSheetLanguage(BuildContext context) {
    print("------------------->hit");
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 300,
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
                    languageController.setLocale("si", "LK");
                  } else if (val == "TA") {
                    languageController.setLocale("ta", "LK");
                  } else {
                    languageController.setLocale("en", "US");
                  }
                }
                //onSaved: (val) => print(val),
                ),
          ),
          SizedBox(
            height: 20,
          ),
          OutlinedRoundedButton(
            widgetSize: WidgetSize.small,
            clickEvent: () {
              Locale locale = languageController.getLocale()!;
              languageController.changeLanguage(
                  locale.languageCode, locale.countryCode!);
            },
            text: 'Continue',
            bgColor: Constants.appColorWhite,
            textColor: Constants.appColorBrownRed,
            borderColor: Constants.appColorBrownRed,
          )
        ],
      ),
    );
  }

  Widget buildImage(String path) {
    return Center(
      child: Image.asset(
        path,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Constants.appColorBlack,
        ),
        bodyTextStyle: TextStyle(fontSize: 14, color: Constants.appColorBlack),
        descriptionPadding: EdgeInsets.all(0).copyWith(bottom: 0),
        imagePadding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 40),
        pageColor: Colors.transparent,
        imageFlex: 2);
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Constants.appColorGray,
        activeColor: Constants.appColorBrownRed,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );
}
