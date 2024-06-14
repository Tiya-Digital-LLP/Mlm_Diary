import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/domestic_phoneotp_entity.dart';
import 'package:mlmdiary/generated/email_otp_entity.dart';
import 'package:mlmdiary/generated/email_verify_entity.dart';
import 'package:mlmdiary/generated/foreignphone_otp_entity.dart';
import 'package:mlmdiary/generated/get_plan_list_entity.dart';
import 'package:mlmdiary/generated/get_user_type_entity.dart';
import 'package:mlmdiary/generated/resent_otp_register_entity.dart';
import 'package:mlmdiary/generated/user_register_entity_entity.dart';
import 'package:mlmdiary/generated/verify_phone_otp_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/sign_up/controller/auth_controller.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:mlmdiary/utils/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  RxList<GetUserTypeUsertype> userTypes = RxList<GetUserTypeUsertype>();
  RxList<GetPlanListPlan> planList = RxList<GetPlanListPlan>();
  final RxList<bool> isPlanSelectedList = RxList<bool>([]);
  final AuthController controller = Get.put((AuthController()));

  final RxList<bool> isTypeSelectedList = RxList<bool>([]);

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

  RxInt defaultUserId = RxInt(0);

  void setDefaultUserId(int? userId) {
    defaultUserId.value = userId ?? 0;
  }

  @override
  void onInit() {
    fetchUserTypes();
    fetchPlanList();
    super.onInit();
  }

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

  Future<void> sendDomesticPhoneOtp(
      String mobile, String name, String countryCode) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.domesticPhoneOtp}'),
          body: {
            'name': name,
            'user_type': userTypes.isNotEmpty ? userTypes.join(',') : '',
            'mobile': mobile,
            'countrycode': countryCode,
            'device': device,
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final otpEntity = DomesticPhoneotpEntity.fromJson(jsonBody);

          if (otpEntity.status == 1) {
            if (kDebugMode) {
              print("Domestic OTP sent successfully: ${otpEntity.message}");
            }
            setDefaultUserId(otpEntity.userId);
          } else {
            if (kDebugMode) {
              print("Failed to send domestic OTP: ${otpEntity.message}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to send domestic OTP. Status code: ${response.statusCode}");
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
      if (kDebugMode) {
        print("No internet connection available.");
      }
    }
  }

  Future<void> sendForeignPhoneOtp(
      String mobile, String name, String countryCodee) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.foreignPhoneOtp}'),
          body: {
            'name': name,
            'user_type': userTypes.isNotEmpty ? userTypes.join(',') : '',
            'mobile': mobile,
            'countrycode': countryCodee,
            'device': device,
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final otpEntity = ForeignphoneOtpEntity.fromJson(jsonBody);

          if (otpEntity.status == 1) {
            if (kDebugMode) {
              print("Foreign OTP sent successfully: ${otpEntity.message}");
            }
            setDefaultUserId(otpEntity.userId);
          } else {
            if (kDebugMode) {
              print("Failed to send foreign OTP: ${otpEntity.message}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to send foreign OTP. Status code: ${response.statusCode}");
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
      if (kDebugMode) {
        print("No internet connection available.");
      }
    }
  }

  Future<void> verifyOtp(int userid) async {
    if (kDebugMode) {
      print("Verifying OTP for userId: $userid,");
    }

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.resentOtp}'),
          body: {
            'user_id': userid.toString(),
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final resentOtpEntity = ResentOtpRegisterEntity.fromJson(jsonBody);

          if (resentOtpEntity.status == 1) {
            if (kDebugMode) {
              print("OTP verification successful: ${resentOtpEntity.message}");
            }
            // Handle successful OTP verification
            stopTimer();
          } else {
            if (kDebugMode) {
              print("Failed to verify OTP: ${resentOtpEntity.message}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to verify OTP. Status code: ${response.statusCode}");
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
      if (kDebugMode) {
        print("No internet connection available.");
      }
    }
  }

  Future<void> verifyPhoneOtp(int userId, String otp) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }
    if (kDebugMode) {
      print("Verifying OTP for userId: $userId, OTP: $otp");
    }

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.verifyphoneOtp}'),
          body: {
            'user_id': userId.toString(),
            'device': device,
            'otp': otp,
          },
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final verifyPhoneOtpEntity = VerifyPhoneOtpEntity.fromJson(jsonBody);

          if (verifyPhoneOtpEntity.status == 1) {
            if (kDebugMode) {
              print(
                  "Phone OTP verification successful: ${verifyPhoneOtpEntity.message}");
            }
            showEmailField.value = true;
          } else {
            if (kDebugMode) {
              print(
                  "Failed to verify phone OTP: ${verifyPhoneOtpEntity.message}");
            }
            ToastUtils.showToast(
                "Failed to Verify Mobile OTP: ${verifyPhoneOtpEntity.message}");
            showEmailField.value = false;
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to verify phone OTP. Status code: ${response.statusCode}");
          }
          ToastUtils.showToast("Failed to Verify Mobile OTP: HTTP Error");
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
        // Handle other errors
        ToastUtils.showToast("Failed to Verify Mobile OTP: $e");
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
      ToastUtils.showToast("No internet connection available.");
    }
  }

  Future<void> sendEmailOtp(String email, int userId) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        int userId = defaultUserId.value;
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.emailotp}'),
          body: {
            'email': email,
            'device': device,
            'user_id': userId.toString(),
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final emailOtpEntity = EmailOtpEntity.fromJson(jsonBody);

          if (emailOtpEntity.status == 1) {
            if (kDebugMode) {
              print(
                  "Email OTP sent successfully for email: ${emailOtpEntity.message}");
            }
            emailOtpSend.value = true;
          } else {
            if (kDebugMode) {
              print("Failed to send Email OTP: ${emailOtpEntity.message}");
            }
            // Handle failure to send email OTP
            ToastUtils.showToast(
                "Failed to send Email OTP: ${emailOtpEntity.message}");
            emailOtpSend.value = false;
          }
        } else {
          // Handle HTTP error
          if (kDebugMode) {
            print(
                "HTTP error: Failed to send Email OTP. Status code: ${response.statusCode}");
          }
          ToastUtils.showToast("Failed to send Email OTP: HTTP Error");
          emailOtpSend.value = false;
        }
      } catch (e) {
        // Handle other errors
        if (kDebugMode) {
          print("An error occurred: $e");
        }
        ToastUtils.showToast("Failed to send Email OTP: $e");
        emailOtpSend.value = false;
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
      ToastUtils.showToast("No internet connection available.");
      emailOtpSend.value = false;
    }
  }

  Future<void> registerUser(int userId, String password) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }

    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.userregister}'),
        body: {
          'user_id': userId.toString(),
          'password': password,
          'device': device,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        final userRegisterEntity = UserRegisterEntityEntity.fromJson(jsonBody);

        if (userRegisterEntity.status == 1) {
          // Registration successful
          ToastUtils.showToast("Registration successful");
          Get.offNamed(Routes.signUp2);
          // Extracted API token
          String apiTokenValue = userRegisterEntity.apiToken ?? '';
          // Store the token in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('apiToken', apiTokenValue);
          if (kDebugMode) {
            print('api_token: $apiTokenValue');
          }
        } else {
          // Registration failed
          ToastUtils.showToast("Registration failed");
        }
      } else {
        // Handle HTTP error
        if (kDebugMode) {
          print('HTTP Error: ${response.statusCode}');
        }
        ToastUtils.showToast("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle other errors
      if (kDebugMode) {
        print('Error: $e');
      }
      ToastUtils.showToast("Error: $e");
    }
  }

  Future<void> verifyEmail(
    String email,
    int userId,
    String otp,
  ) async {
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }

    if (kDebugMode) {
      print('Device Name: $device');
    }

    // Function to execute HTTP request if there's an internet connection
    Future<void> executeRequest() async {
      try {
        final response = await http.post(
          Uri.parse('${Constants.baseUrl}${Constants.verifyotp}'),
          body: {
            'user_id': userId.toString(),
            'device': device,
            'otp': otp,
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final emailVerifyEntity = EmailVerifyEntity.fromJson(jsonBody);

          if (emailVerifyEntity.status == 1) {
            if (kDebugMode) {
              print(
                  "Email verified successfully: ${emailVerifyEntity.message}");
            }
            showPasswordField.value = true;
          } else {
            if (kDebugMode) {
              print("Failed to verify email: ${emailVerifyEntity.message}");
            }
            showPasswordField.value = false;
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to verify email. Status code: ${response.statusCode}");
          }
          showPasswordField.value = false;
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
        showPasswordField.value = false;
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
      showPasswordField.value = false;
    }
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

  void mlmCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    mlmTypeError.value = selectedCount == 0;
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

  void toggleSelected(int index) {
    isTypeSelectedList[index] = !isTypeSelectedList[index];

    if (isTypeSelectedList[index]) {
      selectedCount++;
    } else {
      selectedCount--;
    }
  }

  TextEditingController getSelectedOptionsTextController() {
    List<String> selectedTypeOptions = [];
    for (int i = 0; i < isTypeSelectedList.length; i++) {
      if (isTypeSelectedList[i]) {
        selectedTypeOptions.add(userTypes[i].id.toString());
      }
    }

    return TextEditingController(text: selectedTypeOptions.join(', '));
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
