import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/add_post_comment_entity.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/edit_comment_entity.dart';
import 'package:mlmdiary/generated/follow_user_entity.dart';
import 'package:mlmdiary/generated/get_post_entity.dart';
import 'package:mlmdiary/generated/get_user_post_comment_entity.dart';
import 'package:mlmdiary/generated/my_post_list_entity.dart';
import 'package:mlmdiary/generated/post_bookmark_entity.dart';
import 'package:mlmdiary/generated/post_like_entity.dart';
import 'package:mlmdiary/generated/post_like_list_entity.dart';
import 'package:mlmdiary/generated/profile_bookmark_entity.dart';
import 'package:mlmdiary/generated/user_profile_count_view_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class EditPostController extends GetxController {
  Rx<TextEditingController> comments = TextEditingController().obs;
  var isLoading = false.obs;
  RxList<MyPostListData> myPostList = <MyPostListData>[].obs;
  RxList<PostLikeListData> postLikeList = RxList<PostLikeListData>();
  RxList<GetPostData> getpostList = <GetPostData>[].obs;

  // Post comment
  RxList<GetUserPostCommentData> getCommentList =
      <GetUserPostCommentData>[].obs;
  Rx<TextEditingController> commment = TextEditingController().obs;
  var isEndOfData = false.obs;
  RxString userImage = ''.obs;

  //like
  var likedStatusMap = <int, bool>{};
  var likeCountMap = <int, int>{};

  //bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

  //bookmarkProfile
  var bookmarkProfileStatusMap = <int, bool>{};
  var bookmarkProfileCountMap = <int, int>{};

  //bookmarkProfile
  var followProfileStatusMap = <int, bool>{};
  var followProfileCountMap = <int, int>{};

  @override
  void onInit() {
    super.onInit();
    fetchMyPost();
    fetchPost(1);
  }

  Future<void> addPost(
      {required File? imageFile, required File? videoFile, context}) async {
    isLoading(true);
    String device = Platform.isAndroid ? 'android' : 'ios';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.addpost}'),
        );

        request.fields['device'] = device;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['comments'] = comments.value.text;

        if (imageFile != null && videoFile != null) {
          request.fields['comtype'] = 'Photo';
          request.fields['attachment'] = 'Photo';
        } else if (imageFile != null) {
          request.fields['comtype'] = 'Photo';
          request.fields['attachment'] = 'Photo';
        } else if (videoFile != null) {
          request.fields['comtype'] = 'Video';
          request.fields['attachment'] = 'Video';
        } else {
          request.fields['comtype'] = 'Status';
          request.fields['attachment'] = 'Status';
        }

        if (imageFile != null) {
          request.files.add(
            http.MultipartFile(
              'attechment',
              imageFile.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: 'image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          );
        }

        if (videoFile != null) {
          request.files.add(
            http.MultipartFile(
              'attechment',
              videoFile.readAsBytes().asStream(),
              videoFile.lengthSync(),
              filename: 'video.mp4',
              contentType: MediaType('video', 'mp4'),
            ),
          );
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (jsonBody['status'] == 1) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesChecked,
                height: 35,
              ),
              primaryColor: Colors.green,
              title: Text('$jsonBody'),
            );
            comments.value.clear();
            fetchMyPost();
          } else if (jsonBody['status'] == 0) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesCancel,
                height: 35,
              ),
              primaryColor: Colors.red,
              title: Text('$jsonBody'),
            );
          } else {
            showToasterrorborder(
              'You cannot use Abusive words in Your Comment and Content and We Can’t Post It',
              context,
            );
          }
        } else {
          if (kDebugMode) {
            print(
              "HTTP error: Failed to Add Post. Status code: ${response.statusCode}",
            );
          }
          if (kDebugMode) {
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while Add Post: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchPost(int page, {int? postId}) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getpost}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          // Print the raw response body
          if (kDebugMode) {
            print('Raw Response Body: ${response.body}');
          }

          var data = jsonDecode(response.body);

          // Print the parsed JSON data
          if (kDebugMode) {
            print('Parsed JSON Data: $data');
          }

          var getNewsEntity = GetPostEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getNewsEntity');
          }

          if (getNewsEntity.data != null && getNewsEntity.data!.isNotEmpty) {
            if (page == 1) {
              getpostList.value = getNewsEntity.data!;
            } else {
              getpostList.addAll(getNewsEntity.data!);
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              getpostList.clear();
            }
            isEndOfData(true);
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  // Method to fetch data from API
  Future<void> fetchMyPost({
    int page = 1,
    context,
    int? postId,
  }) async {
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
      // Check internet connection
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        showToasterrorborder("No internet connection", context);
        isLoading.value = false;
        return;
      }

      // Prepare query parameters
      Map<String, String> formData = {
        'api_token': apiToken ?? '',
        'device': device,
        'page': page.toString(),
      };

      if (postId != null) {
        formData['post_id'] = postId.toString();
      }

      // Build URL
      Uri uri = Uri.parse(Constants.baseUrl + Constants.mypost);
      final response = await http.post(uri, body: formData);

      if (response.statusCode == 200) {
        // Parse JSON data
        final Map<String, dynamic> responseData = json.decode(response.body);
        final MyPostListEntity mypostEntity =
            MyPostListEntity.fromJson(responseData);

        if (kDebugMode) {
          print('manage Post data: $responseData');
        }

        // Store ID using SharedPreferences
        final List<MyPostListData> myPostData = mypostEntity.data ?? [];
        if (myPostData.isNotEmpty) {
          final MyPostListData firstPost = myPostData[0];
          final String postId = firstPost.id.toString();
          await prefs.setString('lastPostid', postId);
          if (kDebugMode) {
            print('Last Post ID stored: $postId');
          }

          comments.value.text = firstPost.comments ?? '';
          userImage.value = firstPost.attachmentPath ?? '';
        }

        // Update state with fetched data
        if (page == 1) {
          myPostList.assignAll(mypostEntity.data ?? []);
        } else {
          myPostList.addAll(mypostEntity.data ?? []);
        }
      } else {
        // Handle error response
        showToasterrorborder("Failed to fetch data", context);
      }
    } catch (error) {
      // Handle network or parsing errors
      showToasterrorborder("An error occurred: $error", context);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editPost(
      {required File? imageFile, required File? videoFile, context}) async {
    isLoading(true);
    String device = Platform.isAndroid ? 'android' : 'ios';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String? postId = prefs.getString('lastPostid');

    try {
      var connectivityResult = await Connectivity().checkConnectivity();

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.editpost}'),
        );

        request.fields['device'] = device;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['comments'] = comments.value.text;
        request.fields['postid'] = postId.toString();

        if (kDebugMode) {
          print('postid: $postId');
        }

        if (imageFile != null && videoFile != null) {
          request.fields['comtype'] = 'Photo';
          request.fields['attachment'] = 'Photo';
        } else if (imageFile != null) {
          request.fields['comtype'] = 'Photo';
          request.fields['attachment'] = 'Photo';
        } else if (videoFile != null) {
          request.fields['comtype'] = 'Video';
          request.fields['attachment'] = 'Video';
        } else {
          request.fields['comtype'] = 'Status';
          request.fields['attachment'] = 'Status';
        }

        if (imageFile != null) {
          request.files.add(
            http.MultipartFile(
              'attechment',
              imageFile.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: 'image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          );
        }

        if (videoFile != null) {
          request.files.add(
            http.MultipartFile(
              'attechment',
              videoFile.readAsBytes().asStream(),
              videoFile.lengthSync(),
              filename: 'video.mp4',
              contentType: MediaType('video', 'mp4'),
            ),
          );
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (jsonBody['status'] == 1) {
            final Map<String, dynamic> userPost = jsonBody['userpost'];
            final String postId =
                userPost['postid'].toString(); // Extract postid
            if (kDebugMode) {
              print("Post Added Successfully");
            }
            if (kDebugMode) {
              print("PostID: $postId");
            }
            // You can use postId as needed here

            Get.back();
          } else {
            if (kDebugMode) {
              print("Failed to Add Post: ${jsonBody['message']}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to Add Post. Status code: ${response.statusCode}");
          }
          if (kDebugMode) {
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while Add Post: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  // Delete-Post
  Future<void> deletePost(int postId, int index, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.deletepost}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['postid'] = postId.toString();

        if (kDebugMode) {
          print('Post id from delete Post: $postId');
          print('Post token from delete Post: $apiToken');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];
          var message = data['message'];

          if (status == 1) {
            showToastverifedborder(message, context);
            myPostList.removeAt(index);
          } else {
            if (kDebugMode) {
              print('Failed to delete News: $message');
            }
          }

          if (kDebugMode) {
            print('data from delete News: $data');
          }
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> countViewUserProfile(int userId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.countviewuserprofile}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['user_id'] = userId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var countViewUserProfileEntity =
              UserProfileCountViewEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $countViewUserProfileEntity');
          }
        } else {
          //
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

  //like
  Future<void> likedPost(int postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.postlike}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['post_id'] = postId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var likedPostEntity = PostLikeEntity.fromJson(data);
          var message = likedPostEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have liked this Post') {
            likedStatusMap[postId] = true;
            likeCountMap[postId] = (likeCountMap[postId] ?? 0) + 1;
          } else if (message == 'You have unliked this Post') {
            likedStatusMap[postId] = false;
            likeCountMap[postId] = (likeCountMap[postId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
        } else {
          if (kDebugMode) {
            print("Response body: ${response.body}");
          }
        }
      } else {
        if (kDebugMode) {
          showToasterrorborder("No internet connection available.", context);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleLike(int postId, context) async {
    bool isLiked = likedStatusMap[postId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[postId] = isLiked;
    likeCountMap.update(postId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedPost(postId, context);
  }

  // Bookmark
  Future<void> bookmarkPost(int postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.bookmarkpost}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['post_id'] = postId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkPostEntity = PostBookmarkEntity.fromJson(data);
          var message = bookmarkPostEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this Post') {
            bookmarkStatusMap[postId] = true;
            bookmarkCountMap[postId] = (bookmarkCountMap[postId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this Post') {
            bookmarkStatusMap[postId] = false;
            bookmarkCountMap[postId] = (bookmarkCountMap[postId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
        } else {
          if (kDebugMode) {
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleBookMark(int postId, context) async {
    bool isBookmark = bookmarkStatusMap[postId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[postId] = isBookmark;
    bookmarkCountMap.update(
        postId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await bookmarkPost(postId, context);
  }

  // like_list_blog
  Future<void> fetchLikeListPost(int postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // Log connectivity result
      if (kDebugMode) {
        print('Connectivity result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likelistpost}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['post_id'] = postId.toString();

        // Log request details
        if (kDebugMode) {
          print('Request URL: $uri');
          print('Request fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        // Log response status code
        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        }

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];

          // Log response body
          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          if (status == 1) {
            var postLikeListEntity = PostLikeListEntity.fromJson(data);
            postLikeList.value = postLikeListEntity.data ?? [];

            // Log parsed data
            if (kDebugMode) {
              print('Parsed entity: $postLikeListEntity');
            }
          } else {
            var message = data['message'];

            // Log failure message
            if (kDebugMode) {
              print('Failed to fetch likelist Post: $message');
            }
          }
        } else {
          // Log error response
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      // Log exception
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
      // Log end of method execution
      if (kDebugMode) {
        print('Finished fetchLikeListPost method');
      }
    }
  }

  // Bookmark
  Future<void> profileBookmark(int databaseId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.profileBookmark}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['databse_id'] = databaseId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkProfileEntity = ProfileBookmarkEntity.fromJson(data);
          var message = bookmarkProfileEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this Profile') {
            bookmarkProfileStatusMap[databaseId] = true;
            bookmarkProfileCountMap[databaseId] =
                (bookmarkCountMap[databaseId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this Profile') {
            bookmarkProfileStatusMap[databaseId] = false;
            bookmarkProfileCountMap[databaseId] =
                (bookmarkCountMap[databaseId] ?? 0) - 1;
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

  Future<void> toggleProfileBookMark(int databaseId, context) async {
    bool isBookmark = bookmarkProfileStatusMap[databaseId] ?? false;
    isBookmark = !isBookmark;
    bookmarkProfileStatusMap[databaseId] = isBookmark;
    bookmarkProfileCountMap.update(
        databaseId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await profileBookmark(databaseId, context);
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
                (bookmarkProfileCountMap[userId] ?? 0) + 1;
          } else if (message == 'You have UnFollow this Profile') {
            followProfileStatusMap[userId] = false;
            followProfileCountMap[userId] =
                (bookmarkProfileCountMap[userId] ?? 0) - 1;
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

  // comment for Post
  Future<void> getCommentPost(int page, int postId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getcommentpost}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['post_id'] = postId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getUserPostCommentEntity =
              GetUserPostCommentEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getUserPostCommentEntity');
          }

          if (getUserPostCommentEntity.data != null &&
              getUserPostCommentEntity.data!.isNotEmpty) {
            if (page == 1) {
              getCommentList.value = getUserPostCommentEntity.data!;
            } else {
              getCommentList.addAll(getUserPostCommentEntity.data!);
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              getCommentList.clear();
            }
            isEndOfData(true);
          }
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

  Future<void> addReplyPostComment(int postId, int commentId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.addcommentpostreply}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['post_id'] = postId.toString();
        request.fields['comment_id'] = commentId.toString();
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addPostCommentEntity = AddPostCommentEntity.fromJson(data);
          getCommentPost(1, postId, context);

          if (kDebugMode) {
            print('Success: $addPostCommentEntity');
          }
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

  Future<void> deleteComment(int postId, int commentId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.deletecommment}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['type'] = 'post';
        request.fields['comment_id'] = commentId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          jsonDecode(response.body);
          // Handle success response as needed
          await getCommentPost(1, postId, context);
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

  Future<void> editComment(int postId, int commentId, String newComment,
      String type, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.editcommment}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['comment_id'] = commentId.toString();
        request.fields['type'] = type;
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var editCommentEntity = EditCommentEntity.fromJson(data);
          await getCommentPost(1, postId, context);

          if (kDebugMode) {
            print('Success: $editCommentEntity');
          }
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
}
