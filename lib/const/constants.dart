import 'dart:ui';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants{

  static const appColorBrownRed = Color(0xffD92027);
  static const appColorBrownRedLight = Color(0xffff5d51);
  static const appColorWhite = Color(0xffffffff);
  static const appColorBlack = Color(0xff000000);
  static const appColorGray = Color(0xffc4c4c4);

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

  //<-----------------------CHECK INTERNET CONNECTION------------------>
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
  }
}