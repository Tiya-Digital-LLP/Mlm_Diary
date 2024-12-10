import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/termsand_condition_entity.dart';

class TermsController extends GetxController {
  var isLoading = false.obs;
  var termsAndConditions = TermsandConditionEntity().obs;

  Future<void> fetchTermsAndConditions() async {
    try {
      isLoading.value = true;
      final response = await http
          .get(Uri.parse('${Constants.baseUrl}${Constants.termsandcondition}'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        termsAndConditions.value = TermsandConditionEntity.fromJson(jsonData);
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
