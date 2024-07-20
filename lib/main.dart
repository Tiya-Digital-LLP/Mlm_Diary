import 'dart:async';
import 'dart:convert'; // Import for JSON encoding
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/maincontroller/main_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:toastification/toastification.dart';
import 'firebase_options.dart'; // Import the Firebase options file

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  }
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the default options for the current platform
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  }
  // Initialize GetX Controller
  Get.put(NavigationController());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final facebookAppEvents = FacebookAppEvents();

  facebookAppEvents.logEvent(name: 'AppStarted');
  if (kDebugMode) {
    print('appstartedbyfacebook');
  }
  runApp(const ToastificationWrapper(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  final DatabaseController databaseController = Get.put(DatabaseController());
  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        _handleNotificationClick(payload);
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      _handleNotificationClick(response.payload);
    });

    _requestAPNSToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(jsonEncode(message.data));
    });

    _checkInitialMessage();
  }

  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationClick(jsonEncode(initialMessage.data));
    }
  }

  Future<void> _requestAPNSToken() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        _getToken();
      }
    } else {
      _getToken();
    }
  }

  Future<void> _getToken() async {
    _firebaseMessaging.getToken().then((token) async {
      if (kDebugMode) {
        print("FCM Token: $token");
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token ?? '');
    });
  }

  void _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

  void navigateToScreen(String routeName, {dynamic arguments}) {
    Future.delayed(const Duration(milliseconds: 200), () {
      Get.toNamed(routeName, arguments: arguments);
    });
  }

  void _handleNotificationClick(String? payload) {
    if (kDebugMode) {
      print('Handling notification click with payload: $payload');
    }
    final data = payload != null ? jsonDecode(payload) : null;

    if (data == null) {
      if (kDebugMode) {
        print('Notification data is null');
      }
      return;
    }

    Timer(const Duration(milliseconds: 500), () async {
      try {
        String key = '';
        Map<String, dynamic> arguments = data;

        if (data['click_action'] == 'FLUTTER_NOTIFICATION_CLICK') {
          key = 'FLUTTER_NOTIFICATION_CLICK';
        } else if (data['action'] == 'some_specific_action') {
          key = 'some_specific_action';
        } else {
          key = '${data['type']}';
        }

        switch (key) {
          case 'FLUTTER_NOTIFICATION_CLICK':
            navigateToScreen(Routes.aboutus);
            break;
          case 'some_specific_action':
            navigateToScreen('/specific_screen', arguments: arguments);
            break;
          case 'Follow':
            if (data['user_id'] == '5500270' &&
                data['post_type'] == 'Profile' &&
                (data['ntype'] == null || data['ntype'].isEmpty)) {
              await databaseController.fetchUserPost(5500270, context);
              navigateToScreen(Routes.userprofilescreen, arguments: arguments);
              if (kDebugMode) {
                print('1');
              }
            } else {
              navigateToScreen(Routes.userprofilescreencopy,
                  arguments: arguments);
              if (kDebugMode) {
                print('2');
              }
            }
            break;
          default:
            navigateToScreen(Routes.userprofilescreencopy,
                arguments: arguments);
            if (kDebugMode) {
              print('3');
            }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error during navigation: $e');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'MLM Diary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
      navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
    );
  }
}
