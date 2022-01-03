import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
class RegisterInputField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final TextInputType inputType;
  final MultiValidator validator;
  final String hintText;
  Color? color;

  RegisterInputField({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.inputType,
    required this.validator,
    required this.hintText,
    this.color = Constants.appColorGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
            controller: controller,
            textAlign: TextAlign.left,
            style: TextStyle(color: Constants.appColorBlack, fontSize: 14),
            keyboardType: inputType,

            decoration: InputDecoration(

              hintStyle: TextStyle(color: color, fontSize: 14),
              hintText: hintText,
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

            validator: validator
        ),
      ),
    );
  }
}
