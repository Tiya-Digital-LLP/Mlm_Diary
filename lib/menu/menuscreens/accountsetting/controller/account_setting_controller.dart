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
import 'package:mlmdiary/generated/change_email_entity.dart';
import 'package:mlmdiary/generated/delete_account_entity.dart';
import 'package:mlmdiary/generated/get_plan_list_entity.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:mlmdiary/generated/get_user_type_entity.dart';
import 'package:mlmdiary/generated/update_phone_no_entity.dart';
import 'package:mlmdiary/generated/update_phone_verify_otp_entity.dart';
import 'package:mlmdiary/generated/update_social_media_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class AccountSeetingController extends GetxController {
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> companyname = TextEditingController().obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  Rx<Color> addressValidationColor = Colors.black45.obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> state = TextEditingController().obs;
  Rx<TextEditingController> pincode = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController().obs;
  Rx<TextEditingController> aboutyou = TextEditingController().obs;
  Rx<TextEditingController> aboutcompany = TextEditingController().obs;

  Rx<TextEditingController> company = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<TextEditingController> mobileOtp = TextEditingController().obs;
  Rx<TextEditingController> emailOtp = TextEditingController().obs;

  Rx<TextEditingController> instat = TextEditingController().obs;
  Rx<TextEditingController> facebook = TextEditingController().obs;
  Rx<TextEditingController> youtube = TextEditingController().obs;
  Rx<TextEditingController> twitter = TextEditingController().obs;
  Rx<TextEditingController> telegram = TextEditingController().obs;
  Rx<TextEditingController> linkdn = TextEditingController().obs;
  Rx<TextEditingController> perwebsite = TextEditingController().obs;
  Rx<TextEditingController> compwebsite = TextEditingController().obs;

  RxString userImage = ''.obs;
  var aboutCharCount = 0.obs;
  var aboutCompanyCount = 0.obs;

  final RxList<bool> isPlanSelectedList = RxList<bool>([]);
  final RxList<bool> isTypeSelectedList = RxList<bool>([]);
  RxList<GetPlanListPlan> planList = RxList<GetPlanListPlan>();
  RxList<GetUserTypeUsertype> userTypes = RxList<GetUserTypeUsertype>();

  RxBool isGenderToggle = true.obs;
  var isLoading = false.obs;

