import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  }

  Future<void> _checkVersionAndNavigate() async {
    final versionCheck = await _versionController.checkVersion();

    if (versionCheck != null) {
      if (versionCheck.success == 1) {
        _navigateToNextScreen();
      } else if (versionCheck.success == 2) {
        _showUpdatePopup(versionCheck.message ?? 'Please update the app.');
      }
    } else {
      _navigateToNextScreen();
    }
  }

  Future<void> _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool(Constants.isLoggedIn) ?? false;

    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        Get.offNamed(Routes.mainscreen);
      } else {
        Get.offNamed(Routes.login);
      }
    });
  }

  void _showUpdatePopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Available'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
