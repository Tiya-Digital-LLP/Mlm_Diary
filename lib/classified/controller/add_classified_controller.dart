import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_classified_entity.dart';
import 'package:mlmdiary/generated/get_company_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClasifiedController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> discription = TextEditingController().obs;
  Rx<TextEditingController> url = TextEditingController().obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  Rx<TextEditingController> companyName = TextEditingController().obs;
  Rx<Color> addressValidationColor = Colors.black45.obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> state = TextEditingController().obs;
  Rx<TextEditingController> pincode = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController().obs;
  RxList<GetClassifiedData> classifiedList = <GetClassifiedData>[].obs;

  RxList<String> companyNames = <String>[].obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);
  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);

  var isLiked = false.obs;
  var isBookMarked = false.obs;
  var isLoading = false.obs;

  var likeCount = 0.obs;
// FIELDS ERROR

  RxBool titleError = false.obs;
  RxBool discriptionError = false.obs;
  RxBool urlError = false.obs;
  RxBool locationError = false.obs;
  RxBool categoryError = false.obs;
  RxBool subCategoryError = false.obs;
  RxBool companyError = false.obs;
  RxBool planTypeError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isTitleTyping = false.obs;
  RxBool isDiscriptionTyping = false.obs;
  RxBool isCompanyNameTyping = false.obs;

  RxBool isUrlTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxBool companyNameOnly = false.obs;

  RxInt selectedCountCategory = 0.obs;
  RxInt selectedCountCompany = 0.obs;
  RxInt selectedCountPlan = 0.obs;
  RxInt selectedCountSubCategory = 0.obs;

  // RxBool isEmailOtpTyping = false.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  @override
  void onInit() {
    fetchCategoryList();
    getClassified();
    super.onInit();
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
        if (kDebugMode) {
          print("No internet connection available.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  void toggleCategorySelected(int index) {
    isCategorySelectedList[index] = !isCategorySelectedList[index];

    if (isCategorySelectedList[index]) {
      selectedCountCategory++;
    } else {
      selectedCountCategory--;
    }

    fetchSubCategoryList(categorylist[index].id!);
  }

  TextEditingController getSelectedCategoryTextController() {
    List<String> selectedCategoryOptions = [];
    for (int i = 0; i < isCategorySelectedList.length; i++) {
      if (isCategorySelectedList[i]) {
        selectedCategoryOptions.add(categorylist[i].id.toString());
      }
    }

    // Create a TextEditingController with the selected options text
    return TextEditingController(text: selectedCategoryOptions.join(', '));
  }

  void mlmCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;
  }

  Future<void> fetchSubCategoryList(int categoryId) async {
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
        if (kDebugMode) {
          print("No internet connection available.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  Future<void> getClassified() async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString('apiToken');
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getClassifiedEntity = GetClassifiedEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getClassifiedEntity');
          }
          // Assuming your data list is within `data` object in the response
          classifiedList.value = getClassifiedEntity.data ?? [];
        } else {
          Fluttertoast.showToast(
            msg: "Error: ${response.body}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void toggleSubCategorySelected(int index) {
    isSubCategorySelectedList[index] = !isSubCategorySelectedList[index];

    if (isSubCategorySelectedList[index]) {
      selectedCountSubCategory++;
    } else {
      selectedCountSubCategory--;
    }
  }

  TextEditingController getSelectedSubCategoryTextController() {
    List<String> selectedSubCategoryOptions = [];
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      if (isSubCategorySelectedList[i]) {
        selectedSubCategoryOptions.add(subcategoryList[i].name ?? '');
      }
    }

    return TextEditingController(text: selectedSubCategoryOptions.join(', '));
  }

  void mlmsubCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;
  }

  void companyNameValidation() async {
    String enteredcompanyName = companyName.value.text;
    if (enteredcompanyName.isEmpty ||
        hasSpecialCharactersOrNumbers(enteredcompanyName)) {
      companyError.value = true;
    } else {
      companyError.value = false;
    }
  }

  Future<void> addClassifiedDetails({
    required File? imageFile,
  }) async {
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
    String? apiToken = prefs.getString('apiToken');

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.saveclassified}'),
        );

        // Add fields
        request.fields['device'] = device;
        request.fields['company'] = companyName.value.text;
        request.fields['title'] = title.value.text;
        request.fields['description'] = discription.value.text;
        request.fields['category'] = getSelectedCategoryTextController().text;
        request.fields['subcategory'] =
            getSelectedSubCategoryTextController().text;
        request.fields['location'] = location.value.text;
        request.fields['city'] = city.value.text;
        request.fields['state'] = state.value.text;
        request.fields['pincode'] = '382350';
        request.fields['country'] = country.value.text;
        request.fields['companys'] = companyName.value.text;
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';

        // Add image file if provided, or dummy image if not
        if (imageFile != null) {
          request.files.add(
            http.MultipartFile(
              'image',
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
              'image',
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
            Get.back();
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to save company details. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        if (kDebugMode) {
          print("No internet connection available.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving company details: $e");
      }
    }
  }

  //getcompany
  Future<void> fetchCompanyNames(String query) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final uri = Uri.parse('${Constants.baseUrl}${Constants.getcompany}')
            .replace(queryParameters: {'name': query});
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final getCompanyEntity = GetCompanyEntity.fromJson(jsonBody);

          if (getCompanyEntity.result == 1) {
            companyNames.value = getCompanyEntity.data ?? [];
          } else {
            companyNames.clear();
          }
        } else {
          companyNames.clear();
        }
      } else {
        companyNames.clear();
      }
    } catch (e) {
      companyNames.clear();
    }
  }

  void validateAddress() {
    if (location.value.text.isEmpty) {
      addressValidationColor.value = Colors.red;
    } else {
      addressValidationColor.value = Colors.green;
    }
  }

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

  void locationValidation() {
    String enteredLocation = location.value.text;
    if (enteredLocation.isEmpty || hasSpecialTextOrNumbers(enteredLocation)) {
      locationError.value = true;
    } else {
      locationError.value = false;
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
