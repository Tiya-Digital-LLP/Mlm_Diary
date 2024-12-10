import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class AddPostController extends GetxController {
  Rx<TextEditingController> comments = TextEditingController().obs;
  var userProfile = GetUserProfileEntity().obs;
  RxString userImage = ''.obs;
  RxString userName = ''.obs;
  RxString iammlm = ''.obs;

  var isLoading = false.obs;
  RxBool postError = false.obs;
  RxBool isPostTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void validateComments(String text) {
    if (text.isEmpty) {
      postError(true);
    } else {
      postError(false);
    }
  }

  Future<void> fetchUserProfile() async {
    isLoading(true);

    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null || apiToken.isEmpty) {
      isLoading(false);

      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.userprofile}'),
        body: {'api_token': apiToken},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userProfileEntity = GetUserProfileEntity.fromJson(responseData);
        userProfile(userProfileEntity);
        userImage.value = userProfileEntity.userProfile!.imagePath ?? '';
        userName.value = userProfileEntity.userProfile!.name ?? '';
        iammlm.value = userProfileEntity.userProfile!.immlm ?? '';

        if (kDebugMode) {
          print('Account Settings Data: $responseData');
        }
      } else {
        if (kDebugMode) {
          print("Error: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
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
              title: Text('${jsonBody['message']}'),
            );

            Get.back();
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
              title: Text('${jsonBody['message']}'),
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
}
