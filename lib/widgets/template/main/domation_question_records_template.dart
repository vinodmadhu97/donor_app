import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:group_radio_button/group_radio_button.dart';

class DonationQuestionRecordsTemplate extends StatefulWidget {
  final String campaignId;
  DonationQuestionRecordsTemplate({Key? key, required this.campaignId})
      : super(key: key);

  @override
  _DonationQuestionRecordsTemplateState createState() =>
      _DonationQuestionRecordsTemplateState();
}

class _DonationQuestionRecordsTemplateState
    extends State<DonationQuestionRecordsTemplate> {
  int currentStep = 0;
  String _verticalGroupValue = "Pending";
  String donorId = FirebaseAuth.instance.currentUser!.uid;
  List<String> _status = [
    "Yes",
    "No",
  ];

  final Map<String, String> assessResult = {};
  final Map<String, String> assessResult2 = {};

  late final Future<QuerySnapshot<Map<String, dynamic>>> newSnapshot =
      FirebaseServices().getAssessments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Records"),
      ),
      body: FutureBuilder(
        future: newSnapshot,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitCircle(
              color: Constants.appColorBrownRed,
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Step> steps = [];

            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              var step = Step(
                  title: Text("Step ${i + 1}"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${snapshot.data?.docs[i].data()["assessment"]["as_en"]}"),
                      Row(
                        children: [
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) {
                              setState(() {
                                _verticalGroupValue = value!;
                                print(
                                    "--------->> group value $_verticalGroupValue");
                                assessResult[
                                    snapshot.data!.docs[i].data()["assessment"]
                                        ["as_en"]] = _verticalGroupValue;
                                assessResult2[
                                    snapshot.data!.docs[i].data()["assessment"]
                                        ["as_en"]] = _verticalGroupValue;
                              });
                            },
                            items: _status,
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.blue),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  isActive: currentStep >= 0);
              steps.add(step);
            }
            return Stepper(
                currentStep: currentStep,
                physics: NeverScrollableScrollPhysics(),
                onStepContinue: () {
                  setState(() {
                    if (currentStep < (snapshot.data!.docs.length - 1)) {
                      currentStep = currentStep + 1;
                      _verticalGroupValue = "Pending";
                    } else {
                      print(assessResult);
                      print(assessResult.length);
                      print(assessResult2);
                      print(assessResult2.length);

                      if (assessResult.length == snapshot.data!.docs.length) {
                        print("upload data");
                        FirebaseServices().sendDonationRequest(
                            context: context,
                            campaignId: widget.campaignId,
                            assessmentResult: assessResult,
                            donorId: donorId);
                      } else {
                        Constants()
                            .showToast("Please Answer the missing Assessments");
                      }
                      //UPLOAD THE DATA
                      //uploadData();
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
                onStepTapped: (step) {
                  setState(() {
                    this.currentStep = step;
                  });
                },
                controlsBuilder: (context, controller) {
                  final isLastStep =
                      currentStep == (snapshot.data!.docs.length - 1);

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
                        SizedBox(
                          width: 30,
                        ),
                        Visibility(
                          visible: currentStep != 0,
                          child: ElevatedButton(
                            onPressed: controller.onStepCancel,
                            child: Text("BACK"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                steps: steps);
          }

          return Text("Something went Wrong");
        },
      ),
    );
  }
}
