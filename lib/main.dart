import 'dart:async';
import 'dart:convert'; // Import for JSON encoding
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/maincontroller/main_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/custom_blog_comment.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/custom_news_comment.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/custom_post_comment.dart';
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

  final ManageNewsController manageNewsController =
      Get.put(ManageNewsController());
  final ManageBlogController manageBlogController =
      Get.put(ManageBlogController());
  final EditPostController editPostController = Get.put(EditPostController());

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
        DarwinNotificationDetails(
      sound: 'default',
      badgeNumber: 1,
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

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
    if (kDebugMode) {
      print("Notification sent");
      print("Notification sent: ${message.data}");
    }
  }

  void _handleNotificationClick(String? payload) {
    if (kDebugMode) {
      print('Handling notification click with payload: $payload');
    }

    final data =
        payload != null ? jsonDecode(payload) as Map<String, dynamic>? : null;

    if (data == null) {
      if (kDebugMode) {
        print('Notification data is null');
      }
      return;
    }

    if (kDebugMode) {
      print('Notification data: $data');
    }

    // Ensure proper conversion and structure
    final int postId = int.tryParse(data['post_id'].toString()) ?? 0;
    final int userId = int.tryParse(data['user_id'].toString()) ?? 0;

    if (kDebugMode) {
      print('Notification type: ${data['type']}');
      print('Post ID: $postId');
      print('User ID: $userId');
    }

    Timer(const Duration(milliseconds: 500), () async {
      try {
        String key = '${data['type']}';

        switch (key) {
          case 'classified':
          case 'classified_like':
            if (kDebugMode) {
              print('Navigating to classified with post_id: $postId');
            }
            Get.toNamed(Routes.mlmclassifieddetailcopy, arguments: {
              'id': postId,
            });
            break;

          case 'news':
          case 'news_like':
            if (kDebugMode) {
              print('Navigating to news with post_id: $postId');
            }

            await manageNewsController.getNews(1, newsId: postId);
            Get.toNamed(Routes.newsdetailsnotification, arguments: {
              'id': postId,
            });
            break;

          case 'blog':
          case 'blog_like':
            if (kDebugMode) {
              print('Navigating to blog with post_id: $postId');
            }
            await manageBlogController.getBlog(1, blogid: postId);
            Get.toNamed(Routes.blogdetailsnotification, arguments: {
              'id': postId,
            });
            break;

          case 'user_post':
          case 'user_post_like':
            if (kDebugMode) {
              print('Navigating to post with post_id: $postId');
            }

            Get.toNamed(Routes.postdetailnotification, arguments: {
              'id': postId,
            });
            await editPostController.fetchPost(1, postId: postId);
            break;

          // Follow
          case 'follow_user':
            if (kDebugMode) {
              print('Navigating to follow_user with user_id: $userId');
            }
            Get.toNamed(Routes.userprofilescreen, arguments: {
              'user_id': userId,
            });
            break;

          // Comment
          case 'classified_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialog(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;
          case 'news_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialogNews(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;
          case 'blog_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialogBlog(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;
          case 'post_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialogPost(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;

          default:
            if (kDebugMode) {
              print('Navigated to default screen with data: $data');
            }
        }
      } catch (e, stackTrace) {
        if (kDebugMode) {
          print('Error during navigation: $e');
          print('Stack trace: $stackTrace');
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
