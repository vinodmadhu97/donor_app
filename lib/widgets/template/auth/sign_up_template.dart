import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/const/auth_exception_handler.dart';
import 'package:donor_app/const/auth_result_status_enum.dart';
import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/screens/auth/register_screen.dart';
import 'package:donor_app/screens/auth/sign_in_screen.dart';
import 'package:donor_app/screens/main/home_screen.dart';
import 'package:donor_app/widgets/molecules/buttons/filled_rounded_button.dart';
import 'package:donor_app/widgets/molecules/input_fields/app_input_field.dart';
import 'package:donor_app/widgets/molecules/input_fields/app_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class SignUpTemplate extends StatefulWidget {


  SignUpTemplate({Key? key}) : super(key: key);

  @override
  State<SignUpTemplate> createState() => _SignUpTemplateState();
}

class _SignUpTemplateState extends State<SignUpTemplate> {
  GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  GlobalKey<FormState> _confirmPasswordKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userId = "";
  String userEmail = "";
  String? _status;

  void signUpUser()async{

    //TODO CIRCULAR PROGRESS DIALOG
    try{
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );

      User? currentUser = FirebaseAuth.instance.currentUser;
      if( currentUser != null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const RegisterScreen()));
        print("register");
      }

    }catch(e){
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.generateExceptionMessage(e);
      Constants().showToast(_status!);
    }




  }

  /*void saveUserData(){
    Map<String,dynamic> userData = {

      'uId' : userId,
      'userEmail' : userEmail,
    };

    FirebaseFirestore.instance.collection('donors').doc(userId).set(userData);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Constants.appColorBrownRed,Constants.appColorBrownRedLight],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter
                  ),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.0))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/icons/logo.png",width: 150,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text("SIGN UP",style: TextStyle(
                            color: Colors.white,fontFamily: "Kanit-Bold",
                            fontSize: 30
                        ),),
                      )
                    ],
                  )
                ],
              ),

            ),

            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 30,),

                        AppInputField(
                            formKey: _emailKey,
                            controller: _emailController,
                            inputType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Email is Required"),
                              EmailValidator(errorText: "Enter a Valid Email")
                            ]),
                            iconData: Icons.email,
                            hintText: "Email"
                        ),

                        SizedBox(height: 30,),

                        AppPasswordField(
                          formKey: _passwordKey,
                          controller: _passwordController,
                          inputType: TextInputType.text,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Password is Required"),
                            MinLengthValidator(6, errorText: "password must be at least 6 characters")
                          ]),
                          iconData: Icons.security,
                          hintText: "Password",
                        ),

                        SizedBox(height: 40,),

                    Form(
                      key: _confirmPasswordKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                            controller: _confirmPasswordController,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Constants.appColorBlack, fontSize: 14),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(

                              icon: Icon(Icons.security,color: Constants.appColorGray,size: 20,),
                              hintStyle: TextStyle(color: Constants.appColorGray, fontSize: 14),
                              hintText: "Confirm Password",

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constants.appColorGray),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constants.appColorGray),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constants.appColorGray),
                              ),
                            ),

                            validator: (val){
                              if(val!.isEmpty)
                                return 'Re enter your password';
                              if(val != _passwordController.text)
                                return 'Password does not matched';
                              return null;
                            }
                        ),
                      ),
                    ),

                        SizedBox(height: 60,),

                        FilledRoundedButton(
                            text: "Sign Up",
                            widgetSize: WidgetSize.large,
                            clickEvent: (){

                              //CHECKING THE INPUT DATA VALIDATION

                              if(_isValidate()){

                                //TAKING THE INPUT DATA
                                print(_emailController.text.toString());
                                print(_passwordController.text.toString());

                                //MOVING TO THE HOME IF DATA VALIDATED
                                signUpUser();

                              }

                            }
                        ),


                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an Account?"),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Text("Sign In",style: TextStyle(
                                  color: Constants.appColorBrownRed
                              ),),
                              onTap: (){
                                //todo move to the sign in
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) => SignInScreen()));
                                print("sign In");
                              },
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                )
            )

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
    }else if(!_confirmPasswordKey.currentState!.validate()){
      return false;
    } else {
      return true;
    }
  }
}
