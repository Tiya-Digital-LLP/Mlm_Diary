import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_home_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchbarController extends GetxController {
  RxList<GetHomeData> homeList = RxList<GetHomeData>();
  var isEndOfData = false.obs;
  var isLoading = false.obs;
  final search = TextEditingController();
  var selectedType = 'All'.obs;
  final List<String> types = [
    'All',
    'Blog',
    'Database',
    'News',
    'Classified',
    'Post',
    'Company',
    'Question',
    'Video',
  ];

  // GetHomePost
  Future<void> getHome(int page) async {
    isLoading.value = true;
    String device = Platform.isAndroid
        ? 'android'
        : Platform.isIOS
            ? 'ios'
            : '';

    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (error) {
      isLoading.value = false;
      return;
    }

    String? apiToken = prefs.getString(Constants.accessToken);

    // Prepare query parameters
    Map<String, String> queryParams = {
      'api_token': apiToken.toString(),
      'device': device,
      'page': page.toString(),
      'search': search.value.text,
      'type': selectedType.value == 'All' ? '' : selectedType.value,
    };

    try {
      homeList.clear();
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.gethome)
          .replace(queryParameters: queryParams);
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final GetHomeEntity allHomeEntity =
            GetHomeEntity.fromJson(responseData);

        final List<GetHomeData> myHomeData = allHomeEntity.data ?? [];
        if (myHomeData.isNotEmpty) {
          if (page == 1) {
            homeList.assignAll(allHomeEntity.data ?? []);
          } else {
            homeList.addAll(allHomeEntity.data ?? []);
          }

          if (myHomeData.length < 10) {
            isEndOfData.value = true;
          }
        } else {
          isEndOfData.value = true;
        }
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print('Failed to fetch notifications, status code: 401');
        }
        Get.offAllNamed(Routes.login);
      }
    } catch (error) {
      // Handle general error case
    } finally {
      isLoading.value = false;
    }
  }
}
