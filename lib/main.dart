import 'package:donor_app/screens/main/home.dart';
import 'package:donor_app/screens/startup/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'const/constants.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final bool _isLogged = true;
  final bool _isAppInstalled = false;
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
      future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Splash();
          }
            return UpComingScreen();
        }
      )
    );
  }
}
class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    await Constants().getAppInstalledDataInSF(Constants.IS_APP_INSTALLED);
    await Future.delayed(const Duration(seconds: 2));
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Constants.appColorBrownRed,
      body: Center(
        child: Image.asset("assets/icons/logo.png",height: 80,width: 80,),
      ),
    );
  }
}

class UpComingScreen extends StatelessWidget {
  const UpComingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getScreen();
  }

  Widget getScreen(){
    if(!Constants.isInstalled){
      return OnBoardingScreen();
    }else{
      return Home();
    }
  }
}

