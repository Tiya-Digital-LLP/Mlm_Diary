import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/all_bookmark_entity.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteController extends GetxController {
  var isLoading = false.obs;
  RxList<AllBookmarkData> favouriteList = RxList<AllBookmarkData>();

  Future<void> fetchBookmark({int page = 1, BuildContext? context}) async {
    isLoading.value = true;
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }

    if (kDebugMode) {
      print('Device Name: $device');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        if (context != null) {
          // ignore: use_build_context_synchronously
          showToasterrorborder("No internet connection", context);
        }
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'api_token': apiToken ?? '',
        'device': device,
        'page': page.toString(),
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.allbookmark)
          .replace(queryParameters: queryParams);
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final AllBookmarkEntity allBookmarkEntity =
            AllBookmarkEntity.fromJson(responseData);

        if (kDebugMode) {
          print('Manage bookmark data: $responseData');
        }

        final List<AllBookmarkData> myBlogData = allBookmarkEntity.data ?? [];
        if (myBlogData.isNotEmpty) {
          final AllBookmarkData bookmark = myBlogData[0];
          final String bookmarkId = bookmark.id.toString();
          await prefs.setString('lastBlogid', bookmarkId);
          if (kDebugMode) {
            print('Last bookmark ID stored: $bookmarkId');
          }

          if (page == 1) {
            favouriteList.assignAll(allBookmarkEntity.data ?? []);
          } else {
            favouriteList.addAll(allBookmarkEntity.data ?? []);
          }
        } else {
          // ignore: use_build_context_synchronously
          if (context != null) showToasterrorborder("No data found", context);
        }
      } else {
        if (context != null) {
          // ignore: use_build_context_synchronously
          showToasterrorborder("Failed to fetch data", context);
        }
      }
    } catch (error) {
      if (context != null) {
        // ignore: use_build_context_synchronously
        showToasterrorborder("An error occurred: $error", context);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
