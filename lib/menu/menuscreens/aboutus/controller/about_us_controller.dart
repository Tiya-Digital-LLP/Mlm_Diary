import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mlmdiary/generated/about_us_entity.dart';
import 'package:mlmdiary/data/constants.dart';

class AboutUsController extends GetxController {
  var isLoading = false.obs;
  var aboutUs = AboutUsEntity().obs;

  Future<void> fetchAboutUs() async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('${Constants.baseUrl}${Constants.aboutus}'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        aboutUs.value = AboutUsEntity.fromJson(jsonData);
      } else {
        throw Exception('Failed to load terms and conditions');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      } // Print the error for debugging
      throw Exception('Failed to load terms and conditions: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
