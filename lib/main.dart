import 'dart:async';
import 'dart:convert';
import 'package:app_links/app_links.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/notificationhandle/notification_handler.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:toastification/toastification.dart';
import 'firebase_options.dart';

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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());

  final ManageNewsController manageNewsController =
      Get.put(ManageNewsController());
  final ManageBlogController manageBlogController =
      Get.put(ManageBlogController());
  final EditPostController editPostController = Get.put(EditPostController());

  final NotificationHandler notificationHandler =
      Get.put(NotificationHandler());

  late AppLinks _appLinks;
  StreamSubscription<Uri?>? _linkStreamSubscription;

  @override
  void initState() {
    super.initState();

    _initializeDeepLinks();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        notificationHandler.handleNotificationClick(payload);
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
      notificationHandler.handleNotificationClick(response.payload);
    });

    _requestAPNSToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationHandler.handleNotificationClick(jsonEncode(message.data));
    });

    _checkInitialMessage();
  }

  Future<void> _initializeDeepLinks() async {
    _appLinks = AppLinks();

    final Uri? initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _navigateToScreen(initialLink);
    }

    _linkStreamSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _navigateToScreen(uri);
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('Error receiving deep link: $error');
      }
      // ignore: use_build_context_synchronously
      showToastverifedborder('Error receiving deep link: $error', context);
    });
  }

  void _navigateToScreen(Uri link) {
    // Print the entire Uri to understand its structure
    if (kDebugMode) {
      debugPrint('Received link: $link');
      debugPrint('Query Parameters: ${link.queryParameters}');
    }

    final String? screen = link.queryParameters['screen'];
    final String? dataString = link.queryParameters['data'];

    // Print the screen and dataString values
    if (kDebugMode) {
      debugPrint('Screen parameter: $screen');
      debugPrint('Data parameter: $dataString');
    }

    if (screen != null && screen.isNotEmpty) {
      if (dataString != null && dataString.isNotEmpty) {
        final int data = int.tryParse(dataString) ?? 0;

        // Print the parsed data value
        if (kDebugMode) {
          debugPrint('Parsed data value: $data');
        }

        if (data != 0) {
          switch (screen) {
            case 'Classified':
              clasifiedController.fetchClassifiedDetail(
                data,
                // ignore: use_build_context_synchronously
                context,
              );
              Get.toNamed(
                Routes.mlmclassifieddetailtest,
                arguments: data,
              );
              break;
            case 'Blog':
              manageBlogController.fetchBlogDetail(
                data,
                // ignore: use_build_context_synchronously
                context,
              );
              Get.toNamed(
                Routes.blogdetailsnotification,
                arguments: data,
              );
              break;

            case 'News':
              manageNewsController.fetchNewsDetail(
                data,
                // ignore: use_build_context_synchronously
                context,
              );
              Get.toNamed(
                Routes.newsdetailsnotification,
                arguments: data,
              );
              break;

            case 'Company':
              Get.toNamed(
                Routes.mlmcompanies,
                arguments: data,
              );
              break;

            case 'Post':
              editPostController.fetchPostDetail(data, context);
              Get.toNamed(
                Routes.postdetailnotification,
                arguments: data,
              );
              break;

            case 'Question':
              Get.toNamed(
                Routes.quationanswer,
                arguments: data,
              );
              break;

            default:
              if (kDebugMode) {
                debugPrint('Unknown screen type: $screen');
              }
          }
        } else {
          if (kDebugMode) {
            debugPrint('Invalid or missing data');
          }
        }
      } else {
        if (kDebugMode) {
          debugPrint('Screen data is missing');
        }
      }
    } else {
      if (kDebugMode) {
        debugPrint('Screen parameter is missing in the deep link');
      }
    }
  }

  @override
  void dispose() {
    _linkStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      notificationHandler
          .handleNotificationClick(jsonEncode(initialMessage.data));
    }
  }

  Future<void> _requestAPNSToken() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      _getToken();
      _subscribeToTopic('mlm');
    } else {
      _getToken();
      _subscribeToTopic('mlm');
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

  Future<void> _subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    if (kDebugMode) {
      print("Subscribed to topic: $topic");
    }
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
      print("Notification sent: ${message.notification?.title}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      // ignore: deprecated_member_use
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: GetMaterialApp(
        title: 'MLM Diary',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: AppColors.background,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        getPages: AppPages.routes,
        navigatorObservers: <NavigatorObserver>[observer],
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
      ),
    );
  }
}
