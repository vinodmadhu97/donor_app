import 'dart:io' as Io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/screens/main/home_screen.dart';
import 'package:donor_app/widgets/atoms/app_heading.dart';
import 'package:donor_app/widgets/molecules/buttons/filled_rounded_button.dart';
import 'package:donor_app/widgets/molecules/containers/bottom_selecter_view.dart';
import 'package:donor_app/widgets/molecules/containers/profile_avatar.dart';
import 'package:donor_app/widgets/molecules/input_fields/app_input_field.dart';
import 'package:donor_app/widgets/molecules/input_fields/register_input_field.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class RegisterTemplate extends StatefulWidget {
  RegisterTemplate({Key? key}) : super(key: key);

  @override
  State<RegisterTemplate> createState() => _RegisterTemplateState();
}

class _RegisterTemplateState extends State<RegisterTemplate> {
  GlobalKey<FormState> _nameKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  GlobalKey<FormState> _nationalIdKey = GlobalKey<FormState>();

  TextEditingController _nationalIdController = TextEditingController();

  GlobalKey<FormState> _addressKey = GlobalKey<FormState>();

  TextEditingController _addressController = TextEditingController();

  GlobalKey<FormState> _dobKey = GlobalKey<FormState>();

  TextEditingController _dobController = TextEditingController();

  GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();

  TextEditingController _phoneController = TextEditingController();

  String _genderSelected = "";
  bool _termsCheck = false;
  String _profileUrl = "";
  DateTime selectedDate = DateTime.now();
  String userPhotoUrl = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void uploadData() async {
    //TODO PROGRESS DIALOG

    if (_profileUrl.isNotEmpty) {
      String filename = DateTime.now().microsecondsSinceEpoch.toString();
      firebaseStorage.Reference reference =
          firebaseStorage.FirebaseStorage.instance.ref().child(filename);
      firebaseStorage.UploadTask uploadTask =
          reference.putFile(Io.File(_profileUrl));

      firebaseStorage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => () {});

      await taskSnapshot.ref.getDownloadURL().then((url) {
        userPhotoUrl = url;
        print(userPhotoUrl);
        _register();
      });
    } else {
      _register();
    }

