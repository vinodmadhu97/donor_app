import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class BottomSelector extends StatelessWidget {
  final Function getUrl;
  BottomSelector({
    Key? key,
    required this.getUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera,color: Constants.appColorBrownRed,size: 30,),
              onPressed: () {
                Constants().checkCameraPermission(context,getUrl);
                print("check permission");
                Navigator.of(context).pop();


              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image,color: Constants.appColorBrownRed,size: 30),
              onPressed: () async {

                Constants().takePhoto(ImageSource.gallery,getUrl);
                print("select gallery");

                Navigator.of(context).pop();

              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }
}
