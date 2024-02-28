import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:treeme/core/utils/services/storage.dart';

import '../../../firebase_options.dart';

//typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  //BACKGROUND Notifications - iOS & Android
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Message: ${remoteMessage.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

mixin FbNotifications {
  static Future<void> initNotifications() async {
    //Connect the previous created function with onBackgroundMessage to enable
    //receiving notification when app in Background.
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    //Channel
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'treeme_notifications_channel',
        'Treeme Notifications Channel',
        description: 'This channel will receive notifications specific to treeme',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        ledColor: Colors.orange,
        showBadge: true,
        playSound: true,
      );
    }

    //Flutter Local Notifications Plugin (FOREGROUND) - ANDROID CHANNEL
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //iOS Notification Setup (FOREGROUND)
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.onTokenRefresh.listen((newFcmToken) {
      print('fcm ${newFcmToken.toString()}');
      if (Storage().isLoggedIn) {
        print('fcm ${newFcmToken.toString()}');
      }
      // if (SharedPreferencesController().loggedIn){
      //   UserApiController().refreshFcmToken(newFcmToken: newFcmToken);
      //
      // }
    });
  }

  //iOS Notification Permission
  Future<void> requestNotificationPermissions() async {
    print('requestNotificationPermissions');
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      announcement: false,
      provisional: false,
      criticalAlert: false,
    );
    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      print('GRANT PERMISSION');
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      print('Permission Denied');
    }
  }

  //ANDROID
  static void initializeForegroundNotificationForAndroid() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message Received: ${message.messageId}');

      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = notification?.android;
      print(notification?.title);
      print(androidNotification?.channelId);

      if (notification != null && androidNotification != null) {
        localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                playSound: true,
                // channel.description,
                importance: Importance.max,
                icon: '@mipmap/ic_launcher',
              ),
              iOS: DarwinNotificationDetails()),
        );
        // List<dynamic> weightData = List();
        // Storage().notification = NotificationModel(
        //         id: notification.hashCode,
        //         title: notification.title ?? '',
        //         body: notification.body ?? '',
        //         date: DateFormatNotificationTimeToString(DateTime.now())
        //             .formatDateToString())
        //     .toMap()
        //     .entries
        //     .toList();
        // print(Storage().notification.toString());
      }
    });
  }

  //GENERAL (Android & iOS)
  void manageNotificationAction() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _controlNotificationNavigation(message.data);
    });
  }

  void _controlNotificationNavigation(Map<String, dynamic> data) {
    print('Data: $data');
    if (data['page'] != null) {
      switch (data['page']) {
        case 'products':
          var productId = data['id'];
          print('Product Id: $productId');
          break;

        case 'settings':
          print('Navigate to settings');
          break;

        case 'profile':
          print('Navigate to Profile');
          break;
      }
    }
  }

  // saveList(List<dynamic> listNeedToSave) {
  //
  //
  //   /// in case there is saved data
  //   if (Storage().notification != null) {
  //     /// create a holder list for the old data
  //     List<dynamic> oldSavedList = jsonDecode(oldSavedData);
  //
  //     /// append the new list to saved one
  //     oldSavedList.addAll(listNeedToSave);
  //
  //     /// save the new collection
  //     return GetStorageServices().saveListWithGetStorage('saveList', oldSavedList);
  //   } else {
  //     /// in case of there is no saved data -- add the new list to storage
  //     return GetStorageServices().saveListWithGetStorage('saveList', listNeedToSave);
  //   }
  // }
}
