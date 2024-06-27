import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/login_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;

  Rx<TextEditingController> password = TextEditingController().obs;
  RxBool emailError = false.obs;
  RxBool mobileError = false.obs;

  RxBool passwordError = false.obs;

  RxBool isEmailTyping = false.obs;
  RxBool isMobileTyping = false.obs;

  RxBool isPasswordTyping = false.obs;

  var isLoading = false.obs;

  void emailValidation() {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp emailRegex = RegExp(emailPattern);

    String mobilePattern = r'^[0-9]{10}$';
    RegExp mobileRegex = RegExp(mobilePattern);

    if (email.value.text.isEmpty || !emailRegex.hasMatch(email.value.text)) {
      emailError.value = true;
    } else {
      emailError.value = false;
    }

    if (mobile.value.text.length != 10 ||
        !mobileRegex.hasMatch(mobile.value.text)) {
      mobileError.value = true;
    } else {
      mobileError.value = false;
    }
  }

  passwordValidation() {
    if (password.value.text.isEmpty || password.value.text.length < 6) {
      passwordError.value = true;
    } else {
      passwordError.value = false;
    }
  }

  void loginValidation(BuildContext context) {
    if (email.value.text.isEmpty && password.value.text.isEmpty) {
      showToasterrorborder(
        "Please Enter Email and \nPassword",
      );
    } else if (email.value.text.isEmpty) {
      showToasterrorborder(
        "Please Enter Email",
      );
    } else if (password.value.text.isEmpty) {
      showToasterrorborder(
        "Please Enter Password",
      );
    } else if (password.value.text.length < 6) {
      showToasterrorborder(
        "Password Must be 6 Character Long",
      );
    } else {
      login(context);
    }
  }

  Future<void> login(BuildContext context) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}${Constants.login}'),
      body: {
        'email': email.value.text,
        'password': password.value.text,
      },
    );

    if (kDebugMode) {
      print('Response status: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      LoginEntity loginEntity = LoginEntity.fromJson(responseData);

      if (loginEntity.result == 1) {
        // Print the entire response including access token
        if (kDebugMode) {
          print('Login successful! Full response: $responseData');
        }

        // Show success toast
        // ignore: use_build_context_synchronously
        showToastverifedborder(
          'Login successful!',
        );
        saveFcm();

        // Store token and user id
        await saveAccessToken(loginEntity.apiToken, loginEntity.userId);

        // Check for redirection
        if (responseData.containsKey('redirect_to_company') &&
            responseData['redirect_to_company'] == true) {
          // Redirect to sign up 2
          Get.offAllNamed(Routes.signUp2);
        } else {
          // Redirect to main screen
          Get.offAllNamed(Routes.mainscreen);
        }
      } else {
        // ignore: use_build_context_synchronously
        showToasterrorborder(
          loginEntity.message ?? "Login failed",
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      showToasterrorborder(
        "Login failed: ${response.reasonPhrase}",
      );
    }
  }

  Future<void> saveFcm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String device = Platform.isAndroid ? 'android' : 'ios';
    int? userId = prefs.getInt('user_id');
    String? fcmToken = prefs.getString('fcm_token');
    String? deviceToken = await generateDeviceToken();

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.savefcm}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['user_id'] = userId.toString();
        request.fields['device_id'] = deviceToken.toString();
        request.fields['device'] = device;
        request.fields['fcm_token'] = fcmToken.toString();

        if (kDebugMode) {
          print('userId: $userId');
          print('deviceId: $deviceToken');
          print('device: $device');
          print('device: $device');
          print('fcmtoken: $fcmToken');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToasterrorborder(
          "No internet connection",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<String?> generateDeviceToken() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceToken;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceToken = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceToken = iosInfo.identifierForVendor;
      } else {
        deviceToken = const Uuid().v4();
      }
    } catch (e) {
      deviceToken = const Uuid().v4();
    }

    return deviceToken;
  }

  Future<void> saveAccessToken(String? token, int? userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessToken, token ?? '');
    await prefs.setInt(Constants.userId, userId ?? 0);
    await prefs.setBool(Constants.isLoggedIn, true);
  }
}
