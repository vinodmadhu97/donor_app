import 'package:donor_app/const/widget_size.dart';
import 'package:flutter/material.dart';


class OutlinedRoundedButton extends StatelessWidget {
  final String text;
  final WidgetSize widgetSize;
  final Function clickEvent;
  Color? textColor;
  Color? bgColor;
  Color? borderColor;
  double? height;
  double? width;
  double? radius;
  double? textSize;

  OutlinedRoundedButton({
    Key? key,
    required this.text,
    required this.widgetSize,
    required this.clickEvent,
    this.textColor =  const Color(0xff2196F3),
    this.bgColor =  const Color(0xff2196F3),
    this.borderColor =  const Color(0xff2196F3),
    this.height = 48.0,
    this.width = 110.0,
    this.radius = 24.0,
    this.textSize = 16.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(widgetSize == WidgetSize.large){
      height = 48.0;
      width = MediaQuery.of(context).size.width * 0.7;
      radius = 24.0;
      textSize = 16.0;
    }else if(widgetSize ==  WidgetSize.medium){
      height = 40.0;
      width = MediaQuery.of(context).size.width * 0.5;
      radius = 24.0;
      textSize = 14.0;
    }else{
      height = 32.0;
      width = MediaQuery.of(context).size.width * 0.3;
      radius = 24.0;
      textSize = 12.0;
    }

    return GestureDetector(
      onTap: (){clickEvent();},
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Text(text,style: TextStyle(fontSize: textSize,color: textColor),),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius!),
          border: Border.all(color: borderColor!,width: 1)
        ),
      ),
    );
  }
}



