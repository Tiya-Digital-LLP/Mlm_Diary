import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/version_check_entity.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionController extends GetxController {
  Future<VersionCheckEntity?> checkVersion() async {
    if (kDebugMode) {
      print('Step 1: Checking internet connectivity...');
    }
    final connectivityResult = await (Connectivity().checkConnectivity());

    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      if (kDebugMode) {
        print('Step 2: No internet connection detected.');
      }
      Get.snackbar('Error', 'No internet connection');
      return null;
    }

    if (kDebugMode) {
      print('Step 2: Internet connection available.');
    }
    try {
      if (kDebugMode) {
        print('Step 3: Retrieving package information...');
      }
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version;
      if (kDebugMode) {
        print('Step 4: Current app version: $version');
      }

      if (kDebugMode) {
        print('Step 5: Sending version check request to server...');
      }
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.versioncheck),
        body: {
          'version': version,
        },
      );

      if (kDebugMode) {
        print('Step 6: Server response status code: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Step 7: Successfully received response from server.');
        }
        return VersionCheckEntity.fromJson(json.decode(response.body));
      } else {
        if (kDebugMode) {
          print(
            'Step 7: Failed to check version. Server responded with status code: ${response.statusCode}');
        }
        Get.snackbar('Error', 'Failed to check version');
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Step 8: An error occurred: $e');
      }
      Get.snackbar('Error', 'An error occurred: $e');
      return null;
    }
  }
}
