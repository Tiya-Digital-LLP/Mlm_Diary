import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_followers_entity.dart';
import 'package:mlmdiary/generated/get_following_entity.dart';
import 'package:mlmdiary/generated/get_user_all_post_entity.dart';
import 'package:mlmdiary/generated/get_views_entity.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {
  RxList<GetUserAllPostData> postallList = <GetUserAllPostData>[].obs;
  var followers = <GetFollowersData>[].obs;
  var following = <GetFollowingData>[].obs;
  var views = <GetViewsData>[].obs;

  var isLoading = false.obs;
  var isEndOfData = false.obs;

  Future<void> getViews(int page, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    if (kDebugMode) {
      print('Fetching followers for user ID: $userId');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getViews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['user_id'] = userId.toString();
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

          var getViewsEntity = GetViewsEntity.fromJson(data);

          if (getViewsEntity.data.isNotEmpty) {
            views.addAll(getViewsEntity.data);

            isEndOfData(false); // More data is available
          } else {
            isEndOfData(true); // No more data available
          }

          if (kDebugMode) {
            print('GetViews: ${getViewsEntity.data}');
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

  Future<void> getFollowers(int page, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
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
  Future<void> getFollowing(int page, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
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

  var selectedType = 'All'.obs;
  final List<String> types = [
    'All',
    'blog',
    'database',
    'news',
    'classified',
    'post',
    'company',
    'question',
    'video',
  ];

  int getItemLikes(
    String type,
    int homeId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.likeCountMap[homeId] ?? 0;
    } else if (type == 'news') {
      return manageNewsController.likeCountMap[homeId] ?? 0;
    } else if (type == 'classified') {
      return classifiedController.likeCountMap[homeId] ?? 0;
    } else if (type == 'question') {
      return questionAnswerController.likeCountMap[homeId] ?? 0;
    } else if (type == 'post') {
      return editpostController.likeCountMap[homeId] ?? 0;
    }
    return 0;
  }

  void toggleLike(
    String type,
    int homeId,
    context,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      manageBlogController.toggleLike(homeId, context);
    } else if (type == 'news') {
      manageNewsController.toggleLike(homeId, context);
    } else if (type == 'classified') {
      classifiedController.toggleLike(homeId, context);
    } else if (type == 'question') {
      questionAnswerController.toggleLike(homeId, context);
    } else if (type == 'post') {
      editpostController.toggleLike(homeId, context);
    }
  }

  // BookMark

  bool isItemBookmark(
    String type,
    int homeId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'news') {
      return manageNewsController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'classified') {
      return classifiedController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'database') {
      return editPostController.bookmarkProfileStatusMap[homeId] ?? false;
    } else if (type == 'question') {
      return questionAnswerController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'post') {
      return editPostController.bookmarkStatusMap[homeId] ?? false;
    }
    return false;
  }

  int getItemBookmark(
    String type,
    int homeId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'news') {
      return manageNewsController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'classified') {
      return classifiedController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'database') {
      return editPostController.bookmarkProfileCountMap[homeId] ?? 0;
    } else if (type == 'question') {
      return questionAnswerController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'post') {
      return editPostController.bookmarkCountMap[homeId] ?? 0;
    }
    return 0;
  }

  void toggleBookmark(
    String type,
    int homeId,
    context,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      manageBlogController.toggleBookMark(homeId, context);
    } else if (type == 'news') {
      manageNewsController.toggleBookMark(homeId, context);
    } else if (type == 'classified') {
      classifiedController.toggleBookMark(homeId, context);
    } else if (type == 'database') {
      editPostController.toggleProfileBookMark(homeId, context);
    } else if (type == 'question') {
      questionAnswerController.toggleBookMark(homeId, context);
    } else if (type == 'post') {
      editpostController.toggleBookMark(homeId, context);
    }
  }

  Future<void> fetchUserAllPost(int page, String userId) async {
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

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'api_token': apiToken.toString(),
        'device': device,
        'page': page.toString(),
        'user_id': userId.toString(),
      };

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('page: $page');
        print('user_id: $userId');
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.userallpost)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final GetUserAllPostEntity allpostEntity =
            GetUserAllPostEntity.fromJson(responseData);
        if (kDebugMode) {
          print('responcedata: $responseData');
        }

        final List<GetUserAllPostData> newData = allpostEntity.data ?? [];
        if (newData.isNotEmpty) {
          if (page == 1) {
            postallList.clear(); // Clear existing data for new user
          }
          postallList.addAll(newData);
          isEndOfData.value = newData.length < 10;
        } else {
          if (page == 1) {
            postallList.clear();
          }
          isEndOfData.value = true;
        }
      }
    } catch (error) {
      // Handle errors appropriately
    } finally {
      isLoading.value = false;
    }
  }
}
