import 'package:donor_app/const/translation_string.dart';
import 'package:donor_app/controllers/language_controller.dart';
import 'package:donor_app/controllers/notification_controller.dart';
import 'package:donor_app/screens/auth/sign_up_screen.dart';
import 'package:donor_app/screens/main/dash_board_screen.dart';
import 'package:donor_app/screens/startup/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'const/constants.dart';
import 'controllers/network_controller.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        "This channel is used for important notifications.", // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init('donorData');

  //HANDLE BACKGROUND NOTIFICATION
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  Get.put(NetworkController(), permanent: true);
  Get.put(NotificationController(), permanent: true);
  var languageController = Get.put(LanguageController(), permanent: true);
  Locale? locale = languageController.getLocale();
  print("----------------------->main locale ${locale?.languageCode}");

  /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);*/
  runApp(MyApp(
    locale: locale,
  ));
}

class MyApp extends StatelessWidget {
  final bool _isLogged = false;
  final bool _isAppInstalled = false;
  final Locale? locale;

  MyApp({Key? key, this.locale}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        translations: TranslationString(),
        locale: locale == null ? Get.deviceLocale : locale,
        fallbackLocale: Locale('en', "US"),
        theme: ThemeData(
            fontFamily: "Kanit-bold",
            appBarTheme: AppBarTheme(color: Constants.appColorBrownRed),
            primaryColor: Constants.appColorBrownRed,
            primarySwatch: Constants.appColorbrownRedSwatch),
        home: FutureBuilder(
            future: Init.instance.initialize(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashLoading();
              }
              return UpComingScreen();
            }));
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

class SplashLoading extends StatelessWidget {
  const SplashLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appColorWhite,
      body: Center(
        child: SpinKitCircle(
          color: Constants.appColorBrownRed,
        ),
      ),
    );
  }
}

class UpComingScreen extends StatelessWidget {
  UpComingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getScreen();
  }

  Widget getScreen() {
    if (!Constants.isInstalled) {
      print(Constants.isInstalled);
      return OnBoardingScreen();
    } else if (FirebaseAuth.instance.currentUser == null) {
      return SignUpScreen();
    } else {
      return DashBoardScreen();
    }
  }
}
