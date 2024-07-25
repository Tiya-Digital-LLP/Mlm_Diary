import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';

import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class NewsController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> discription = TextEditingController().obs;
  Rx<TextEditingController> url = TextEditingController().obs;
  var isLiked = false.obs;
  var isBookMarked = false.obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);
  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);

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
  RxBool isCategoryTyping = false.obs;
  RxBool isSubCategoryTyping = false.obs;

  RxInt selectedCountSubCategory = 0.obs;

  // RxBool isEmailOtpTyping = false.obs;

  var isLoading = false.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
  }

  Future<void> addNews({required File? imageFile, context}) async {
    isLoading(true);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.news}'),
        );

        // Add fields
        request.fields['device'] = device;
        request.fields['title'] = title.value.text;
        request.fields['description'] = discription.value.text;
        request.fields['category'] = getSelectedCategoryTextController().text;
        request.fields['subcategory'] =
            getSelectedSubCategoryTextController().text;
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';

        // Add image file if provided, or dummy image if not
        if (imageFile != null) {
          request.files.add(
            http.MultipartFile(
              'photo',
              imageFile.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: 'image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          );
        } else {
          // Provide a dummy image or placeholder
          request.files.add(
            http.MultipartFile.fromString(
              'photo',
              'dummy_image.jpg',
              filename: 'dummy_image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          );
        }

        // Send request
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }
          if (jsonBody['status'] == 1) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesChecked,
                height: 30,
              ),
              closeOnClick: true,
              primaryColor: Colors.green,
              title: const Text('Your Classified is Successfully Submitted'),
            );
            Get.back();
          } else if (jsonBody['status'] == 0) {
            toastification.show(
              // ignore: use_build_context_synchronously
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesCancel,
                height: 35,
              ),
              primaryColor: Colors.red,
              title: Text('${jsonBody['message']}'),
            );
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to Add News. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while Add News: $e");
      }
    }
  }

  Future<void> fetchCategoryList() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final response = await http
            .get(Uri.parse('${Constants.baseUrl}${Constants.getcategorylist}'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }

          final categoryListEntity = GetCategoryEntity.fromJson(jsonBody);

          if (categoryListEntity.status == 1) {
            if (kDebugMode) {
              print("category list fetched successfully");
            }

            categorylist.value = categoryListEntity.category ?? [];
            isCategorySelectedList
                .assignAll(List<bool>.filled(categorylist.length, false));
            if (categorylist.isNotEmpty) {
              // Fetch subcategories for the first category by default
              fetchSubCategoryList(categorylist[0].id!);
            }
            if (kDebugMode) {
              print("category list: $categorylist");
            }
          } else {
            // Handle error when status is not 1
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch category list. Status code: ${response.statusCode}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  Future<void> fetchSubCategoryList(
    int categoryId,
  ) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final uri =
            Uri.parse('${Constants.baseUrl}${Constants.getsubcategorylist}')
                .replace(
                    queryParameters: {'category_id': categoryId.toString()});
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Subcategory response body: $jsonBody");
          }

          final subCategoryListEntity = GetSubCategoryEntity.fromJson(jsonBody);

          if (subCategoryListEntity.status == 1) {
            if (kDebugMode) {
              print("Subcategory list fetched successfully");
            }

            subcategoryList.value = subCategoryListEntity.category ?? [];
            isSubCategorySelectedList
                .assignAll(List<bool>.filled(subcategoryList.length, false));
            if (kDebugMode) {
              print("Subcategory list: $subcategoryList");
            }
          } else {
            // Handle error when status is not 1
            if (kDebugMode) {
              print(
                  "Failed to fetch subcategory list, status: ${subCategoryListEntity.status}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch subcategory list. Status code: ${response.statusCode}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

// Category
  void toggleCategorySelected(int index) {
    for (int i = 0; i < isCategorySelectedList.length; i++) {
      isCategorySelectedList[i] = false;
    }

    isCategorySelectedList[index] = true;

    selectedCountCategory.value = 1;

    fetchSubCategoryList(
      categorylist[index].id!,
    );

    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;
    isCategoryTyping.value = true;
  }

  TextEditingController getSelectedCategoryTextController() {
    List<String> selectedCategoryOptions = [];

    for (int i = 0; i < isCategorySelectedList.length; i++) {
      if (isCategorySelectedList[i]) {
        selectedCategoryOptions.add(categorylist[i].name.toString());
      }
    }

    return TextEditingController(text: selectedCategoryOptions.join(', '));
  }

  void mlmCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;

    if (categoryError.value) {
      isCategoryTyping.value = true;
    }
  }

  // sub Category
  void toggleSubCategorySelected(int index) {
    bool isCurrentlySelected = isSubCategorySelectedList[index];

    // Unselect all sub-categories first
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      isSubCategorySelectedList[i] = false;
    }

    isSubCategorySelectedList[index] = !isCurrentlySelected;

    selectedCountSubCategory.value = isSubCategorySelectedList[index] ? 1 : 0;

    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;
    isSubCategoryTyping.value = true;
  }

  TextEditingController getSelectedSubCategoryTextController() {
    List<String> selectedSubCategoryOptions = [];
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      if (isSubCategorySelectedList[i]) {
        selectedSubCategoryOptions.add(subcategoryList[i].name.toString());
      }
    }

    return TextEditingController(text: selectedSubCategoryOptions.join(', '));
  }

  void mlmsubCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;

    if (subCategoryError.value) {
      isSubCategoryTyping.value = true;
    }
  }

  void titleValidation() {
    String enteredTitle = title.value.text;
    if (enteredTitle.isEmpty || hasSpecialCharactersOrNumbers(enteredTitle)) {
      titleError.value = true;
    } else {
      titleError.value = false;
    }
    if (titleError.value) {
      isTitleTyping.value = true;
    }
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

  void discriptionValidation() {
    String enteredDiscription = discription.value.text;
    if (enteredDiscription.isEmpty ||
        hasSpecialTextOrNumbers(enteredDiscription)) {
      discriptionError.value = true;
    } else {
      discriptionError.value = false;
    }
    if (discriptionError.value) {
      isDiscriptionTyping.value = true;
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
