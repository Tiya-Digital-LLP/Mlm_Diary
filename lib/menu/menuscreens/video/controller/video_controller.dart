import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mlmdiary/data/constants.dart';
import 'dart:convert';

import 'package:mlmdiary/generated/get_video_list_entity.dart';

class VideoController extends GetxController {
  var isLoading = false.obs;
  var videoList = <GetVideoListVideos>[].obs;
  var isConnected = true.obs;

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
}
