import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mlmdiary/utils/lists.dart';

class FilterController extends GetxController {
  Rx<TextEditingController> location = TextEditingController().obs;

// FIELDS ERROR

  RxBool locationError = false.obs;
  RxBool companyError = false.obs;
  RxBool planTypeError = false.obs;
  RxBool userTypeError = false.obs;

  // ENABLED TYPING VALIDATION

  RxBool isLocationTyping = false.obs;
  RxInt selectedCountCompany = 0.obs;
  RxInt selectedCountPlan = 0.obs;
  RxInt selectedUserType = 0.obs;

  // RxBool isEmailOtpTyping = false.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  void planCategoryValidation() {
    bool hasPlanCategory = false;

    for (bool isSelected in isPlanSelectedList) {
      if (isSelected) {
        hasPlanCategory = true;
        break;
      }
    }
    planTypeError.value = !hasPlanCategory;
  }

  void mlmsubCompanyValidation() {
    bool hasSelectedCompany = false;

    for (bool isSelected in isCompanyList) {
      if (isSelected) {
        hasSelectedCompany = true;
        break;
      }
    }
    companyError.value = !hasSelectedCompany;
  }

  void userTypeValidation() {
    bool hasUserType = false;

    for (bool isSelected in isUserTypeList) {
      if (isSelected) {
        hasUserType = true;
        break;
      }
    }
    userTypeError.value = !hasUserType;
  }

  void locationValidation() {
    String enteredLocation = location.value.text;
    if (enteredLocation.isEmpty || hasSpecialTextOrNumbers(enteredLocation)) {
      locationError.value = true;
    } else {
      locationError.value = false;
    }
  }

  final RxList<bool> isCompanyList =
      RxList<bool>(List.generate(companyList.length, (index) => false));

  final RxList<bool> isPlanSelectedList =
      RxList<bool>(List.generate(planList.length, (index) => false));

  final RxList<bool> isUserTypeList =
      RxList<bool>(List.generate(userTypeList.length, (index) => false));

  void toggleCompanySelected(int index) {
    isCompanyList[index] = !isCompanyList[index];

    if (isCompanyList[index]) {
      // If the item is selected, increment selectedCount
      selectedCountCompany++;
    } else {
      // If the item is deselected, decrement selectedCount
      selectedCountCompany--;
    }
  }

  void toggleUserTypeSelected(int index) {
    isUserTypeList[index] = !isUserTypeList[index];

    if (isUserTypeList[index]) {
      // If the item is selected, increment selectedCount
      selectedUserType++;
    } else {
      // If the item is deselected, decrement selectedCount
      selectedUserType--;
    }
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

  TextEditingController getSelectedCompanyTextController() {
    List<String> selectedOptions = [];
    for (int i = 0; i < isCompanyList.length; i++) {
      if (isCompanyList[i]) {
        selectedOptions.add(companyList[i]);
      }
    }

    // Create a TextEditingController with the selected options text
    return TextEditingController(text: selectedOptions.join(', '));
  }

  TextEditingController getSelectedUserTypeTextController() {
    List<String> selectedOptions = [];
    for (int i = 0; i < isUserTypeList.length; i++) {
      if (isUserTypeList[i]) {
        selectedOptions.add(userTypeList[i]);
      }
    }

    // Create a TextEditingController with the selected options text
    return TextEditingController(text: selectedOptions.join(', '));
  }

  bool hasSpecialCharactersOrNumbers(String text) {
    RegExp specialCharOrNumber = RegExp(r'[!@#\$&*()]|[0-9]');
    return specialCharOrNumber.hasMatch(text);
  }

  bool hasSpecialTextOrNumbers(String text) {
    RegExp alphanumericRegex = RegExp(r'[a-zA-Z0-9]');
    return !alphanumericRegex.hasMatch(text);
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
