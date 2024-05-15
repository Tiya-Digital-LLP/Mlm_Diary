import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/utils/lists.dart';

class AccountSeetingController extends GetxController {
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> companyname = TextEditingController().obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  Rx<TextEditingController> about = TextEditingController().obs;
  Rx<TextEditingController> company = TextEditingController().obs;

  RxBool isGenderToggle = true.obs;

// FIELDS ERROR
  RxBool mlmTypeError = false.obs;
  RxBool planTypeError = false.obs;

  // ENABLED TYPING VALIDATION

  RxBool isNameTyping = false.obs;
  RxBool isCompanyNameTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxBool isAboutTyping = false.obs;
  RxBool isAboutCompany = false.obs;

  RxInt selectedCount = 0.obs;
  RxInt selectedCountPlan = 0.obs;

  // RxBool isEmailOtpTyping = false.obs;

  // READ ONLY FIELDS

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
