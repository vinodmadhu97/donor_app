import 'package:flutter/material.dart';

class BMICardView extends StatelessWidget {
  BMICardView(
      {required this.cardSelectedColor, this.cardChild, this.myOnpressed});

  final Color cardSelectedColor;
  final Widget? cardChild;
  final Function? myOnpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myOnpressed!();
      },
      child: Container(

        child: Card(
          color: cardSelectedColor,
          child: cardChild,
        ),
      ),
    );
  }
}
