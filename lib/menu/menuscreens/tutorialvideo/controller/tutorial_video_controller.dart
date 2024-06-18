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

  Future<void> fetchVideo(String position) async {
    isLoading.value = true;

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'position': position,
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.tutorialVideo)
          .replace(queryParameters: queryParams);
      final response = await http.post(uri);

      // Log full response details
      if (kDebugMode) {
        print('Request URI: ${uri.toString()}');
        print('Request headers: ${response.request!.headers}');
        print('Response status code: ${response.statusCode}');
        print('Response headers: ${response.headers}');
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == 1) {
          var videoData = jsonResponse['data'];

          // Clear existing videoList before adding new videos
          videoList.clear();

          // If videoData is a list of objects, iterate and add each to videoList
          if (videoData is List) {
            videoList.addAll(videoData.map((data) =>
                GetTutorialVideoData.fromJson(data as Map<String, dynamic>)));
          } else if (videoData is Map<String, dynamic>) {
            // If videoData is a single object, create GetTutorialVideoData object
            var tutorialVideoData = GetTutorialVideoData.fromJson(videoData);
            videoList.add(tutorialVideoData);
          }

          // Print all items in videoList
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
