import 'package:donor_app/const/widget_size.dart';
import 'package:flutter/material.dart';


class GhostButton extends StatelessWidget {
  final Function clickEvent;
  final String text;
  final WidgetSize widgetSize;
  Color? color;
  double? textSize;

  GhostButton({
    Key? key,
    required this.text,
    required this.clickEvent,
    required this.widgetSize,
    this.color = const Color(0xff2196F3),
    this.textSize = 16.0

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(widgetSize == WidgetSize.large){
      textSize = 16.0;
    }else if(widgetSize == WidgetSize.medium){
      textSize = 14.0;
    }else{
      textSize = 12.0;
    }
    return TextButton(onPressed: (){clickEvent();}, child: Text(text,style: TextStyle(color: color,fontSize: textSize),));
  }
}
