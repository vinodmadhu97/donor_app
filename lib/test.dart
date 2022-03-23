import 'dart:io';

import 'package:donor_app/screens/main/BMI_calculation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

class NotificationTest extends StatefulWidget {
  const NotificationTest({Key? key}) : super(key: key);

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationApi.init();
    listenNotification();
  }

  void listenNotification() {
    NotificationApi.onNotification.stream.listen((onClickNotification));
  }

  void onClickNotification(String? payload) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => BMICalculationScreen()));
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
                NotificationApi.showNotification(
                    title: "Hello Vinod", body: "How are you");
              },
              child: Text("Simple Notification"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Scheduled Notification"),
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

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }

  static Future _notificationDetails() async {
    var uri = Uri.https("www.picsum.photos", "/200/300");
    var bigPicturePath = await Utils.downloadFile(uri, "bigPicture");
    /*var largeIconPath = await Utils.downloadFile("", "largeIcon");*/

    var styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(
          bigPicturePath), /*largeIcon: FilePathAndroidBitmap(largeIconPath)*/
    );
    return NotificationDetails(
        android: AndroidNotificationDetails("channel id", "channel name",
            channelDescription: "channel description",
            importance: Importance.max,
            styleInformation: styleInformation),
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
