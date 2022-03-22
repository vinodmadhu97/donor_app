import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static buildSnackBar(
      {required String title, required String message, Color? bgColor}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Constants.appColorBrownRed.withOpacity(0.5),
        colorText: Constants.appColorWhite,
        borderRadius: 10,
        margin: EdgeInsets.all(24),
        animationDuration: Duration(milliseconds: 1000));
  }
}
