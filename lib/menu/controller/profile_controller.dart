import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var userProfile = GetUserProfileEntity().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading(true);

    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null || apiToken.isEmpty) {
      // Handle the case where there is no token
      isLoading(false);
      Get.snackbar('Error', 'No API token found');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.userprofile}'),
        body: {
          'api_token': apiToken,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Print all user profile data
        if (kDebugMode) {
          print('User Profile Data:');
        }
        responseData.forEach((key, value) {
          if (kDebugMode) {
            print('$key: $value');
          }
        });

        // Parse response data into entity
        final userProfileEntity = GetUserProfileEntity.fromJson(responseData);

        // Set userProfile state
        userProfile(userProfileEntity);
      } else {
        Get.snackbar('Error', 'Failed to fetch user profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching user profile');
    } finally {
      isLoading(false);
    }
  }
}
