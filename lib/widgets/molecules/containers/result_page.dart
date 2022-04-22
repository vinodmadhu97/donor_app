import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/bmi_calculator.dart';
import 'BMI_card_view.dart';
import 'bottom_button.dart';

class BMIResultScreen extends StatelessWidget {
  final int height;
  final int weight;
  final String? gender;

  BMIResultScreen({required this.height, required this.weight, this.gender});

  @override
  Widget build(BuildContext context) {
    CalculateBMI calculateBMI = CalculateBMI(height: height, weight: weight);
    return Scaffold(
        appBar: AppBar(
          title: Text("Result".tr),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Expanded(child: Text("Your Result",style: KtitleTextStyle,)),
            Expanded(
              flex: 5,
              child: BMICardView(
                cardSelectedColor: Constants.appColorWhite,
                cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        calculateBMI
                            .getResult(calculateBMI.getCalculation())
                            .toUpperCase(),
                        style: TextStyle(
                          color: Constants.appColorBrownRed,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        calculateBMI.getCalculation().toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 100.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        calculateBMI
                            .getInterpretation(calculateBMI.getCalculation()),
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: BottomButton(
                btnTitleText: "RE-CALCULATE".tr,
                onTapOp: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ));
  }
}
