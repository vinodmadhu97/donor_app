import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.appColorWhite,
      child: Center(
        child: SpinKitCircle(
          color: Constants.appColorBrownRed,
        ),
      ),
    );
  }
}
