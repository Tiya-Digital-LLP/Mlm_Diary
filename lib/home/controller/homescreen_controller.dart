import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_banner_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mlmdiary/generated/notification_count_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends GetxController {
  RxBool isSearchBarVisible = false.obs;
  RxList<GetBannerData> banners = RxList<GetBannerData>();
  late WebViewController webController;
  RxBool isload = true.obs;
  var isEndOfData = false.obs;
  var isLoading = false.obs;
  String type = '';
  RxInt notificationCount = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    fetchNotificationCount(1, 'all');
    ever(isload, (_) {
      if (isload.value) {
        fetchBanners();
      }
    });
  }

  void toggleSearchBarVisibility() {
    isSearchBarVisible.value = !isSearchBarVisible.value;
  }

  Future<void> fetchBanners() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        return;
      }

      final response = await http.get(
        Uri.parse('${Constants.baseUrl}${Constants.getbanner}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            jsonDecode(response.body) as Map<String, dynamic>;

        if (responseBody['status'] == '1') {
          final List<dynamic> jsonData = responseBody['data'];
          final List<GetBannerData> bannerDataList = jsonData.map((data) {
            return GetBannerData.fromJson(data as Map<String, dynamic>);
          }).toList();

          banners.assignAll(bannerDataList);

          for (var banner in banners) {
            if (kDebugMode) {
              print('Banner ID: ${banner.id}');
              print('Title: ${banner.title}');
              print('Web Link: ${banner.weblink}');
            }
          }

          // Initialize webController here
          webController = WebViewController();
        } else {
          if (kDebugMode) {
            print('Failed to load banners: ${response.statusCode}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to load banners: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading banners: $e');
      }
    }
  }

  Future<void> fetchNotificationCount(int page, String? type) async {
    if (kDebugMode) {
      print('fetchNotificationCount called with page: $page, type: $type');
    }
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
      if (kDebugMode) {
        print('Error obtaining SharedPreferences: $error');
      }
      isLoading.value = false;
      return;
    }

    String? apiToken = prefs.getString(Constants.accessToken);
    if (apiToken == null) {
      if (kDebugMode) {
        print('API token is null');
      }
      isLoading.value = false;
      return;
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'api_token': apiToken,
        'device': device,
        'page': page.toString(),
        'notification_type': type ?? '',
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.notificationcount)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print('Response data: $responseData');
        }

        // Parse JSON response into NotificationCountEntity
        NotificationCountEntity notificationCountEntity =
            NotificationCountEntity.fromJson(responseData);

        // Update notification count
        notificationCount.value =
            notificationCountEntity.notificationCount ?? 0;
        update(); // Notify GetX that a change occurred
        if (kDebugMode) {
          print(
              'Notification Count: ${notificationCountEntity.notificationCount}');
        }
      } else {
        if (kDebugMode) {
          print(
              'Failed to fetch notifications, status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching notifications: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
