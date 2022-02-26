import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';



class BottomButton extends StatelessWidget {
  final Function onTapOp;
  final String btnTitleText;


  BottomButton({required this.onTapOp, required this.btnTitleText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Constants.appColorBrownRed,
          ),
          height: 80,
          width: double.infinity,
          child: Center(child: Text(btnTitleText,style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),)),
        ),
        onTap: (){onTapOp();}

    );
  }
}
