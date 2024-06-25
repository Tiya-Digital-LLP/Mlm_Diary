import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_messaging/firebase_messaging.dart'; // Import Firebase Messaging
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Initialize Firebase Messaging instance
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  MyApp({super.key}) {
    // Initialize FCM token retrieval
    _firebaseMessaging.getToken().then((token) async {
      if (kDebugMode) {
        print("FCM Token: $token");
      }
      // Save token to shared_preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token ?? '');
    });

    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Message received: ${message.notification?.title}");
      }
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling a background message: ${message.notification?.title}");
    }
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
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
    );
  }
}
