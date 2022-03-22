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
            AppLabel(text: text ?? "Please wait!", widgetSize: WidgetSize.large)
          ],
        ));
  }
}
