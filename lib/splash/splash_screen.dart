import 'dart:async';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gtm/gtm.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initGtm();
    logSplashScreenEvent();
    _navigateToNextScreen();
  }

  void logSplashScreenEvent() {
    final facebookAppEvents = FacebookAppEvents();

    // Log the event
    facebookAppEvents.logEvent(
      name: 'SplashScreenView',
    );

    // Print debug message
    if (kDebugMode) {
      print("Logging Facebook event: SplashScreenView");
    }
  }

  Future<void> initGtm() async {
    try {
      final gtm = Gtm.instance;
      gtm.setCustomTagTypes([
        CustomTagType(
          'amplitude',
          handler: (eventName, parameters) {
            if (kDebugMode) {
              print('amplitude!');
              print(eventName);
              print(parameters);
            }
          },
        ),
      ]);
      gtm.push(
        'splash_screen_view',
        parameters: {
          'screen_name': 'SplashScreen',
        },
      );
    } on PlatformException {
      if (kDebugMode) {
        print('exception occurred!');
      }
    }
  }

  Future<void> _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool(Constants.isLoggedIn) ?? false;
    await Future.delayed(const Duration(milliseconds: 500));
    if (isLoggedIn) {
      Get.offAllNamed(Routes.mainscreen);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.white,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + size.height * 0.25,
            ),
            Image.asset(
              Assets.imagesLogo,
            ),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(Assets.imagesSplashImage),
            ),
          ],
        ),
      ),
    );
  }
}
