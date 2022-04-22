import 'package:donor_app/screens/main/campaigns_screen.dart';
import 'package:donor_app/screens/main/dash_board_screen.dart';
import 'package:donor_app/screens/main/requests_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationController extends GetxController {
  /*AAAAny1-dL4:APA91bGm9e0mj6MHrwLKfm5ji7eyNfXfe01hsbjc65u75fhjt1q6JQWdLQPvuLB3D904nnZx2nj4szms-c6_t--UOlkVR7fAnQYNm5yg5hzycHY-Rv1o8mxMPEIQrbvTzQkV3ECS6JXC*/
  /*683663062206*/
  /*https://firebasestorage.googleapis.com/v0/b/donor-app-83ae2.appspot.com/o/16
  48579468622000.png?alt=media&token=82088a67-e624-466c-b50d-d93b80db6ab3*/
  String? type;

  @override
  void onInit() {
    // IN APP NOTIFICATION
    //inAppNotification();
    //backgroundNotification();
    setupInteractMessage();
    //localNotification();
    super.onInit();
  }

  Future<void> localNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
    });
  }

  Future<void> setupInteractMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'poster') {
      print("---------------------------->${message.data['type']}");
      Get.to(DashBoardScreen());
    } else if (message.data['type'] == "campaign") {
      Get.to(CampaignsScreen());
    } else if (message.data['type'] == "request") {
      Get.to(RequestScreen());
    } else {
      Get.to(DashBoardScreen());
    }
  }

  /*void inAppNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      type = message.data['type'];
      print(message.data);
      print("IN APP");
      NotificationApi.showSimpleNotification();
      listenNotification();
    });
  }*/

  /*void listenNotification() {
    NotificationApi.onNotification.stream.listen((onClickNotification));
  }*/

  /*void onClickNotification(String? payload) {
    if (type != null) {
      if (type == "request") {
        Get.to(RequestScreen());
      } else if (type == "campaign") {
        Get.to(CampaignsScreen());
      } else {
        Get.to(DashBoardScreen());
      }
    }
  }*/

  /*void backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      type = message.data['type'];
      print("------------------------------------>to=${message.data['to']}");
      print("------------------------------------>bg=${message.data['url']}");

      if (notification != null && android != null) {
        if (message.data['type'] == "request") {
          Get.to(RequestScreen());
        } else if (message.data['type'] == "campaign") {
          Get.to(CampaignsScreen());
        } else {
          Get.to(DashBoardScreen());
        }
      }
    });
  }*/
}

/*class NotificationApi {
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

  static Future showSimpleNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    print("------------------------->payload$payload");
    return _notification.show(
        id, title, body, await _simpleNotificationDetails(),
        payload: payload);
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
}*/
