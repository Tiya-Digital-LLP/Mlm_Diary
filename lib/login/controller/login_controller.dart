import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/login_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        context,
      );
    } else if (email.value.text.isEmpty) {
      showToasterrorborder(
        "Please Enter Email",
        context,
      );
    } else if (password.value.text.isEmpty) {
      showToasterrorborder(
        "Please Enter Password",
        context,
      );
    } else if (password.value.text.length < 6) {
      showToasterrorborder(
        "Password Must be 6 Character Long",
        context,
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
        showToastverifedborder('Login successful!', context);

        // Store token
        await saveAccessToken(loginEntity.apiToken);

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
        showToasterrorborder(loginEntity.message ?? "Login failed", context);
      }
    } else {
      // ignore: use_build_context_synchronously
      showToasterrorborder("Login failed: ${response.reasonPhrase}", context);
    }
  }

  Future<void> saveAccessToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessToken, token ?? '');
    await prefs.setBool(Constants.isLoggedIn, true);
  }
}
