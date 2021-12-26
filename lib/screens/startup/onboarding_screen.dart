import 'package:donor_app/widgets/template/startup/on_boarding_template.dart';
import 'package:flutter/material.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingTemplate(
      items: [
        {
          "image":"assets/images/onboarding_image-1.png",
          "title": "Give blood via efficient Campaigns",
          "body": "Participate the donation via app & It will guide you to efficient donation",
        },

        {
          "image":"assets/images/onboarding_image-2.png",
          "title": "Give blood via efficient Campaigns",
          "body": "Participate the donation via app & It will guide you to efficient donation",
        },
        {
          "image":"assets/images/onboarding_image-3.png",
          "title": "Easy to maintain your Activities",
          "body": "Maintain your donation histories & activities via app, & use more attractive facilities",
        },
        {
          "image":"assets/images/onboarding_image-4.png",
          "title": "Be Connected with blood Service",
          "body": "Touch with Transfusion Service & get events, notifications, emergency donation requests",
        },
      ],
    );
  }
}
