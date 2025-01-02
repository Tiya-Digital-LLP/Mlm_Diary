import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/email_validator.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactusController extends GetxController {
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> company = TextEditingController().obs;
  Rx<TextEditingController> message = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;
  List listitem2 = ['Feedback/Suggestions', 'Advetiesment', 'Feature Request'];
  final RxString selectedItem = RxString('');
// FIELDS ERROR
  RxBool mobileError = false.obs;
  RxBool emailError = false.obs;
  RxBool companyError = false.obs;
  RxBool messageError = false.obs;
  RxBool dropItemError = false.obs;

  RxBool nameError = false.obs;
  var userProfile = GetUserProfileEntity().obs;

  // ENABLED TYPING VALIDATION
  RxBool isNameTyping = false.obs;
  RxBool isEmailTyping = false.obs;
  RxBool isCompanyTyping = false.obs;
  RxBool isMessageTyping = false.obs;
  RxBool isMobileTyping = false.obs;

  // RxBool isEmailOtpTyping = false.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;
  RxBool mobileReadOnly = false.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading(true);

    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null || apiToken.isEmpty) {
      isLoading(false);

      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.userprofile}'),
        body: {'api_token': apiToken},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userProfileEntity = GetUserProfileEntity.fromJson(responseData);
        userProfile(userProfileEntity);

        // Update controllers with fetched data
        name.value.text = userProfileEntity.userProfile?.name ?? '';
        email.value.text = userProfileEntity.userProfile?.email ?? '';
        company.value.text = userProfileEntity.userProfile?.company ?? '';
        mobile.value.text = userProfileEntity.userProfile?.mobile ?? '';

        if (kDebugMode) {
          print('Account Settings Data: $responseData');
        }
      } else {
        if (kDebugMode) {
          print("Error: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> contactus(context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.contactus}'),
        );
        request.fields['api_token'] = apiToken ?? '';
        request.fields['name'] = name.value.text;
        request.fields['company'] = company.value.text;
        request.fields['email'] = email.value.text;
        request.fields['phone'] = mobile.value.text;
        request.fields['subject'] = selectedItem.toString();
        request.fields['comment'] = message.value.text;

        if (kDebugMode) {
          print('api_token: $apiToken');
          print('name: ${name.value.text}');
          print('company: ${company.value.text}');
          print('email: ${email.value.text}');
          print('phone: ${mobile.value.text}');
          print('subject: $selectedItem');
          print('comment: ${message.value.text}');
        }

        // Send request
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body from ConatactUs: $jsonBody");
          }

          showToastverifedborder('Your inquiry has been saved', context);
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to save inquiry. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving company details: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  void nameValidation(context) {
    String enteredName = name.value.text;

    // Capitalize the first letter of each word
    String capitalized = enteredName
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');

    // Update the controller with the capitalized text
    name.value.text = capitalized;

    if (enteredName.isEmpty ||
        hasSpecialCharactersOrNumbers(enteredName) ||
        !isFirstLetterCapital(enteredName)) {
      nameError.value = true;
    } else {
      nameError.value = false;
    }

    if (nameError.value) {
      isNameTyping.value = true;
    }
  }

  bool isFirstLetterCapital(String text) {
    if (text.isEmpty) return false;
    String firstLetter = text[0];
    return firstLetter == firstLetter.toUpperCase();
  }

  bool hasSpecialCharactersOrNumbers(String text) {
    RegExp specialCharOrNumber = RegExp(r'[!@#\$&*()]|[0-9]');
    return specialCharOrNumber.hasMatch(text);
  }

  void mobileValidation() {
    if (mobile.value.text.isEmpty || mobile.value.text.length <= 6) {
      mobileError.value = true;
    } else {
      mobileError.value = false;
    }
    if (mobileError.value) {
      isMobileTyping.value = true;
    }
  }

  void messageValidation() {
    if (message.value.text.isEmpty) {
      messageError.value = true;
    } else {
      messageError.value = false;
    }
    if (messageError.value) {
      isMessageTyping.value = true;
    }
  }

  void emailValidation() {
    final bool isValid = EmailValidator.validate(email.value.text);

    if (isValid == false) {
      emailError.value = true;
    } else {
      emailError.value = false;
    }
    if (emailError.value) {
      isEmailTyping.value = true;
    }
  }

  final RxList<bool> isPlanSelectedList =
      RxList<bool>(List.generate(planList.length, (index) => false));

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
