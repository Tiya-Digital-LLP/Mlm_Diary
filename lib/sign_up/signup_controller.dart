import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/utils/email_validator.dart';
import 'package:mlmdiary/utils/lists.dart';

class SignupController extends GetxController {
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;
  Rx<TextEditingController> mobileOtp = TextEditingController().obs;
  Rx<TextEditingController> emailOtp = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<TextEditingController> companyName = TextEditingController().obs;
  Rx<TextEditingController> plan = TextEditingController().obs;
  Rx<TextEditingController> location = TextEditingController().obs;

  File? imageFile;
  String? fileName;
  RxBool isGenderToggle = true.obs;

  RxBool termsCondition = false.obs;

  RxBool mobileOtpSend = false.obs;
  RxBool emailOtpSend = false.obs;
  RxBool showEmailField = false.obs;
  RxBool showPasswordField = false.obs;

// FIELDS ERROR
  RxBool mlmTypeError = false.obs;
  RxBool planTypeError = false.obs;

  RxBool nameError = false.obs;
  RxBool comapnyNameError = false.obs;
  RxBool locationError = false.obs;

  RxBool mobileError = false.obs;
  RxBool emailError = false.obs;
  RxBool mobileOtpError = false.obs;
  RxBool emailOtpError = false.obs;
  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isNameTyping = false.obs;
  RxBool isCompanyNameTyping = false.obs;
  RxBool isLocationTyping = false.obs;

  RxBool isMobileTyping = false.obs;
  RxBool isMobileOtpTyping = false.obs;
  RxBool isEmailTyping = false.obs;
  RxBool isEmailOtpTyping = false.obs;
  RxBool isPasswordTyping = false.obs;
  RxBool isConfirmPasswordTyping = false.obs;

  RxInt selectedCount = 0.obs;
  RxInt selectedCountPlan = 0.obs;

  // RxBool isEmailOtpTyping = false.obs;

  // READ ONLY FIELDS
  RxBool nameReadOnly = false.obs;
  RxBool companyNameOnly = false.obs;
  RxBool mobileReadOnly = false.obs;
  RxBool emailReadOnly = false.obs;

  void mlmCategoryValidation() {
    bool hasSelectedCategory = false;

    for (bool isSelected in isTrueList) {
      if (isSelected) {
        hasSelectedCategory = true;
        break;
      }
    }
    mlmTypeError.value = !hasSelectedCategory;
  }

  void planCategoryValidation() {
    bool hasPlanCategory = false;

    for (bool isSelected in isTrueList) {
      if (isSelected) {
        hasPlanCategory = true;
        break;
      }
    }
    planTypeError.value = !hasPlanCategory;
  }

  void nameValidation() {
    String enteredName = name.value.text;
    if (enteredName.isEmpty || hasSpecialCharactersOrNumbers(enteredName)) {
      nameError.value = true;
    } else {
      nameError.value = false;
    }
  }

  void companyNameValidation() {
    String enteredcompanyName = companyName.value.text;
    if (enteredcompanyName.isEmpty ||
        hasSpecialCharactersOrNumbers(enteredcompanyName)) {
      comapnyNameError.value = true;
    } else {
      comapnyNameError.value = false;
    }
  }

  void locationValidation() {
    String enteredLocation = location.value.text;
    if (enteredLocation.isEmpty ||
        hasSpecialCharactersOrNumbers(enteredLocation)) {
      locationError.value = true;
    } else {
      locationError.value = false;
    }
  }

  void mobileValidation() {
    if (mobile.value.text.isEmpty || mobile.value.text.length <= 6) {
      mobileError.value = true;
    } else {
      mobileError.value = false;
    }
  }

  void mobileOtpValidation() {
    if (mobileOtp.value.text.isEmpty || mobileOtp.value.text.length < 6) {
      mobileOtpError.value = true;
    } else {
      mobileOtpError.value = false;
    }
  }

  void emailValidation() {
    final bool isValid = EmailValidator.validate(email.value.text);

    if (isValid == false) {
      emailError.value = true;
    } else {
      emailError.value = false;
    }
  }

  void emailOtpValidation() {
    if (emailOtp.value.text.isEmpty || emailOtp.value.text.length < 6) {
      emailOtpError.value = true;
    } else {
      emailOtpError.value = false;
    }
  }

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

  bool hasSpecialCharactersOrNumbers(String text) {
    RegExp specialCharOrNumber = RegExp(r'[!@#\$&*()]|[0-9]');
    return specialCharOrNumber.hasMatch(text);
  }

  final RxList<bool> isTrueList =
      RxList<bool>(List.generate(mlmList.length, (index) => false));

  final RxList<bool> isPlanSelectedList =
      RxList<bool>(List.generate(planList.length, (index) => false));

  void toggleSelected(int index) {
    if (isTrueList[index]) {
      selectedCount--;
    } else {
      if (selectedCount < 3) {
        selectedCount++;
      }
    }
    isTrueList[index] = !isTrueList[index];
  }

  void togglePlanSelected(int index) {
    // Toggle the selection status
    isPlanSelectedList[index] = !isPlanSelectedList[index];

    // Update selectedCount based on the toggled status
    if (isPlanSelectedList[index]) {
      // If the item is selected, increment selectedCount
      selectedCountPlan++;
    } else {
      // If the item is deselected, decrement selectedCount
      selectedCountPlan--;
    }
  }

  TextEditingController getSelectedOptionsTextController() {
    List<String> selectedOptions = [];
    for (int i = 0; i < isTrueList.length; i++) {
      if (isTrueList[i]) {
        selectedOptions.add(mlmList[i]);
      }
    }

    // Create a TextEditingController with the selected options text
    return TextEditingController(text: selectedOptions.join(', '));
  }

  TextEditingController getSelectedPlanOptionsTextController() {
    List<String> selectedPlanOptions = [];
    for (int i = 0; i < isPlanSelectedList.length; i++) {
      if (isPlanSelectedList[i]) {
        selectedPlanOptions.add(planList[i]);
      }
    }

    // Create a TextEditingController with the selected plan options text
    return TextEditingController(text: selectedPlanOptions.join(', '));
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
