import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/delete_notification_entity.dart';
import 'package:mlmdiary/generated/get_notification_entity.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  RxList<GetNotificationData> notificationList = RxList<GetNotificationData>();
  var isEndOfData = false.obs;
  var isLoading = false.obs;

  //scrollercontroller
  final ScrollController scrollController = ScrollController();

  String type = '';

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (notificationList.length ~/ 10) + 1;
        fetchNotification(nextPage, type);
      }
    });
  }
  
  Future<void> fetchNotification(int page, String? type) async {
    if (kDebugMode) {
      print('fetchNotification called with page: $page, type: $type');
    }
    isLoading.value = true;

    String device = Platform.isAndroid
        ? 'android'
        : Platform.isIOS
            ? 'ios'
            : '';
    if (kDebugMode) {
      print('Device type: $device');
    }

    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
      if (kDebugMode) {
        print('SharedPreferences obtained successfully');
      }
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
    if (kDebugMode) {
      print('API token: $apiToken');
    }

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }
      if (kDebugMode) {
        print('Internet connection available');
      }

      Map<String, String> queryParams = {
        'api_token': apiToken,
        'device': device,
        'page': page.toString(),
        'notification_type': type ?? '',
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.getnotification)
          .replace(queryParameters: queryParams);
      if (kDebugMode) {
        print('Request URI: $uri');
      }

      final response = await http.post(uri);
      if (kDebugMode) {
        print('Response status code: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print('Response data: $responseData');
        }

        final GetNotificationEntity allBookmarkEntity =
            GetNotificationEntity.fromJson(responseData);

        final List<GetNotificationData> myBlogData =
            allBookmarkEntity.data ?? [];
        if (kDebugMode) {
          print('Notification data received: ${myBlogData.length} items');
        }

        if (myBlogData.isNotEmpty) {
          if (page == 1) {
            notificationList.assignAll(allBookmarkEntity.data ?? []);
            if (kDebugMode) {
              print('Notification list assigned with new data');
            }
          } else {
            notificationList.addAll(allBookmarkEntity.data ?? []);
            if (kDebugMode) {
              print('Notification list appended with new data');
            }
          }

          if (myBlogData.length < 10) {
            isEndOfData.value = true;
            if (kDebugMode) {
              print('End of data reached');
            }
          }
        } else {
          isEndOfData.value = true;
          if (kDebugMode) {
            print('No new notifications');
          }
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
      if (kDebugMode) {
        print('Loading state set to false');
      }
    }
  }

  Future<void> deleteNotification(
      int notificationId, context, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (kDebugMode) {
        print('Connectivity Result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.deletenotification}');
        if (kDebugMode) {
          print('Delete Notification URI: $uri');
        }

        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['notification_id'] = notificationId.toString();
        request.fields['type'] = type;

        if (kDebugMode) {
          print('Request Fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (kDebugMode) {
          print('Response Status Code: ${response.statusCode}');
        }
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var deleteNotificationEntity =
              DeleteNotificationEntity.fromJson(data);
          var message = deleteNotificationEntity.message;

          if (kDebugMode) {
            print('Delete Notification Response: $message');
          }
          showToastverifedborder(message!, context);
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
      if (kDebugMode) {
        print('isLoading set to false');
      }
    }
  }
}
