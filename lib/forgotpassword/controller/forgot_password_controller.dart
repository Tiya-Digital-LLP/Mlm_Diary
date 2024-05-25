import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/forgot_password_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordController extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  RxBool emailError = false.obs;
  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;
  RxBool isPasswordTyping = false.obs;
  RxBool isConfirmPasswordTyping = false.obs;
  RxBool isEmailTyping = false.obs;

  void emailValidation() {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    emailError.value =
        email.value.text.isEmpty || !regex.hasMatch(email.value.text);
  }

  void forgotValidation(BuildContext context) {
    if (email.value.text.isEmpty) {
      showToast("Please Enter Email", context);
    } else {
      sendForgotPasswordRequest(context);
    }
  }

  Future<void> sendForgotPasswordRequest(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.forgotpassword}'),
        body: {
          'email': email.value.text,
        },
      );

      if (kDebugMode) {
        print('Response status code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ForgotPasswordEntity forgotPasswordEntity =
            ForgotPasswordEntity.fromJson(responseData);
        if (forgotPasswordEntity.result == 1) {
          // ignore: use_build_context_synchronously
          showToast("Password reset email sent successfully!", context);
          if (forgotPasswordEntity.userId != null) {
            await saveUserId(forgotPasswordEntity.userId!); // Save userId
          } else {
            showToast(
                // ignore: use_build_context_synchronously
                "User ID is null, cannot save to shared preferences",
                // ignore: use_build_context_synchronously
                context);
          }

          Get.toNamed(
            Routes.otp,
            arguments: {
              'otp': forgotPasswordEntity.userOtp,
              'userId': forgotPasswordEntity.userId,
            },
          );
        } else {
          showToast(
              forgotPasswordEntity.message ?? "Forgot password request failed",
              // ignore: use_build_context_synchronously
              context);
        }
      } else {
        showToast(
            "Forgot password request failed: ${response.reasonPhrase}",
            // ignore: use_build_context_synchronously
            context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showToast("An error occurred: $e", context);
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  void passwordValidation() {
    passwordError.value =
        password.value.text.isEmpty || password.value.text.length <= 5;
  }

  void confirmPasswordValidation() {
    confirmPasswordError.value = confirmPassword.value.text.isEmpty ||
        confirmPassword.value.text.length <= 5 ||
        confirmPassword.value.text != password.value.text;
  }

  Future<void> sendChangePasswordRequest(
      BuildContext context, int userId, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.changepassword}'),
        body: {
          'user_id': userId.toString(),
          'password': newPassword,
        },
      );

      if (kDebugMode) {
        print('body userid: $userId');
      }
      if (kDebugMode) {
        print('body newPassword: $newPassword');
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['result'] == 1) {
          // ignore: use_build_context_synchronously
          showToast("Password changed successfully!", context);
          Get.offNamed(
            Routes.mainscreen,
          );
        } else {
          showToast(
              // ignore: use_build_context_synchronously
              responseData['message'] ?? "Password change failed",
              // ignore: use_build_context_synchronously
              context);
        }
      } else {
        showToast(
            "Password change request failed: ${response.reasonPhrase}",
            // ignore: use_build_context_synchronously
            context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showToast("An error occurred: $e", context);
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
