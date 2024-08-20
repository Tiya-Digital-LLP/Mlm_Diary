import 'dart:async';
import 'dart:io';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gtm/gtm.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/splash/controller/version_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final VersionController _versionController = Get.put(VersionController());

  @override
  void initState() {
    super.initState();
    _checkVersionAndNavigate();
    initGtm();
    logSplashScreenEvent();
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

  Future<void> _checkVersionAndNavigate() async {
    final versionCheck = await _versionController.checkVersion();

    if (versionCheck != null) {
      if (versionCheck.success == 1) {
        Timer(const Duration(milliseconds: 100), () {
          _navigateToNextScreen();
        });
      } else if (versionCheck.success == 2) {
        // ignore: use_build_context_synchronously
        _showUpdateDialog(context);
      }
    } else {
      Timer(const Duration(milliseconds: 100), () {
        _navigateToNextScreen();
      });
    }
  }

  Future<void> _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool(Constants.isLoggedIn) ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(Routes.mainscreen);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  void _showUpdateDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: AppColors.white,
            insetPadding: const EdgeInsets.all(22.0),
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      Assets.imagesLogo,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Update Available!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'A new version of the app is available. Please update to continue.',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 140,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back();
                            exit(0);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: AppColors.primaryColor),
                        child: TextButton(
                          onPressed: () {
                            if (Platform.isAndroid) {
                              // _openGooglePlayStore();
                            } else if (Platform.isIOS) {
                              // _launchAppStore();
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
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
