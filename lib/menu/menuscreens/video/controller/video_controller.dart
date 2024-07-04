import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/bookmark_video_entity.dart';
import 'dart:convert';

import 'package:mlmdiary/generated/get_video_list_entity.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoController extends GetxController {
  var isLoading = false.obs;
  var videoList = <GetVideoListVideos>[].obs;
  var isConnected = true.obs;

  //bookmarkProfile
  var bookmarkVideoStatusMap = <int, bool>{};
  var bookmarkVideoCountMap = <int, int>{};

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    fetchVideoList();
  }

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
      Get.snackbar('No Internet', 'Please check your internet connection.');
    }
  }

  Future<void> fetchVideoList() async {
    if (!isConnected.value) return;

    isLoading(true);
    try {
      final response = await http
          .post(Uri.parse('${Constants.baseUrl}${Constants.getvideolist}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var videoListEntity = GetVideoListEntity.fromJson(data);
        videoList.assignAll(videoListEntity.videos ?? []);
        if (kDebugMode) {
          print('videolistdata: $data');
        }
      } else {
        Get.snackbar('Error',
            'Failed to fetch videos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch videos. Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Bookmark
  Future<void> videoBookmark(int videoId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.videoBookmark}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['video_id'] = videoId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkVideoEntity = BookmarkVideoEntity.fromJson(data);
          var message = bookmarkVideoEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this Video') {
            bookmarkVideoStatusMap[videoId] = true;
            bookmarkVideoCountMap[videoId] =
                (bookmarkVideoCountMap[videoId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this Video') {
            bookmarkVideoStatusMap[videoId] = false;
            bookmarkVideoCountMap[videoId] =
                (bookmarkVideoCountMap[videoId] ?? 0) - 1;
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
    }
  }

  Future<void> togglevideoBookMark(int videoId, context) async {
    bool isBookmark = bookmarkVideoStatusMap[videoId] ?? false;
    isBookmark = !isBookmark;
    bookmarkVideoStatusMap[videoId] = isBookmark;
    bookmarkVideoCountMap.update(
        videoId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await videoBookmark(videoId, context);
  }
}