    print(_profileUrl);
  }

  void _register() async {
    String currentUser = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> userData = {
      'profileUrl': userPhotoUrl,
      'fullName': _nameController.text.trim(),
      'nic': _nationalIdController.text.trim(),
      'address': _addressController.text.trim(),
      'phone': _phoneController.text.trim(),
      'dob': _dobController.text.trim(),
      'gender': _genderSelected,
      'agreement': _termsCheck.toString()
    };

    FirebaseFirestore.instance
        .collection('donors')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userData)
        .then((value) => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableHome(
          title: Text("Register"),
          curvedBodyRadius: 0,
          headerExpandedHeight: 0.35,
          fullyStretchable: false,
          headerWidget: headerWidget(),
          body: bodyWidget(context)),
    );
  }

  Widget headerWidget() {
    return Container(
        alignment: Alignment.centerLeft,
        color: Constants.appColorWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                child: AppHeading(
                  text: "Register",
                  color: Constants.appColorBrownRed,
                ),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ProfileAvatar(
                imagePath: _profileUrl,
                onClicked: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => BottomSelector(
                          getUrl: getImageUrl,
                        )),
                  );
                })
          ],
        ));
  }

  List<Widget> bodyWidget(BuildContext context) {
    return [
      SizedBox(height: 30),
      RegisterInputField(
          formKey: _nameKey,
          controller: _nameController,
          inputType: TextInputType.text,
          validator:
              MultiValidator([RequiredValidator(errorText: '*Required')]),
          hintText: "Full name"),
      SizedBox(
        height: 30,
      ),
      RegisterInputField(
          formKey: _nationalIdKey,
          controller: _nationalIdController,
          inputType: TextInputType.text,
          validator:
              MultiValidator([RequiredValidator(errorText: '*Required')]),
          hintText: "National Id"),
      SizedBox(
        height: 30,
      ),
      RegisterInputField(
          formKey: _addressKey,
          controller: _addressController,
          inputType: TextInputType.text,
          validator:
              MultiValidator([RequiredValidator(errorText: '*Required')]),
          hintText: "Address"),
      SizedBox(
        height: 30,
      ),
      RegisterInputField(
          formKey: _phoneKey,
          controller: _phoneController,
          inputType: TextInputType.text,
          validator:
              MultiValidator([RequiredValidator(errorText: '*Required')]),
          hintText: "Phone"),
      SizedBox(
        height: 30,
      ),
      Form(
        key: _dobKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _dobController,
            textAlign: TextAlign.left,
            style: TextStyle(color: Constants.appColorBlack, fontSize: 14),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Constants.appColorGray, fontSize: 14),
              hintText: "Date of Birth",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Constants.appColorBrownRed,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Constants.appColorGray,
                  width: 1.0,
                ),
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "* DOB is Required";
              } else
                return null;
            },
            readOnly: true,
            onTap: () {
              datePicker(context);
              print("date picker");
            },
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        "Gender",
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio<String>(
                    value: "male",
                    groupValue: _genderSelected,
                    onChanged: (value) {
                      setState(() {
                        _genderSelected = "male";
                      });
                    }),
              ),
              Text("Male", style: TextStyle(fontSize: 16))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio<String>(
                    value: "female",
                    groupValue: _genderSelected,
                    onChanged: (value) {
                      setState(() {
                        _genderSelected = "female";
                      });
                    }),
              ),
              Text(
                "Female",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio<String>(
                    value: "other",
                    groupValue: _genderSelected,
                    onChanged: (value) {
                      setState(() {
                        _genderSelected = "other";
                      });
                    }),
              ),
              Text("Other", style: TextStyle(fontSize: 16))
            ],
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      ListTile(
        leading: Transform.scale(
          scale: 1.3,
          child: Checkbox(
            value: _termsCheck,
            onChanged: (value) {
              setState(() {
                if (!_termsCheck) {
                  _termsCheck = true;

                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheetConfirmTerms()),
                  );
                } else {
                  _termsCheck = false;
                }
              });
            },
          ),
        ),
        title: Text("I agree to Terms & Conditions"),
      ),
      SizedBox(
        height: 30,
      ),
      FilledRoundedButton(
          text: "Register",
          widgetSize: WidgetSize.large,
          clickEvent: () {
            print("upload data");
            print(_nameController.text);
            print(_nationalIdController.text);
            print(_addressController.text);
            print(_phoneController.text);
            print(_dobController.text);
            print(_genderSelected);
            print(_termsCheck);
            //_register();
            uploadData();
          })
    ];
  }

  void getImageUrl(String url) {
    setState(() {
      _profileUrl = url;
      print("url is $url");
    });
  }

  Widget bottomSheetConfirmTerms() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Please accept the Terms & Conditions",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            child: Text(
              "About Terms & Conditions",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            onTap: () => Constants.openLink(
                url:
                    'http://www.nbts.health.gov.lk/index.php/donate-blood/donate-blood-2'),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            InkWell(
              child: Text(
                "CANCEL",
                style: TextStyle(
                    color: Constants.appColorBrownRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  _termsCheck = false;
                });

                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 40,
            ),
            InkWell(
              child: Text("OK",
                  style: TextStyle(
                      color: Constants.appColorBrownRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              onTap: () {
                setState(() {
                  _termsCheck = true;
                });
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 40,
            ),
          ])
        ],
      ),
    );
  }

  void datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime(selectedDate.year - 60),
      lastDate: new DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat("yyyy-MM-dd").format(picked);
        _dobController.text = formattedDate;
        print(selectedDate.year);
      });
  }
}
