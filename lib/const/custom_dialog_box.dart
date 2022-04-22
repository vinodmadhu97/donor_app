import 'package:donor_app/const/constants.dart';
import 'package:donor_app/const/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../widgets/atoms/app_label.dart';

class CustomDialogBox {
  static buildDialogBox({String? text}) {
    Get.defaultDialog(
        title: "",
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.all(30),
        barrierDismissible: false,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: Constants.appColorBrownRed,
            ),
            SizedBox(
              height: 10,
            ),
            AppLabel(
                text: text ?? "please wait".tr, widgetSize: WidgetSize.large)
          ],
        ));
  }

  static buildOkWithCancelDialog(
      {String title = "alert",
      required String description,
      String confirmText = "Ok",
      String cancelText = "Cancel",
      required Function okOnclick}) {
    Get.defaultDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        title: title,
        middleText: description,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Constants.appColorBrownRed),
        middleTextStyle: TextStyle(color: Constants.appColorBlack),
        textConfirm: confirmText,
        textCancel: cancelText,
        cancelTextColor: Constants.appColorBrownRed,
        confirmTextColor: Colors.white,
        buttonColor: Constants.appColorBrownRed,
        barrierDismissible: false,
        radius: 10,
        onConfirm: () {
          okOnclick();
        });
  }
}
