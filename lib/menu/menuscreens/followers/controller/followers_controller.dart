import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/follow_user_entity.dart';
import 'package:mlmdiary/generated/get_followers_entity.dart';
import 'package:mlmdiary/generated/get_following_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowersController extends GetxController {
  //bookmarkProfile
  var followProfileStatusMap = <int, bool>{};
  var followProfileCountMap = <int, int>{};

  var followers = <GetFollowersData>[].obs;
  var following = <GetFollowingData>[].obs;

  final search = TextEditingController();

//loading
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFollowers();
    getFollowing();
  }

  // Follow-Unfollow
  Future<void> profileFollow(int userId) async {
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
          } else if (message == 'You have UnFollow this Profile') {
            followProfileStatusMap[userId] = false;
            followProfileCountMap[userId] =
                (followProfileCountMap[userId] ?? 0) - 1;
          }

          Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Error: ${response.body}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleProfileFollow(int userId) async {
    bool isFollow = followProfileStatusMap[userId] ?? false;
    isFollow = !isFollow;
    followProfileStatusMap[userId] = isFollow;
    followProfileCountMap.update(
        userId, (value) => isFollow ? value + 1 : value - 1,
        ifAbsent: () => isFollow ? 1 : 0);

    await profileFollow(userId);
  }

// Follow-Unfollow
  Future<void> getFollowers() async {
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
          var message = getFollowerEntity.message;
          followers.assignAll(getFollowerEntity.data ?? []);

          if (kDebugMode) {
            print('Followers: ${getFollowerEntity.data}');
          } // Print followers

          Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          } // Print error message
          Fluttertoast.showToast(
            msg: "Error: ${response.body}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        if (kDebugMode) {
          print('No internet connection');
        } // Print no internet connection
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      } // Print exception
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Follow-Unfollow
  Future<void> getFollowing() async {
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
          var message = getFollowingEntity.message;
          following.assignAll(getFollowingEntity.data ?? []);

          if (kDebugMode) {
            print('Following: ${getFollowingEntity.data}');
          } // Print followers

          Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          } // Print error message
          Fluttertoast.showToast(
            msg: "Error: ${response.body}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        if (kDebugMode) {
          print('No internet connection');
        } // Print no internet connection
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      } // Print exception
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}
