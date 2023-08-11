import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:students/helpers/firebase/notification_handler.dart';

class FirebaseMessagingHandler {
  FirebaseMessagingHandler() {
    _handle();
  }

  static FirebaseMessagingHandler get instance => FirebaseMessagingHandler();

  void _handle() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging
        .requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    )
        .then((settings) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print('User granted notification permission');
        }
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print('User granted provisional notification permission');
        }
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted notification permission');
        }
      }
    });

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler); //while application is on background
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //while application is on foreground/open

      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message Title : ${message.notification?.title ?? ""}');
        print('Message Body : ${message.notification?.body ?? ""}');
        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      }
      // NotificationHandler().handlePushNotification(message.data);
    });
  }

  static Future<void> onTapNotification() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleMessage(RemoteMessage message) {
    NotificationHandler().handlePushNotification(message.data);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  //while application is on foreground
  if (kDebugMode) {
    print('Message $message');
  }
}
