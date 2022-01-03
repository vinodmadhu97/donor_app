import 'dart:ui';
import 'package:donor_app/widgets/molecules/containers/alert_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class Constants{

  static const appColorBrownRed = Color(0xffD92027);
  static const appColorBrownRedLight = Color(0xffff5d51);
  static const appColorWhite = Color(0xffffffff);
  static const appColorBlack = Color(0xff000000);
  static const appColorGray = Color(0xffc4c4c4);

  static const MaterialColor appColorbrownRedSwatch = MaterialColor(0xffD92027, <int, Color>{
    50: Color(0xffD92027),
    100: Color(0xffD92027),
    200: Color(0xffD92027),
    300: Color(0xffD92027),
    400: Color(0xffD92027),
    500: Color(0xffD92027),
    600: Color(0xffD92027),
    700: Color(0xffD92027),
    800: Color(0xffD92027),
    900: Color(0xffD92027),
  });


  static bool isLogged = true;

  //<-------------SHARED PREFERENCES----------------->
  static const String IS_APP_INSTALLED = "isAppInstalled";
  static bool isInstalled = false;

  final Future<SharedPreferences> _mSF = SharedPreferences.getInstance();

  //set app installed data
  Future<void> setAppInstalledDataInSF(String key, bool value) async {
    final SharedPreferences prefs = await _mSF;

    prefs.setBool(key, value);

  }

  Future<void> getAppInstalledDataInSF(String key) async {
    final SharedPreferences prefs = await _mSF;

    if(prefs.containsKey(key)){
      //return true;
      isInstalled = true;
    }else{
      isInstalled = false;
    }
    //return false;


  }

  /*//<-----------------------CHECK INTERNET CONNECTION------------------>
  static Future<bool> checkInternet() async{
    bool hasConnect =  await InternetConnectionChecker().hasConnection;


    if(!hasConnect){

      showSimpleNotification(
          const Text(
            "No Internet Connection",
          ),
          background: Colors.black54
      );


      return false;
    }else{
      return true;
    }
  }*/

  //<-------------SHOWING TOAST MESSAGES----------------->
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: appColorBrownRed.withOpacity(0.8),
        textColor: appColorWhite
    );
  }

  //<-------------CHECKING CAMERA PERMISSION----------------->
  void checkCameraPermission(BuildContext context,Function getUrl) async{
    var cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted)

      await Permission.camera.request();


    if (cameraStatus.isDenied) {
      Constants().showToast("sdsds");
      CustomAlertDialog(
        context: context,
        activeText: "Go",
        deActiveText: "Cancel",
        activeClickEvent: openAppSettings,
        deActiveClickEvent: (){Navigator.of(context).pop();},
        title: "Camera Permission required",
        description: "do you want to give the camera permission"
      );


    }

    if(await Permission.camera.isGranted){
      Constants().takePhoto(ImageSource.camera,getUrl);
      print("captured");
    }else{
      /*showDialog(context: context, builder: builder)*/
      CustomAlertDialog(
          context: context,
          activeText: "Go",
          deActiveText: "Cancel",
          activeClickEvent: openAppSettings,
          deActiveClickEvent: (){Navigator.of(context).pop();},
          title: "Camera Permission required",
          description: "do you want to give the camera permission"
      );
      Constants().showToast("Provide Camera permission to use camera.");
      //openAppSettings();

    }
  }
  DateTime selectedDate = DateTime.now();
  void takePhoto(ImageSource source,Function getImage) async {
    final ImagePicker _picker = ImagePicker();

    try{
      final pickedFile = await _picker.pickImage(source: source,);
      if(pickedFile != null){
        getImage(pickedFile.path);

      }else{
        getImage("");
      }

    }catch(e){
      print(e.toString());
    }

  }

  static Future openLink({required String url,}) => _launchUrl(url);
  static Future _launchUrl(String url) async {
    print(url);

    await launch(url);

  }




}