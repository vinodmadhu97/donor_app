import 'dart:io';

import 'package:donor_app/screens/main/campaigns_screen.dart';
import 'package:donor_app/screens/main/dash_board_screen.dart';
import 'package:donor_app/screens/main/requests_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class NotificationTest extends StatefulWidget {
  const NotificationTest({Key? key}) : super(key: key);

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  String? type;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    NotificationApi.init();

    // IN APP NOTIFICATION
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("------------------------------------>fg${message.data}");
      NotificationApi.showImageNotification(
          title: notification!.title, body: notification.body);
      type = message.data['type'];
      //listenNotification();
      /*if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
                channelDescription: channel.description,
              ),
            ));
      }*/
    });

    //background notification

    /*FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        print("------------------------------------>bg${message.data}");
        if (message.data['type'] == "request") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => RequestScreen()));
        } else if (message.data['type'] == "campaign") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CampaignsScreen()));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => DashBoardScreen()));
        }
      }
    });*/
  }

  void listenNotification() {
    NotificationApi.onNotification.stream.listen((onClickNotification));
  }

  void onClickNotification(String? payload) {
    if (type != null) {
      if (type == "request") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => RequestScreen()));
      } else if (type == "campaign") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CampaignsScreen()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => DashBoardScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationApi.showImageNotification(
                    title: "Image", body: "How are you");
              },
              child: Text("Image Notification"),
            ),
            ElevatedButton(
              onPressed: () {
                NotificationApi.showSimpleNotification(
                    title: "Simple", body: "How are you");
              },
              child: Text("simple Notification"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Remove Notification"),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future init({bool initScheduled = false}) async {
    var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var iosSettings = IOSInitializationSettings();

    var settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notification.initialize(settings,
        onSelectNotification: (payload) async {
      onNotification.add(payload);
    });
  }

  static Future showImageNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _notification.show(
        id, title, body, await _imageNotificationDetails(),
        payload: payload);
  }

  static Future showSimpleNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _notification.show(
        id, title, body, await _simpleNotificationDetails(),
        payload: payload);
  }

  static Future _imageNotificationDetails() async {
    var uri = Uri.https("www.picsum.photos", "/200/300");
    var bigPicturePath = await Utils.downloadFile(uri, "bigPicture");
    var largeIconPath = await Utils.downloadFile(uri, "largeIcon");

    var styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        largeIcon: FilePathAndroidBitmap(largeIconPath));
    return NotificationDetails(
        android: AndroidNotificationDetails("channel id", "channel name",
            channelDescription: "channel description",
            importance: Importance.max,
            styleInformation: styleInformation),
        iOS: IOSNotificationDetails());
  }

  static Future _simpleNotificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          "channel id",
          "channel name",
          channelDescription: "channel description",
          importance: Importance.max,
        ),
        iOS: IOSNotificationDetails());
  }
}

class Utils {
  static Future<String> downloadFile(Uri url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$filename';

    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    final file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }
}
