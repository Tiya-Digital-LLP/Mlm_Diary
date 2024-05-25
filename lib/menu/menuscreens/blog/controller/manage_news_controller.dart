import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:mlmdiary/utils/lists.dart';

class ManageBlogController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> discription = TextEditingController().obs;
  Rx<TextEditingController> url = TextEditingController().obs;
  var isLiked = false.obs;
  var isBookMarked = false.obs;

  var likeCount = 0.obs;
// FIELDS ERROR

  RxBool titleError = false.obs;
  RxBool discriptionError = false.obs;
  RxBool urlError = false.obs;
  RxBool categoryError = false.obs;
  RxBool subCategoryError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isTitleTyping = false.obs;
  RxBool isDiscriptionTyping = false.obs;
  RxBool isUrlTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxInt selectedCountCategory = 0.obs;

  RxInt selectedCountSubCategory = 0.obs;

  // RxBool isEmailOtpTyping = false.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  void titleValidation() {
    String enteredTitle = title.value.text;
    if (enteredTitle.isEmpty || hasSpecialCharactersOrNumbers(enteredTitle)) {
      // Show toast message for invalid title
      ToastUtils.showToast("Please Enter Title");
      titleError.value = true;
    } else {
      titleError.value = false;
    }
  }

  void mlmCategoryValidation() {
    bool hasSelectedCategory = false;

    for (bool isSelected in isTrueList) {
      if (isSelected) {
        hasSelectedCategory = true;
        break;
      }
    }
    categoryError.value = !hasSelectedCategory;
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
    if (isLiked.value) {
      likeCount.value++;
    } else {
      likeCount.value--;
    }
  }

  void toggleBookMark() {
    isBookMarked.value = !isBookMarked.value;
    if (isBookMarked.value) {
    } else {}
  }

  void mlmsubCategoryValidation() {
    bool hasSelectedSubCategory = false;

    for (bool isSelected in isSubCategoryList) {
      if (isSelected) {
        hasSelectedSubCategory = true;
        break;
      }
    }
    subCategoryError.value = !hasSelectedSubCategory;
  }

  void discriptionValidation() {
    String enteredDiscription = discription.value.text;
    if (enteredDiscription.isEmpty ||
        hasSpecialTextOrNumbers(enteredDiscription)) {
      ToastUtils.showToast("Please Enter Discription");
      discriptionError.value = true;
    } else {
      discriptionError.value = false;
    }
  }

  void urlValidation() {
    String enteredUrl = url.value.text;
    if (enteredUrl.isEmpty || hasSpecialTextOrNumbers(enteredUrl)) {
      urlError.value = true;
    } else {
      urlError.value = false;
    }
  }

  final RxList<bool> isTrueList =
      RxList<bool>(List.generate(mlmList.length, (index) => false));

  final RxList<bool> isCompanyList =
      RxList<bool>(List.generate(mlmList.length, (index) => false));

  final RxList<bool> isSubCategoryList =
      RxList<bool>(List.generate(subCategoryList.length, (index) => false));

  final RxList<bool> isPlanSelectedList =
      RxList<bool>(List.generate(planList.length, (index) => false));

  void toggleSelected(int index) {
    if (isTrueList[index]) {
      selectedCountCategory--;
    } else {
      if (selectedCountCategory < 3) {
        selectedCountCategory++;
      }
    }
    isTrueList[index] = !isTrueList[index];
  }

  void toggleSubCategorySelected(int index) {
    isSubCategoryList[index] = !isSubCategoryList[index];

    if (isSubCategoryList[index]) {
      selectedCountSubCategory++;
    } else {
      selectedCountSubCategory--;
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
        selectedOptions.add(mlmList[i]);
      }
    }

    // Create a TextEditingController with the selected options text
    return TextEditingController(text: selectedOptions.join(', '));
  }

  TextEditingController getSelectedSubCategoryOptionsTextController() {
    List<String> selectedSubCategoryOptions = [];
    for (int i = 0; i < isSubCategoryList.length; i++) {
      if (isSubCategoryList[i]) {
        selectedSubCategoryOptions.add(subCategoryList[i]);
      }
    }

    // Create a TextEditingController with the selected plan options text
    return TextEditingController(text: selectedSubCategoryOptions.join(', '));
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
