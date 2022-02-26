import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';





class IconContent extends StatelessWidget {
  IconContent({required this.genderIcon, required this.genderName});

  final IconData genderIcon;
  final String genderName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(genderIcon,size: 80.0,color: Constants.appColorBlack,),
        SizedBox(height: 15.0,),
        Text(genderName,style: TextStyle(fontSize: 18,color: Constants.appColorBlack)
        ),
      ],
    );
  }
}