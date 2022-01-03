import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AppInputField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final TextInputType inputType;
  final MultiValidator validator;
  final IconData iconData;
  final String hintText;
  Color? color;

  AppInputField({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.inputType,
    required this.validator,
    required this.iconData,
    required this.hintText,
    this.color = Constants.appColorGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.left,
          style: TextStyle(color: Constants.appColorBlack, fontSize: 14),
          keyboardType: inputType,

          decoration: InputDecoration(

            icon: Icon(iconData,color: color,size: 20,),
            hintStyle: TextStyle(color: color, fontSize: 14),
            hintText: hintText,

            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color!),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color!),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: color!),
            ),
          ),

          validator: validator
        ),
      ),
    );
  }
}
