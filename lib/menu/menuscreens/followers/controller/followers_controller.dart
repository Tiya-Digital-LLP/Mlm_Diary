import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/follow_user_entity.dart';
import 'package:mlmdiary/generated/get_followers_entity.dart';
import 'package:mlmdiary/generated/get_following_entity.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowersController extends GetxController {
  // Bookmark profile
  var followProfileStatusMap = <int, bool>{}.obs;
  var followProfileCountMap = <int, int>{}.obs;
  var isEndOfData = false.obs;

  var followers = <GetFollowersData>[].obs;
  var following = <GetFollowingData>[].obs;
  var followersCount = 0.obs;
  var followingCount = 0.obs;
  final ScrollController scrollController = ScrollController();

  final search = TextEditingController();

  // Loading
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (followers.length ~/ 10) + 1;
        getFollowers(nextPage);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (following.length ~/ 10) + 1;
        getFollowing(nextPage);
      }
    });
  }

  // Follow-Unfollow
  Future<void> profileFollow(int userId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.profileFollow}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['user_id'] = userId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var followProfileEntity = FollowUserEntity.fromJson(data);
          var message = followProfileEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have Follow this Profile') {
            followProfileStatusMap[userId] = true;
            followProfileCountMap[userId] =
                (followProfileCountMap[userId] ?? 0) + 1;
            followersCount.value += 1;
          } else if (message == 'You have UnFollow this Profile') {
            followProfileStatusMap[userId] = false;
            followProfileCountMap[userId] =
                (followProfileCountMap[userId] ?? 0) - 1;
            followersCount.value -= 1;
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

  Future<void> toggleProfileFollow(int userId, context) async {
    bool isFollow = followProfileStatusMap[userId] ?? false;
    isFollow = !isFollow;
    followProfileStatusMap[userId] = isFollow;
    followProfileCountMap.update(
        userId, (value) => isFollow ? value + 1 : value - 1,
        ifAbsent: () => isFollow ? 1 : 0);

    await profileFollow(userId, context);
  }

  // Follow-Unfollow
  Future<void> getFollowers(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    int? userId = prefs.getInt('user_id');
    String device = Platform.isAndroid ? 'android' : 'ios';

    if (kDebugMode) {
      print('Fetching followers for user ID: $userId');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getFollowers}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['user_id'] = userId.toString();
        request.fields['search'] = search.value.text;
        request.fields['page'] = page.toString();

        if (kDebugMode) {
          print('Sending request to: ${uri.toString()}');
        } // Print request URL

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        } // Print status code

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (kDebugMode) {
            print('Response data: $data');
          } // Print response data

          var getFollowerEntity = GetFollowersEntity.fromJson(data);

          if (getFollowerEntity.data != null &&
              getFollowerEntity.data!.isNotEmpty) {
            followers.addAll(getFollowerEntity.data!);
            followersCount.value = getFollowerEntity.followersCount ?? 0;
            followingCount.value = getFollowerEntity.followingCount ?? 0;
            isEndOfData(false); // More data is available
          } else {
            isEndOfData(true); // No more data available
          }

          if (kDebugMode) {
            print('Followers: ${getFollowerEntity.data}');
          } // Print followers
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          } // Print error message
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  // Follow-Unfollow
  Future<void> getFollowing(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    int? userId = prefs.getInt('user_id');
    String device = Platform.isAndroid ? 'android' : 'ios';

    if (kDebugMode) {
      print('Fetching followers for user ID: $userId');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getFollowing}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['user_id'] = userId.toString();
        request.fields['search'] = search.value.text;
        request.fields['page'] = page.toString();

        if (kDebugMode) {
          print('Sending request to: ${uri.toString()}');
        } // Print request URL

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        } // Print status code

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (kDebugMode) {
            print('Response data: $data');
          } // Print response data

          var getFollowingEntity = GetFollowingEntity.fromJson(data);

          if (getFollowingEntity.data != null &&
              getFollowingEntity.data!.isNotEmpty) {
            following.addAll(getFollowingEntity.data!);
            isEndOfData(false); // More data is available
          } else {
            isEndOfData(true); // No more data available
          }

          if (kDebugMode) {
            print('Following: ${getFollowingEntity.data}');
          } // Print followers
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          } // Print error message
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      } // Print exception
    } finally {
      isLoading(false);
    }
  }
}
