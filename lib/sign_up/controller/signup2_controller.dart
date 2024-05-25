import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_plan_list_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup2Controller extends GetxController {
  RxList<GetPlanListPlan> planList = RxList<GetPlanListPlan>();
  final RxList<bool> isPlanSelectedList = RxList<bool>([]);
  Rx<TextEditingController> location = TextEditingController().obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> state = TextEditingController().obs;
  Rx<TextEditingController> pincode = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController().obs;
  String? apiToken;
  Rx<TextEditingController> companyName = TextEditingController().obs;
  var isLoading = false.obs;

  RxBool isGenderToggle = true.obs;

  RxBool comapnyNameError = false.obs;
  RxBool planTypeError = false.obs;

  RxBool isCompanyNameTyping = false.obs;
  RxBool isLocationTyping = false.obs;

  RxBool companyNameOnly = false.obs;

  RxInt selectedCount = 0.obs;
  RxInt selectedCountPlan = 0.obs;

  @override
  void onInit() {
    fetchPlanList();
    super.onInit();
  }

  // fetch planlist

  Future<void> fetchPlanList() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final response = await http
            .get(Uri.parse('${Constants.baseUrl}${Constants.getplanlist}'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }

          final planListEntity = GetPlanListEntity.fromJson(jsonBody);

          if (planListEntity.status == 1) {
            if (kDebugMode) {
              print("Plan list fetched successfully");
            }

            planList.value = planListEntity.plan ?? [];
            isPlanSelectedList
                .assignAll(List<bool>.filled(planList.length, false));
            if (kDebugMode) {
              print("Plan list: $planList");
            }
          } else {
            // Handle error when status is not 1
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch plan list. Status code: ${response.statusCode}");
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

  void togglePlanSelected(int index) {
    isPlanSelectedList[index] = !isPlanSelectedList[index];

    if (isPlanSelectedList[index]) {
      selectedCountPlan++;
    } else {
      selectedCountPlan--;
    }
  }

  TextEditingController getSelectedPlanOptionsTextController() {
    List<String> selectedPlanOptions = [];
    for (int i = 0; i < isPlanSelectedList.length; i++) {
      if (isPlanSelectedList[i]) {
        selectedPlanOptions.add(planList[i].name ?? '');
      }
    }

    return TextEditingController(text: selectedPlanOptions.join(', '));
  }

  void planCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    planTypeError.value = selectedCountPlan == 0;
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

  bool hasSpecialCharactersOrNumbers(String text) {
    RegExp specialCharOrNumber = RegExp(r'[!@#\$&*()]|[0-9]');
    return specialCharOrNumber.hasMatch(text);
  }

  // Update your saveCompanyDetails function to accept an optional image file
  // Save company details with the stored API token
  Future<void> saveCompanyDetails({
    required File? imageFile,
  }) async {
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString('apiToken');

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.savecompany}'),
        );

        // Add fields
        request.fields['company'] = companyName.value.text;
        request.fields['plan'] = getSelectedPlanOptionsTextController().text;
        request.fields['city'] = city.value.text;
        request.fields['state'] = state.value.text;
        request.fields['country'] = country.value.text;
        request.fields['postcode'] = '360022';
        request.fields['sex'] = isGenderToggle.value ? 'Male' : 'Female';
        request.fields['location'] = location.value.text;
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
          }
          Get.offNamed(Routes.mainscreen);
          // Parse response and update UI as needed
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
}
