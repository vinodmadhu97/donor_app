import 'package:donor_app/const/auth_result_status_enum.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/screens/auth/sign_up_screen.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:donor_app/widgets/molecules/buttons/filled_rounded_button.dart';
import 'package:donor_app/widgets/molecules/containers/loading_indicator.dart';
import 'package:donor_app/widgets/molecules/input_fields/app_input_field.dart';
import 'package:donor_app/widgets/molecules/input_fields/app_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class SignInTemplate extends StatefulWidget {
  SignInTemplate({Key? key}) : super(key: key);

  @override
  State<SignInTemplate> createState() => _SignInTemplateState();
}

class _SignInTemplateState extends State<SignInTemplate> {
  GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  AuthResultStatus? _status;
  String? errorMsg;

  void _login() async {
    //TODO SHOW PROGRESS INDICATOR

    FirebaseServices()
        .donorLogin(_emailController.text, _passwordController.text, context);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingIndicator()
        : Scaffold(
            body: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Constants.appColorBrownRed,
                              Constants.appColorBrownRedLight
                            ],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: Text(
                                "login".tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Kanit-Bold",
                                    fontSize: 30),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              AppInputField(
                                  formKey: _emailKey,
                                  controller: _emailController,
                                  inputType: TextInputType.emailAddress,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "email is required".tr),
                                    EmailValidator(
                                        errorText: "enter a valid email".tr)
                                  ]),
                                  iconData: Icons.email,
                                  hintText: "email".tr),
                              SizedBox(
                                height: 30,
                              ),
                              AppPasswordField(
                                formKey: _passwordKey,
                                controller: _passwordController,
                                inputType: TextInputType.text,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "password is required".tr),
                                  MinLengthValidator(6,
                                      errorText:
                                          "password must be at least 6 characters"
                                              .tr)
                                ]),
                                iconData: Icons.security,
                                hintText: "password".tr,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              FilledRoundedButton(
                                  text: "login".tr,
                                  widgetSize: WidgetSize.large,
                                  clickEvent: () {
                                    //CHECKING THE INPUT DATA VALIDATION

                                    if (_isValidate()) {
                                      //TAKING THE INPUT DATA
                                      print(_emailController.text.toString());
                                      print(
                                          _passwordController.text.toString());

                                      //MOVING TO THE HOME IF DATA VALIDATED
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _login();
                                    }
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child:
                                            Text("do not have an account".tr)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Text(
                                          "signup".tr,
                                          style: TextStyle(
                                              color:
                                                  Constants.appColorBrownRed),
                                        ),
                                        onTap: () {
                                          //todo move to the sign in
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          SignUpScreen()));
                                          print("sign In");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
  }

  bool _isValidate() {
    if (!_emailKey.currentState!.validate()) {
      return false;
    } else if (!_passwordKey.currentState!.validate()) {
      return false;
    } else {
      return true;
    }
  }
}
