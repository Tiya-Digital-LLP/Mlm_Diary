import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{

  Rx<TextEditingController> email = TextEditingController().obs;

  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;

  RxBool emailError = false.obs;


  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;

  RxBool isPasswordTyping = false.obs;
  RxBool isConfirmPasswordTyping = false.obs;
  RxBool isEmailTyping = false.obs;

  void passwordValidation() {
    if (password.value.text.isEmpty || password.value.text.length <= 5) {
      passwordError.value = true;
    } else {
      passwordError.value = false;
    }
  }

  void confirmPasswordValidation() {
    if (confirmPassword.value.text.isEmpty ||
        confirmPassword.value.text.length <= 5 ||
        confirmPassword.value.text != password.value.text) {
      confirmPasswordError.value = true;
    } else {
      confirmPasswordError.value = false;
    }
  }

}