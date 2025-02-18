import 'dart:async';
import 'dart:convert';
import 'package:country_calling_code_picker/country.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/forgotpassword/enter_otp_screen.dart';
import 'package:mlmdiary/generated/forgot_password_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/custom_toast.dart';

class ForgotPasswordController extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;

  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  RxBool emailError = false.obs;
  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;
  RxBool isPasswordTyping = false.obs;
  RxBool isConfirmPasswordTyping = false.obs;
  RxBool isEmailTyping = false.obs;

  RxBool mobileReadOnly = false.obs;
  RxBool isMobileTyping = false.obs;
  RxBool mobileError = false.obs;
  var isLoading = false.obs;

  final Rx<Country?> selectedCountry = Rx<Country?>(null);

  void emailValidation() {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    emailError.value =
        email.value.text.isEmpty || !regex.hasMatch(email.value.text);

    if (emailError.value) {
      isEmailTyping.value = true;
    }
  }

  void mobileValidation() {
    if (selectedCountry.value?.callingCode == '+91') {
      if (mobile.value.text.isEmpty || mobile.value.text.length != 10) {
        mobileError.value = true;
      } else {
        mobileError.value = false;
      }
    } else {
      if (mobile.value.text.isEmpty || mobile.value.text.length < 6) {
        mobileError.value = true;
      } else {
        mobileError.value = false;
      }
    }

    if (mobileError.value) {
      isMobileTyping.value = true;
    }
  }

  Future<void> sendForgotPasswordRequest(
      BuildContext context, String countryCode) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.forgotpassword}'),
        body: {
          'email': email.value.text,
          'mobile': mobile.value.text,
          'countrycode': countryCode,
        },
      );

      if (kDebugMode) {
        // Improved print statements
        print('email: ${email.value.text}');
        print('mobile: ${mobile.value.text}');
        print('countrycode: $countryCode');
      }

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
          showToastverifedborder(
              "Please Check Your Email or Mobile for OTP",
              // ignore: use_build_context_synchronously
              context);

          Get.to(
            () => EnterOTPScreen(
              otp: forgotPasswordEntity.userOtp ?? 0,
              userId: forgotPasswordEntity.userId ?? 0,
              email: email.value.text,
              phone: mobile.value.text,
              countrycode: countryCode,
            ),
          );
        } else {
          showToasterrorborder(
              forgotPasswordEntity.message ?? "Forgot password request failed",
              // ignore: use_build_context_synchronously
              context);
        }
      } else {
        showToasterrorborder(
            "Forgot password request failed: ${response.reasonPhrase}",
            // ignore: use_build_context_synchronously
            context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future verifyForgotPasswordRequest(
      context, String countryCode, String otp, int userId) async {
    if (kDebugMode) {
      print("Start loading");
    }
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.verifyforgotpassword}'),
        body: {
          'email': email.value.text,
          'mobile': mobile.value.text,
          'countrycode': countryCode.toString(),
          'otp': otp.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        ForgotPasswordEntity forgotPasswordEntity =
            ForgotPasswordEntity.fromJson(responseData);
        if (forgotPasswordEntity.result == 1) {
          showToastverifedborder(
              'OTP is Verified. Please Set Password', context);
          Get.offNamed(Routes.resetPassword, arguments: {'userId': userId});
          stopTimer();
        } else {
          showToasterrorborder(
              forgotPasswordEntity.message ?? "Forgot password request failed",
              context);
        }
      } else {
        showToasterrorborder(
            "Forgot password request failed: ${response.reasonPhrase}",
            context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error verifyForgotPasswordRequest: $e');
      }
    } finally {
      if (kDebugMode) {
        print("Stop loading");
      }
      isLoading(false);
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
          Get.toNamed(
            Routes.login,
          );
        } else {
          showToasterrorborder(
              responseData['message'] ?? "Password change failed",
              // ignore: use_build_context_synchronously
              context);
        }
      } else {
        showToasterrorborder(
            "Password change request failed: ${response.reasonPhrase}",
            // ignore: use_build_context_synchronously
            context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  final RxInt timerValue = 30.obs;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    timerValue.value = 30;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
