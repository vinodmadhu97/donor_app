import 'package:flutter/material.dart';

class CustomAlertDialog{
  final BuildContext context;
  final String activeText;
  final String deActiveText;
  final String title;
  final String description;
  final Function activeClickEvent;
  final Function deActiveClickEvent;

  CustomAlertDialog({
    required this.context,
    required this.activeText,
    required this.deActiveText,
    required this.title,
    required this.description,
    required this.activeClickEvent,
    required this.deActiveClickEvent
});

  void showCustomShowDialog(){
    Widget cancelButton = TextButton(
      child: Text(deActiveText),
      onPressed:  () {
        deActiveClickEvent();
      },
    );
    Widget continueButton = TextButton(
      child: Text(activeText),
      onPressed:  () {
        activeClickEvent();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}