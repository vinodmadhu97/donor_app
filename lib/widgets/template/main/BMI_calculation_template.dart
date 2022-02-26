
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/widgets/molecules/containers/BMI_card_view.dart';
import 'package:donor_app/widgets/molecules/containers/bottom_button.dart';
import 'package:donor_app/widgets/molecules/containers/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../const/bmi_calculator.dart';
import '../../molecules/containers/icon_content.dart';





enum Gender{
  male,
  female,
}
class BMICalculationTemplate extends StatefulWidget {
  @override
  _BMICalculationTemplateState createState() => _BMICalculationTemplateState();
}

class _BMICalculationTemplateState extends State<BMICalculationTemplate> {

  Gender? selectedGender;
  int weight = 0;
  int height= 0;
  int age = 0;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
        centerTitle: true,
      ),
      body: SafeArea(

        child: Column(
          children:[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                BMICardView(
                  //cardSelectedColor: maleCardColor,
                  cardSelectedColor: selectedGender == Gender.male ? Constants.appColorBrownRed : Constants.appColorWhite,
                  cardChild: IconContent(genderIcon: FontAwesomeIcons.male,genderName: "MALE"),
                  myOnpressed: (){
                    setState(() {
                      selectedGender = Gender.male;
                      gender = "male";
                    });
                  },
                ),
                BMICardView(

                  cardSelectedColor: selectedGender == Gender.female ? Constants.appColorBrownRed : Constants.appColorWhite,
                  cardChild: IconContent(genderIcon: FontAwesomeIcons.female,genderName: "FEMALE"),
                  myOnpressed: (){
                    setState(() {
                      selectedGender = Gender.female;
                      gender = "female";
                    });
                  },
                ),
              ],
            ),
            BMICardView(
              cardSelectedColor: Constants.appColorWhite,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HEIGHT"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("${height.toInt()}",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                        )
                      ),
                      Text("cm")
                    ],
                  ),
                  SliderTheme(data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                      activeTickMarkColor: Constants.appColorBrownRed,
                      activeTrackColor: Constants.appColorBrownRed
                  ),
                  child: Slider(
                      value: height.toDouble(),
                      min: 0.0,
                      max: 250.0,
                      onChanged: (value){
                        setState(() {
                          height = value.toInt();
                        });

                      }) ,
                  ),

                ],
              ),
            ),
            BMICardView(
              cardSelectedColor: Constants.appColorWhite,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("WEIGHT"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("${weight}",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                      Text("kg")
                    ],
                  ),
                  SliderTheme(data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                      activeTickMarkColor: Constants.appColorBrownRed,
                      activeTrackColor: Constants.appColorBrownRed
                  ),
                    child: Slider(
                        value: weight.toDouble(),
                        min: 0.0,
                        max: 300.0,
                        onChanged: (value){
                          setState(() {
                            weight = value.toInt();
                          });

                        }) ,
                  ),

                ],
              ),
            ),
            BMICardView(
              cardSelectedColor: Constants.appColorWhite,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Age"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("${age}",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                      Text("Years")
                    ],
                  ),
                  SliderTheme(data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                    activeTickMarkColor: Constants.appColorBrownRed,
                    activeTrackColor: Constants.appColorBrownRed
                  ),
                    child: Slider(
                        value: age.toDouble(),
                        min: 0.0,
                        max: 120.0,
                        onChanged: (value){
                          setState(() {
                            age = value.toInt();
                          });

                        }) ,
                  ),

                ],
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
              child: BottomButton(
                btnTitleText: "CALCULATE",
                  onTapOp: (){
                  print(height);
                  print(weight);
                  print(age);
                  print(gender);

                  if(gender == null){
                    Constants().showToast("Please Select a gender");
                  }else if(!(height > 0)){
                    Constants().showToast("Please Select a height");
                  }else if(!(weight > 0)){
                    Constants().showToast("Please Select a weight");
                  }else if(!(age > 0)){
                    Constants().showToast("Please Select a age");
                  }
                  else{
                    //CalculateBMI calculateBMI = CalculateBMI(height: height,weight: weight,gender: gender!);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>BMIResultScreen(height: height,weight: weight,gender: gender),
                    ),
                    );
                  }

                  },
              ),
            ),
          ]
        ),
      ),
    );
  }
}










