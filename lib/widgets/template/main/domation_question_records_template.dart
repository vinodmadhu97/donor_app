import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
class DonationQuestionRecordsTemplate extends StatefulWidget {
  const DonationQuestionRecordsTemplate({Key? key}) : super(key: key);

  @override
  _DonationQuestionRecordsTemplateState createState() => _DonationQuestionRecordsTemplateState();
}

class _DonationQuestionRecordsTemplateState extends State<DonationQuestionRecordsTemplate> {

  int currentStep = 0;
  String _verticalGroupValue = "Pending";
  List<String> _status = ["Yes", "No",];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Records"),),
      body: ListView(
        children: [
          Stepper(
            currentStep: currentStep,
            physics: NeverScrollableScrollPhysics(),
            onStepContinue: (){
              setState(() {
                if(currentStep < 9){
                  currentStep = currentStep+1;
                }else{
                  print("upload data");
                  //UPLOAD THE DATA
                  //uploadData();
                }
              });
            },
            onStepCancel: (){
              setState(() {
                if(currentStep > 0){
                  currentStep = currentStep - 1;
                }else{
                  currentStep = 0;
                }
              });
            },
            onStepTapped: (step){
              setState(() {
                this.currentStep = step;
              });
            },
            controlsBuilder: (context,controller){
              final isLastStep = currentStep == 9;
              return Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: ElevatedButton(
                        onPressed: controller.onStepContinue,
                        child: Text(isLastStep ? "SUBMIT" : "NEXT"),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Visibility(
                      visible : currentStep != 0,
                      child: ElevatedButton(

                        onPressed: controller.onStepCancel,
                        child: Text("BACK"),
                      ),
                    ),

                  ],
                ),
              );
            },
            steps: [
              Step(
                  title: Text("Step 1"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 1"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 2"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 2"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 3"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 3"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 4"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 4"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 5"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 5"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 6"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 6"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 7"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 7"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 8"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 8"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 9"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 9"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),
              Step(
                  title: Text("Step 10"),
                  content: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question 10"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                              print(_verticalGroupValue);
                            }),
                            items: _status,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(

                              item,


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  isActive: currentStep >= 0
              ),




            ],
          )
        ],
      )
    );
  }
}
