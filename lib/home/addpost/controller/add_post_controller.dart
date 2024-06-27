import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPostController extends GetxController {
  Rx<TextEditingController> comments = TextEditingController().obs;
  var isLoading = false.obs;

  Future<void> addPost({
    required File? imageFile,
    required File? videoFile,
  }) async {
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

        // Determine comtype and attachment based on image and video files
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
            if (kDebugMode) {
              print("Post Added Successfully");
            }
            if (kDebugMode) {
              print("UserID: ${userPost['userid']}");
            }
            if (kDebugMode) {
              print("PostID: ${userPost['postid']}");
            }
            if (kDebugMode) {
              print("CreateDate: ${userPost['createdate']}");
            }
            if (kDebugMode) {
              print("Comments: ${userPost['comments']}");
            }
            if (kDebugMode) {
              print("ComType: ${userPost['comtype']}");
            }
            if (kDebugMode) {
              print("Attachment: ${userPost['attachment']}");
            }
            if (kDebugMode) {
              print("ID: ${userPost['id']}");
            }
            if (kDebugMode) {
              print("AttachmentPath: ${userPost['attachment_path']}");
            }

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
        showToasterrorborder(
          "No internet connection",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while Add Post: $e");
      }
    } finally {
      isLoading(false);
    }
  }
}
