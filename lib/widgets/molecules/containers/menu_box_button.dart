import 'package:donor_app/const/widget_size.dart';
import 'package:donor_app/widgets/atoms/app_label.dart';
import 'package:flutter/material.dart';
class MenuBoxButton extends StatelessWidget {
  final Color color;
  final String imgUrl;
  final String title;
  final Function clickEvent;

  MenuBoxButton({
    Key? key,
    required this.title,
    required this.color,
    required this.imgUrl,
    required this.clickEvent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        clickEvent();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            child: Center(
              child: Image.asset(imgUrl),
            ),
          ),
          AppLabel(text: title, widgetSize: WidgetSize.medium)
        ],
      ),
    );
  }
}