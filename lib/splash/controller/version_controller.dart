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
    final connectivityResult = await (Connectivity().checkConnectivity());
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar('Error', 'No internet connection');
      return null;
    }

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version;
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.versioncheck),
        body: {
          'version': version,
        },
      );
      if (kDebugMode) {
        print('Latest version: $version');
      }
      if (response.statusCode == 200) {
        return VersionCheckEntity.fromJson(json.decode(response.body));
      } else {
        Get.snackbar('Error', 'Failed to check version');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return null;
    }
  }
}
