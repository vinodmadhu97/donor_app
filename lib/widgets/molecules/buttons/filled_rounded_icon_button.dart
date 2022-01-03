import 'package:donor_app/const/widget_size.dart';
import 'package:flutter/material.dart';


class FilledRoundedIconButton extends StatelessWidget {
  final String text;
  final WidgetSize widgetSize;
  final Function clickEvent;
  final Icon icon;
  Color? bgColor;
  Color? textColor;
  double? height;
  double? width;
  double? radius;
  double? fontSize;
  FilledRoundedIconButton({
    Key? key,
    required this.text,
    required this.widgetSize,
    required this.clickEvent,
    required this.icon,
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
    this.height = 48.0,
    this.width =  110,
    this.radius = 24.0,
    this.fontSize = 16.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(widgetSize == WidgetSize.large){
      width = MediaQuery.of(context).size.width * 0.6;
      height = 48.0;
      radius = 24.0;
      fontSize = 16.0;

    }else if(widgetSize == WidgetSize.medium) {
      width = MediaQuery
          .of(context)
          .size
          .width * 0.4;
      height = 40.0;
      radius = 24.0;
      fontSize = 14.0;
    }else{
      width = MediaQuery.of(context).size.width * 0.3;
      height = 32.0;
      radius = 24.0;
      fontSize = 12.0;
    }

    return GestureDetector(
      onTap: (){clickEvent();},
      child: Container(

        alignment: Alignment.center,
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 10,),
            Text(text, style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              fontWeight: FontWeight.bold
            ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(radius!)
        ),
      ),
    );
  }
}