// FIELDS ERROR
  RxBool mlmTypeError = false.obs;
  RxBool planTypeError = false.obs;

  RxBool mobileError = false.obs;
  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;
  RxBool mobileOtpError = false.obs;
  RxBool emailOtpError = false.obs;
  RxBool companyNameOnly = false.obs;

  // ENABLED TYPING VALIDATION

  RxBool isNameTyping = false.obs;
  RxBool isMobileTyping = false.obs;

  RxBool isCompanyNameTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxBool isEmailTyping = false.obs;

  RxBool isAboutTyping = false.obs;
  RxBool isPasswordTyping = false.obs;
  RxBool isConfirmPasswordTyping = false.obs;

  RxBool isAboutCompany = false.obs;

  RxInt selectedCount = 0.obs;
  RxInt selectedCountPlan = 0.obs;

  // show fields

  RxBool showPhoneOtpField = false.obs;
  RxBool showEmailOtpField = false.obs;

  var userProfile = GetUserProfileEntity().obs;

  // RxBool isEmailOtpTyping = false.obs;

  RxBool isMobileOtpTyping = false.obs;
  RxBool isemailOtpTyping = false.obs;

  // READ ONLY FIELDS
  RxBool mobileReadOnly = false.obs;

  var selectedTypesId = <RxInt>[].obs;

  @override
  void onInit() {
    fetchUserTypes();
    fetchPlanList();
    fetchUserProfile();
    super.onInit();
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

        aboutyou.value.clear();
        aboutcompany.value.clear();
        // Update controllers with fetched data
        name.value.text = userProfileEntity.userProfile?.name ?? '';
        companyname.value.text = userProfileEntity.userProfile?.company ?? '';
        city.value.text = userProfileEntity.userProfile?.city ?? '';
        state.value.text = userProfileEntity.userProfile?.state ?? '';
        country.value.text = userProfileEntity.userProfile?.country ?? '';
        aboutyou.value.text = userProfileEntity.userProfile?.aboutyou ?? '';
        aboutcompany.value.text =
            userProfileEntity.userProfile?.aboutcompany ?? '';
        userImage.value = userProfileEntity.userProfile!.imagePath ?? '';
        perwebsite.value.text = userProfileEntity.userProfile!.website ?? '';
        compwebsite.value.text =
            userProfileEntity.userProfile!.compWebsite ?? '';
        instat.value.text = userProfileEntity.userProfile!.instalink ?? '';
        youtube.value.text = userProfileEntity.userProfile!.youlink ?? '';
        facebook.value.text = userProfileEntity.userProfile!.fblink ?? '';
        linkdn.value.text = userProfileEntity.userProfile!.lilink ?? '';
        twitter.value.text = userProfileEntity.userProfile!.twiterlink ?? '';
        telegram.value.text = userProfileEntity.userProfile!.telink ?? '';

        // Combine city, state, and country to form location
        location.value.text = _formatLocation(
          city.value.text,
          state.value.text,
          country.value.text,
        );

        // Update isTypeSelectedList and selectedCount
        isTypeSelectedList.clear();
        selectedCount.value = 0;
        selectedTypesId.clear();

        for (var type in userTypes) {
          bool isSelected =
              userProfileEntity.userProfile?.immlm?.contains(type.name ?? '') ??
                  false;
          isTypeSelectedList.add(isSelected);
          if (isSelected) {
            selectedCount.value++;
            selectedTypesId.add(RxInt(type.id ?? 0));
          }
        }

        //Update isplanselected

        isPlanSelectedList.clear();
        selectedCountPlan.value = 0; // Reset selected count for plans
        for (var type in planList) {
          bool isSelected =
              userProfileEntity.userProfile?.plan?.contains(type.name ?? '') ??
                  false;
          isPlanSelectedList.add(isSelected);
          if (isSelected) {
            selectedCountPlan.value++;
          }
        }

        // Update gender toggle based on fetched profile data
        isGenderToggle.value = userProfileEntity.userProfile?.sex == 'Male';

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

  String _formatLocation(String city, String state, String country) {
    final parts =
        [city, state, country].where((part) => part.isNotEmpty).toList();
    return parts.join(', ');
  }

  void mlmCategoryValidation() {
    bool hasSelectedCategory = false;

    for (bool isSelected in isTypeSelectedList) {
      if (isSelected) {
        hasSelectedCategory = true;
        break;
      }
    }
    mlmTypeError.value = !hasSelectedCategory;
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
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  Future<void> fetchUserTypes() async {
    try {
      // Function to execute HTTP request if there's an internet connection
      Future<void> executeRequest() async {
        final response = await http
            .get(Uri.parse('${Constants.baseUrl}${Constants.getUserType}'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }

          final userTypeEntity = GetUserTypeEntity.fromJson(jsonBody);

          if (userTypeEntity.status == 1) {
            if (kDebugMode) {
              print("User types fetched successfully");
            }

            userTypes.value = userTypeEntity.usertype ?? [];

            isTypeSelectedList
                .assignAll(List<bool>.filled(userTypes.length, false));
            if (kDebugMode) {
              print("User types: $userTypes");
            }
          } else {}
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch user types. Status code: ${response.statusCode}");
          }
        }
      }

      // Check for network connectivity before executing the request
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        await executeRequest();
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  TextEditingController getSelectedOptionsTextController() {
    List<String> selectedTypeOptions = [];
    for (int i = 0; i < isTypeSelectedList.length; i++) {
      if (isTypeSelectedList[i]) {
        selectedTypeOptions.add(userTypes[i].name ?? '');
      }
    }

    return TextEditingController(text: selectedTypeOptions.join(', '));
  }

  Future<void> updateUserProfile({required File? imageFile, context}) async {
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
          Uri.parse('${Constants.baseUrl}${Constants.updateuserprofile}'),
        );

        request.fields['user_type'] =
            selectedTypesId.map((type) => type.value.toString()).join(',');
        request.fields['name'] = name.value.text;
        request.fields['gender'] = isGenderToggle.value ? 'Male' : 'Female';
        request.fields['company'] = companyname.value.text;
        request.fields['plan'] = getSelectedPlanOptionsTextController().text;
        request.fields['city'] = city.value.text;
        request.fields['state'] = state.value.text;
        request.fields['country'] = country.value.text;
        request.fields['address'] = location.value.text;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['aboutyou'] = aboutyou.value.text;
        request.fields['aboutcompany'] = aboutcompany.value.text;

        if (kDebugMode) {
          print(
              'usertype: ${selectedTypesId.map((type) => type.value.toString()).join(',')}');
        }

        if (imageFile != null) {
          if (kDebugMode) {
            print('Attaching new image file: ${imageFile.path}');
          }
          request.files.add(
            http.MultipartFile(
              'image',
              imageFile.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: 'image.jpg',
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
            print("Response body from update Profile: $jsonBody");
          }
          // Check if all fields in the response are true (you may need to adjust this condition based on the actual response structure)
          if (jsonBody['success'] == 1) {
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
                height: 35,
              ),
              primaryColor: Colors.green,
              title: const Text('Your Details is Successfully Updated'),
            );

            Get.back();
            fetchUserProfile();
          } else if (jsonBody['success'] == 0) {
            toastification.show(
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
                "HTTP error: Failed to save company details. Status code: ${response.statusCode}");
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

  void validateAddress() {
    if (location.value.text.isEmpty) {
      addressValidationColor.value = Colors.red;
    } else {
      addressValidationColor.value = Colors.green;
    }
  }

  Future<void> sendPhoneOtp(String mobile, String countryCode, context) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }
    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.sendphoneotp}'),
          body: {
            'api_token': apiToken,
            'mobile': mobile,
            'countryCode': countryCode,
            'device': device,
          },
        );

        if (kDebugMode) {
          print('api_token: $apiToken');
          print('mobile: $mobile');
          print('countryCode: $countryCode');
          print('device: $device');
        }

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final otpEntity = UpdatePhoneNoEntity.fromJson(jsonBody);

          if (otpEntity.status == 1) {
            if (kDebugMode) {
              print("OTP sent successfully: ${otpEntity.message}");
            }
            showPhoneOtpField.value = true;
          } else {
            if (kDebugMode) {
              print("Failed to send OTP: ${otpEntity.message}");
            }
            showToasterrorborder("${otpEntity.message}", context);
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to send OTP. Status code: ${response.statusCode}");
          }
          showPhoneOtpField.value = false;
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
      }
    }

    // Check for network connectivity before executing the request
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult != ConnectivityResult.none) {
      await executeRequest();
    } else {
      showToasterrorborder("No internet connection", context);
    }
  }

  Future<void> updateVerifyPhoneOtp(
      String otp, String countryCode, context) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.updateverifphoneotp}'),
          body: {
            'api_token': apiToken,
            'mobile': mobile.value.text,
            'countryCode': countryCode,
            'device': device,
            'otp': otp,
          },
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final verifyPhoneOtpEntity =
              UpdatePhoneVerifyOtpEntity.fromJson(jsonBody);

          if (verifyPhoneOtpEntity.status == 1) {
            if (kDebugMode) {
              print(
                  "Phone OTP verification successful: ${verifyPhoneOtpEntity.message}");
            }
          } else {
            if (kDebugMode) {
              print(
                  "Failed to verify phone OTP: ${verifyPhoneOtpEntity.message}");
            }
            ToastUtils.showToast("${verifyPhoneOtpEntity.message}");
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
      }
    }

    // Check for network connectivity before executing the request
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult != ConnectivityResult.none) {
      await executeRequest();
    } else {
      showToasterrorborder("No internet connection", context);
    }
  }

  Future<void> updateSocialMedia(context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.updatesocialmedia}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['website'] = perwebsite.value.text;
        request.fields['comp_website'] = compwebsite.value.text;
        request.fields['fblink'] = facebook.value.text;
        request.fields['instalink'] = instat.value.text;
        request.fields['twiterlink'] = twitter.value.text;
        request.fields['lilink'] = linkdn.value.text;
        request.fields['youlink'] = youtube.value.text;
        request.fields['telink'] = telegram.value.text;
        request.fields['api_token'] = apiToken ?? '';

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var updateSocialMediaEntity = UpdateSocialMediaEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $updateSocialMediaEntity');
          }
          showToastverifedborder(
              'Social media link updated successfully', context);
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateEmail(BuildContext context) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }
    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.updateemail}'),
          body: {
            'api_token': apiToken,
            'email': email.value.text,
            'device': device,
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final otpemailEntity = ChangeEmailEntity.fromJson(jsonBody);

          if (otpemailEntity.result == 1) {
            if (kDebugMode) {
              print("OTP sent successfully: ${otpemailEntity.messsage}");
            }
            email.value.text = '';
            showEmailOtpField.value = true;
          } else {
            if (kDebugMode) {
              print("Failed to send OTP: ${otpemailEntity.messsage}");
            }
            // ignore: use_build_context_synchronously
            showToasterrorborder("${otpemailEntity.messsage}", context);
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to send OTP. Status code: ${response.statusCode}");
          }
          showEmailOtpField.value = false;
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
      }
    }

    // Check for network connectivity before executing the request
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult != ConnectivityResult.none) {
      await executeRequest();
    } else {
      if (kDebugMode) {
        print("No internet connection available.");
      }
    }
  }

  Future<void> updateVerifyEmailOtp(String otp, context) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.updateemailphoneotp}'),
          body: {
            'api_token': apiToken,
            'email': email.value.text,
            'device': device,
            'otp': otp,
          },
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final verifyEmailOtpEntity =
              UpdatePhoneVerifyOtpEntity.fromJson(jsonBody);

          if (verifyEmailOtpEntity.status == 1) {
            if (kDebugMode) {
              print(
                  "Email OTP verification successful: ${verifyEmailOtpEntity.message}");
            }
          } else {
            if (kDebugMode) {
              print(
                  "Failed to verify Email OTP: ${verifyEmailOtpEntity.message}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to verify Email OTP. Status code: ${response.statusCode}");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
      }
    }

    // Check for network connectivity before executing the request
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult != ConnectivityResult.none) {
      await executeRequest();
    } else {
      showToasterrorborder("No internet connection", context);
    }
  }

  Future<void> deleteAccount(context) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(Constants.accessToken);

    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.deleteaccount}'),
          body: {
            'api_token': apiToken,
          },
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final deleteAccountEntity = DeleteAccountEntity.fromJson(jsonBody);

          if (deleteAccountEntity.status == 1) {
            if (kDebugMode) {
              print(
                  "Account deleted successfully: ${deleteAccountEntity.message}");
            }
            showToastverifedborder("Account deleted successfully!", context);
            Get.offAllNamed(Routes.login);
          } else if (deleteAccountEntity.status == 0) {
            toastification.show(
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
          } else {
            if (kDebugMode) {
              print(
                  "Failed to Account deleted: ${deleteAccountEntity.message}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to Account deleted. Status code: ${response.statusCode}");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
      }
    }

    // Check for network connectivity before executing the request
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult != ConnectivityResult.none) {
      await executeRequest();
    } else {
      showToasterrorborder("No internet connection", context);
    }
  }

  Future<void> sendChangePasswordRequest(
      BuildContext context, int userId, String newPassword) async {
    try {
      if (kDebugMode) {
        print('Sending change password request...');
      }

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.changepassword}'),
        body: {
          'user_id': userId.toString(),
          'password': newPassword,
        },
      );

      if (kDebugMode) {
        print('Request sent.');
      }

      if (kDebugMode) {
        print('body userid: $userId');
        print('body newPassword: $newPassword');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response received with status code 200.');
        }

        final responseData = json.decode(response.body);
        if (responseData['result'] == 1) {
          if (kDebugMode) {
            print('Password changed successfully.');
          }
          // ignore: use_build_context_synchronously
          showToastverifedborder("Password changed successfully!", context);
        } else {
          final errorMessage =
              responseData['message'] ?? "Password change failed";
          if (kDebugMode) {
            print('Password change failed: $errorMessage');
          }
          // ignore: use_build_context_synchronously
          showToasterrorborder(errorMessage, context);
        }
      } else {
        if (kDebugMode) {
          print(
              'Password change request failed with status code ${response.statusCode}: ${response.reasonPhrase}');
        }
        showToasterrorborder(
          "Password change request failed: ${response.reasonPhrase}",
          // ignore: use_build_context_synchronously
          context,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
      // ignore: use_build_context_synchronously
      showToasterrorborder("An error occurred: $e", context);
    }
  }

  void planCategoryValidation() {
    bool hasSelectedPlan = false;

    for (bool isSelected in isPlanSelectedList) {
      if (isSelected) {
        hasSelectedPlan = true;
        break;
      }
    }
    planTypeError.value = !hasSelectedPlan;
  }

  void mobileOtpValidation() {
    if (mobileOtp.value.text.isEmpty || mobileOtp.value.text.length < 6) {
      mobileOtpError.value = true;
    } else {
      mobileOtpError.value = false;
    }
  }

  void emailOtpValidation() {
    if (emailOtp.value.text.isEmpty || emailOtp.value.text.length < 6) {
      emailOtpError.value = true;
    } else {
      emailOtpError.value = false;
    }
  }

  void mobileValidation() {
    if (mobile.value.text.isEmpty || mobile.value.text.length <= 6) {
      mobileError.value = true;
    } else {
      mobileError.value = false;
    }
  }

  void toggleSelected(int index, context) {
    if (selectedCount.value >= 3 && !isTypeSelectedList[index]) {
      showToasterrorborder('You Can Select Maximum 3 Fields ', context);
      return;
    }

    isTypeSelectedList[index] = !isTypeSelectedList[index];

    if (isTypeSelectedList[index]) {
      selectedCount.value++;
      selectedTypesId
          .add(RxInt(userTypes[index].id ?? 0)); // Convert int to RxInt
    } else {
      selectedCount.value--;
      selectedTypesId
          .remove(RxInt(userTypes[index].id ?? 0)); // Convert int to RxInt
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

class UserProfile {
  // other fields
  List<String>? immlm;

  UserProfile({
    // other fields
    this.immlm,
  });

  // fromJson method
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      // other fields
      immlm: json['immlm'] != null ? List<String>.from(json['immlm']) : null,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // other fields
    if (immlm != null) {
      data['immlm'] = immlm;
    }
    return data;
  }
}
