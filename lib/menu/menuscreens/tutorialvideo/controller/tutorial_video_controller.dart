import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_tutorial_video_entity.dart';

class TutorialVideoController extends GetxController {
  var isLoading = false.obs;
  RxList<GetTutorialVideoData> videoList = RxList<GetTutorialVideoData>();
  var isEndOfData = false.obs;

  Future<void> fetchVideo(String? position) async {
    isLoading.value = true;

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {};
      if (position != null && position.isNotEmpty) {
        queryParams['position'] = position;
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.tutorialVideo)
          .replace(queryParameters: queryParams);
      final response = await http.post(uri);

      if (kDebugMode) {
        print('Request URI: ${uri.toString()}');
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null && jsonResponse['success'] == 1) {
          var videoData = jsonResponse['data'];

          videoList.clear();

          if (videoData is List) {
            videoList.addAll(videoData.map((data) =>
                GetTutorialVideoData.fromJson(data as Map<String, dynamic>)));
          } else if (videoData is Map<String, dynamic>) {
            var tutorialVideoData = GetTutorialVideoData.fromJson(videoData);
            videoList.add(tutorialVideoData);
          }

          if (kDebugMode) {
            print('Fetched ${videoList.length} videos:');
            for (var video in videoList) {
              print(video.toJson());
            }
          }
        } else {
          var message = jsonResponse['message'];
          if (kDebugMode) {
            print('Error fetching videos: $message');
          }
        }
      } else {
        if (kDebugMode) {
          print('HTTP Error ${response.statusCode}: ${response.reasonPhrase}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching videos: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
