import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/common_toast.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  RxBool emailError = false.obs;
  RxBool passwordError = false.obs;

  RxBool isEmailTyping = false.obs;
  RxBool isPasswordTyping = false.obs;

  emailValidation() {
    if (email.value.text.isEmpty) {
      emailError.value = true;
    } else {
      emailError.value = false;
    }
  }

  passwordValidation() {
    if (password.value.text.isEmpty || password.value.text.length < 6) {
      passwordError.value = true;
    } else {
      passwordError.value = false;
    }
  }

  void loginValidation() {
    if (email.value.text.isEmpty && password.value.text.isEmpty) {
      ToastUtils.showToast("Please Enter Email and Password");
    } else if (email.value.text.isEmpty) {
      ToastUtils.showToast("Please Enter Email");
    } else if (password.value.text.isEmpty) {
      ToastUtils.showToast("Please Enter Password");
    } else if (password.value.text.length < 6) {
      ToastUtils.showToast("Password Must be 6 Character Long");
    } else {
      Get.offAllNamed(Routes.mainscreen);
    }
  }

  void login(context) {
    email.value.clear();
    password.value.clear();
  }
}
