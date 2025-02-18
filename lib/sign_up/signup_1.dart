import 'dart:developer';

import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_user_type_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/sign_up/controller/signup_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/common_header.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_mobile_field.dart';
import 'package:mlmdiary/widgets/custom_name_text_field.dart';
import 'package:mlmdiary/widgets/normal_button.dart';
import 'package:mlmdiary/widgets/password_border_text_field.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupController controller = Get.put((SignupController()));
  final smartAuth = SmartAuth();

  void getSmsCode() async {
    try {
      final res = await smartAuth.getSmsCode(useUserConsentApi: true);
      if (res.codeFound) {
        debugPrint('userConsent success: ${res.code}');
        controller.mobileOtp.value.text = res.code ?? '';
      } else {
        debugPrint('userConsent failed: ${res.toString()}');
        debugPrint('Code Found: ${res.codeFound}');
        debugPrint('SMS Received: ${res.sms}');
        debugPrint('Was it successful?: ${res.succeed}');
      }
    } catch (e) {
      debugPrint('Error occurred while getting SMS code: $e');
    }
  }

  @override
  void initState() {
    getSmsCode();
    initCountry();
    super.initState();
  }

  void initCountry() async {
    Country? defaultCountry = await getCountryByCountryCode(context, 'IN');
    controller.selectedCountry.value = defaultCountry;
    if (kDebugMode) {
      if (controller.selectedCountry.value != null) {
        print('Country name: ${controller.selectedCountry.value!.name}');
        print(
            'Country calling code: ${controller.selectedCountry.value!.callingCode}');
        print('Country code: ${controller.selectedCountry.value!}');
      } else {
        print('Country is null');
      }
    }
  }

  bool isDomesticPhoneNumber(String mobile) {
    return controller.selectedCountry.value != null &&
        controller.selectedCountry.value!.callingCode == '+91';
  }

  void sendOtp() {
    FocusScope.of(context).unfocus();
    final mobileNumber = controller.mobile.value.text;
    final userName = controller.name.value.text;
    if (isDomesticPhoneNumber(mobileNumber)) {
      controller.sendDomesticPhoneOtp(mobileNumber, userName, '91', context);
    } else {
      controller.sendForeignPhoneOtp(mobileNumber, userName,
          getFormattedForeignNumberCountryCode(), context);
    }
  }

  String getFormattedForeignNumberCountryCode() {
    return controller.selectedCountry.value?.callingCode.replaceAll('+', '') ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.white),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                  ],
                ),
                CommonHeader(
                  onBackTap: () {},
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "Registration",
                  style: textStyleW700(size.width * 0.07, AppColors.blackText),
                ),
                SizedBox(height: size.height * 0.04),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    children: [
                      Obx(
                        () => BorderContainer(
                          isError: controller.mlmTypeError.value,
                          byDefault: !controller.isMlmTyping.value,
                          height: 68,
                          child: TextField(
                            controller:
                                controller.getSelectedOptionsTextController(),
                            readOnly: true,
                            onTap: () async {
                              // ignore: use_build_context_synchronously
                              showBottomSheetFunc(context, size, controller,
                                  controller.userTypes);
                              controller.mlmCategoryValidation();
                            },
                            style: textStyleW500(
                                size.width * 0.04, AppColors.blackText),
                            cursorColor: AppColors.blackText,
                            decoration: InputDecoration(
                              labelText: "I am a MLM *",
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.5,
                                horizontal: 2,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.blackText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Obx(
                        () => CustomNameTextField(
                          height: 58,
                          keyboard: TextInputType.text,
                          textInputType: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z\s]+")),
                            LengthLimitingTextInputFormatter(25),
                          ],
                          hint: "Your Name *",
                          readOnly: controller.nameReadOnly.value,
                          controller: controller.name.value,
                          isError: controller.nameError.value,
                          byDefault: !controller.isNameTyping.value,
                          enableToolbar: false,
                          onChanged: (value) {
                            if (value.trim().isEmpty) {
                              controller.nameError.value = true;
                            } else {
                              controller.nameValidation(context);
                              controller.nameError.value = false;
                            }
                            controller.isNameTyping.value = true;
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            GestureDetector(
                              onTap: _onPressedShowBottomSheet,
                              child: SizedBox(
                                width: 120,
                                height: 58,
                                child: BorderContainer(
                                  height: 58,
                                  child: controller.selectedCountry.value ==
                                          null
                                      ? Container()
                                      : Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                controller.selectedCountry
                                                    .value!.flag,
                                                package: countryCodePackageName,
                                                width: 25,
                                                height: 25,
                                              ),
                                              8.sbw,
                                              Text(
                                                controller.selectedCountry
                                                    .value!.callingCode,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: size.width * 0.045,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            10.sbw,
                            Expanded(
                              flex: 5,
                              child: Obx(
                                () => CustomMobileField(
                                  height: 58,
                                  hint: "Mobile Number *",
                                  readOnly: controller.mobileReadOnly.value,
                                  controller: controller.mobile.value,
                                  textInputType: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboard: TextInputType.phone,
                                  isError: controller.mobileError.value,
                                  byDefault: !controller.isMobileTyping.value,
                                  onChanged: (value) {
                                    controller.mobileValidation();
                                    controller.isMobileTyping.value = true;
                                  },
                                  suffixIcon: controller.mobileReadOnly.value
                                      ? Icon(
                                          Icons.check_circle,
                                          color: AppColors.greenBorder,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Obx(
                        () => (controller.mobileOtpSend.value)
                            ? (controller.showEmailField.value)
                                ? Column(children: [
                                    BorderTextField(
                                      controller: controller.email.value,
                                      readOnly: controller.emailReadOnly.value,
                                      hint: "Email Address *",
                                      textInputType: const [],
                                      keyboard: TextInputType.emailAddress,
                                      isError: controller.emailError.value,
                                      byDefault:
                                          !controller.isEmailTyping.value,
                                      onChanged: (value) {
                                        controller.emailValidation();
                                        controller.isEmailTyping.value = true;
                                      },
                                      suffixIcon: controller.emailReadOnly.value
                                          ? Icon(
                                              Icons.check_circle,
                                              color: AppColors.greenBorder,
                                            )
                                          : null,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    Obx(
                                      () => (controller.emailOtpSend.value)
                                          ? (controller.showPasswordField.value)
                                              ? Column(
                                                  children: [
                                                    PasswordBorderTextField(
                                                        controller: controller
                                                            .password.value,
                                                        hint: "Your Password *",
                                                        textInputType: const [],
                                                        keyboard:
                                                            TextInputType.text,
                                                        isError: controller
                                                            .passwordError
                                                            .value,
                                                        byDefault: !controller
                                                            .isPasswordTyping
                                                            .value,
                                                        onChanged: (value) {
                                                          controller
                                                              .passwordValidation();
                                                          controller
                                                              .isPasswordTyping
                                                              .value = true;
                                                        },
                                                        maxLength: 18),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    PasswordBorderTextField(
                                                      controller: controller
                                                          .confirmPassword
                                                          .value,
                                                      hint:
                                                          "Confirm Your Password *",
                                                      textInputType: const [],
                                                      isError: controller
                                                          .confirmPasswordError
                                                          .value,
                                                      keyboard:
                                                          TextInputType.text,
                                                      byDefault: !controller
                                                          .isConfirmPasswordTyping
                                                          .value,
                                                      maxLength: 18,
                                                      onChanged: (value) {
                                                        controller
                                                            .confirmPasswordValidation();
                                                        controller
                                                            .isConfirmPasswordTyping
                                                            .value = true;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.030,
                                                            width: size.height *
                                                                0.030,
                                                            child: Obx(
                                                              () => InkWell(
                                                                onTap: () {
                                                                  controller
                                                                          .termsCondition
                                                                          .value =
                                                                      !controller
                                                                          .termsCondition
                                                                          .value;
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  (controller
                                                                          .termsCondition
                                                                          .value)
                                                                      ? Assets
                                                                          .imagesCheck
                                                                      : Assets
                                                                          .imagesSquare,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.02,
                                                        ),
                                                        Text(
                                                          "I agree with ",
                                                          style: textStyleW400(
                                                              size.width *
                                                                  0.045,
                                                              AppColors
                                                                  .blackText),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                Routes.terms);
                                                          },
                                                          child: Text(
                                                            "Terms & Conditions",
                                                            style: textStyleW500(
                                                                size.width *
                                                                    0.045,
                                                                const Color(
                                                                    0XFF005C94)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    NormalButton(
                                                      text: "Continue",
                                                      onPressed: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        controller
                                                            .isPasswordTyping
                                                            .value = true;
                                                        controller
                                                            .isConfirmPasswordTyping
                                                            .value = true;

                                                        controller
                                                            .passwordValidation();
                                                        controller
                                                            .confirmPasswordValidation();

                                                        if (controller
                                                            .password
                                                            .value
                                                            .text
                                                            .isEmpty) {
                                                          showToasterrorborder(
                                                              "Please Enter Password",
                                                              context);
                                                        } else if (controller
                                                                .password
                                                                .value
                                                                .text
                                                                .length <
                                                            6) {
                                                          showToasterrorborder(
                                                              "Password Have Must be 6 Character",
                                                              context);
                                                        } else if (controller
                                                            .confirmPassword
                                                            .value
                                                            .text
                                                            .isEmpty) {
                                                          showToasterrorborder(
                                                              "Please Enter Confirm Password",
                                                              context);
                                                        } else if (controller
                                                                .password
                                                                .value
                                                                .text !=
                                                            controller
                                                                .confirmPassword
                                                                .value
                                                                .text) {
                                                          showToasterrorborder(
                                                              "Both Password Should be Same",
                                                              context);
                                                        } else if (controller
                                                                .termsCondition
                                                                .value ==
                                                            false) {
                                                          showToasterrorborder(
                                                              "Please Agree Terms & Conditions",
                                                              context);
                                                        } else {
                                                          log("Signup Process Start");

                                                          controller.registerUser(
                                                              controller
                                                                  .defaultUserId
                                                                  .value,
                                                              controller
                                                                  .password
                                                                  .value
                                                                  .text,
                                                              context);
                                                        }
                                                      },
                                                      isLoading:
                                                          controller.isLoading,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Already have account?  ",
                                                          style: textStyleW400(
                                                              size.width *
                                                                  0.045,
                                                              AppColors
                                                                  .blackText),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                Routes.login);
                                                          },
                                                          child: Text(
                                                            "Login",
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontSize:
                                                                  size.width *
                                                                      0.045,
                                                              color: AppColors
                                                                  .redText,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                  ],
                                                )
                                              : Obx(() {
                                                  return controller
                                                          .isEmailOtpScreenVisible
                                                          .value
                                                      ? Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Pinput(
                                                                controller:
                                                                    controller
                                                                        .emailOtp
                                                                        .value,
                                                                length: 4,
                                                                onChanged:
                                                                    (pin) {
                                                                  controller
                                                                      .emailOtp
                                                                      .value
                                                                      .text = pin;

                                                                  if (pin.length ==
                                                                      4) {
                                                                    String
                                                                        email =
                                                                        controller
                                                                            .email
                                                                            .value
                                                                            .text;
                                                                    int userId =
                                                                        controller
                                                                            .defaultUserId
                                                                            .value;
                                                                    String otp =
                                                                        controller
                                                                            .emailOtp
                                                                            .value
                                                                            .text;

                                                                    controller.verifyEmail(
                                                                        email,
                                                                        userId,
                                                                        otp,
                                                                        context);
                                                                  }
                                                                },
                                                                onSubmitted:
                                                                    (pin) {
                                                                  controller
                                                                      .emailOtp
                                                                      .value
                                                                      .text = pin;
                                                                },
                                                                defaultPinTheme:
                                                                    PinTheme(
                                                                  width: 56,
                                                                  height: 56,
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                focusedPinTheme:
                                                                    PinTheme(
                                                                  width: 56,
                                                                  height: 56,
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.015,
                                                            ),
                                                            (controller.timerValue
                                                                        .value ==
                                                                    0)
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      // Resend email OTP
                                                                      String email = controller
                                                                          .email
                                                                          .value
                                                                          .text;
                                                                      int userId = controller
                                                                          .defaultUserId
                                                                          .value;
                                                                      if (email
                                                                              .isNotEmpty &&
                                                                          userId !=
                                                                              0) {
                                                                        controller.sendEmailOtp(
                                                                            email,
                                                                            userId,
                                                                            context);
                                                                        controller
                                                                            .timerValue
                                                                            .value = 30;
                                                                        controller
                                                                            .startTimer();
                                                                      } else {
                                                                        showToasterrorborder(
                                                                            "Please enter a valid email",
                                                                            context);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      "Resend OTP",
                                                                      style: textStyleW500(
                                                                          size.width *
                                                                              0.042,
                                                                          AppColors
                                                                              .primaryColor),
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    'Resent OTP ${controller.timerValue.value} seconds',
                                                                    style: textStyleW500(
                                                                        size.width *
                                                                            0.042,
                                                                        AppColors
                                                                            .blackText),
                                                                  ),
                                                            SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.015,
                                                            ),
                                                            NormalButton(
                                                              text: "Verify",
                                                              onPressed: () {
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                                controller
                                                                    .isEmailOtpTyping
                                                                    .value = true;

                                                                controller
                                                                    .emailOtpValidation();

                                                                if (controller
                                                                    .emailOtp
                                                                    .value
                                                                    .text
                                                                    .isEmpty) {
                                                                  showToasterrorborder(
                                                                      "Please Enter Email OTP",
                                                                      context);
                                                                } else if (controller
                                                                        .emailOtp
                                                                        .value
                                                                        .text
                                                                        .length <
                                                                    4) {
                                                                  showToasterrorborder(
                                                                      "OTP Must be 6 Digits",
                                                                      context);
                                                                } else {
                                                                  String email =
                                                                      controller
                                                                          .email
                                                                          .value
                                                                          .text;
                                                                  int userId =
                                                                      controller
                                                                          .defaultUserId
                                                                          .value;
                                                                  String otp =
                                                                      controller
                                                                          .emailOtp
                                                                          .value
                                                                          .text;

                                                                  // Call the verifyEmail method from the controller
                                                                  controller
                                                                      .verifyEmail(
                                                                          email,
                                                                          userId,
                                                                          otp,
                                                                          context);
                                                                }
                                                              },
                                                              isLoading:
                                                                  controller
                                                                      .isLoading,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.015,
                                                            ),
                                                            Text(
                                                              "Please check your email, and enter verification code below. You may need to check your Spam or Junk folder as well.",
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: size
                                                                          .width *
                                                                      0.042),
                                                            )
                                                          ],
                                                        )
                                                      : const SizedBox.shrink();
                                                })
                                          : NormalButton(
                                              // SEND EMAIL OTP
                                              text: "Send OTP",
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                controller.isEmailTyping.value =
                                                    true;

                                                controller.emailValidation();

                                                String email =
                                                    controller.email.value.text;
                                                int userId = controller
                                                    .defaultUserId.value;
                                                if (controller
                                                    .email.value.text.isEmpty) {
                                                  showToasterrorborder(
                                                      "Please Enter Email",
                                                      context);
                                                } else if (controller
                                                        .emailError.value ==
                                                    true) {
                                                  showToasterrorborder(
                                                      "Please Enter Valid Email",
                                                      context);
                                                } else {
                                                  controller.sendEmailOtp(
                                                      email, userId, context);
                                                  controller.emailOtpSend
                                                      .value = true;
                                                  controller.startTimer();
                                                }
                                              },
                                              isLoading: controller.isLoading,
                                            ),
                                    )
                                  ])
                                : Obx(() {
                                    return controller
                                            .isMobileOtpScreenVisible.value
                                        ? Column(
                                            children: [
                                              // ENTER MOBILE OTP

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Pinput(
                                                  controller: controller
                                                      .mobileOtp.value,
                                                  length: 4,
                                                  onChanged: (pin) {
                                                    controller.mobileOtp.value
                                                        .text = pin;

                                                    if (pin.length == 4) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      controller.verifyPhoneOtp(
                                                        controller.defaultUserId
                                                            .value,
                                                        pin,
                                                        context,
                                                      );
                                                    }
                                                  },
                                                  onSubmitted: (pin) {
                                                    controller.mobileOtp.value
                                                        .text = pin;
                                                  },
                                                  defaultPinTheme: PinTheme(
                                                    width: 56,
                                                    height: 56,
                                                    textStyle: const TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.black,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  focusedPinTheme: PinTheme(
                                                    width: 56,
                                                    height: 56,
                                                    textStyle: const TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.blue,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.015,
                                              ),
                                              // OTP Timer
                                              (controller.timerValue.value == 0)
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        try {
                                                          await controller.verifyOtp(
                                                              controller
                                                                  .defaultUserId
                                                                  .value,
                                                              controller
                                                                  .selectedCountry
                                                                  .value!
                                                                  .callingCode
                                                                  .replaceAll(
                                                                      '+', ''),
                                                              context);
                                                          controller.timerValue
                                                              .value = 30;
                                                          controller
                                                              .startTimer();
                                                        } catch (e) {
                                                          showToasterrorborder(
                                                              "Failed to Resend OTP",
                                                              // ignore: use_build_context_synchronously
                                                              context);
                                                          if (kDebugMode) {
                                                            print(
                                                                "Error resending OTP: $e");
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        "Resend OTP",
                                                        style: textStyleW500(
                                                          size.width * 0.042,
                                                          AppColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(
                                                      'Resend OTP ${controller.timerValue.value} seconds',
                                                      style: textStyleW500(
                                                          size.width * 0.042,
                                                          AppColors.blackText),
                                                    ),
                                              SizedBox(
                                                height: size.height * 0.015,
                                              ),
                                              NormalButton(
                                                // Mobile OTP VERIFICATION
                                                text: "Verify",

                                                onPressed: () async {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  controller.isMobileOtpTyping
                                                      .value = true;

                                                  controller
                                                      .mobileOtpValidation();

                                                  if (controller.mobileOtp.value
                                                      .text.isEmpty) {
                                                    showToasterrorborder(
                                                        "Please Enter Mobile OTP",
                                                        context);
                                                  } else if (controller
                                                          .mobileOtp
                                                          .value
                                                          .text
                                                          .length <
                                                      4) {
                                                    showToasterrorborder(
                                                        "Mobile OTP Must be 6 Digits",
                                                        context);
                                                  } else {
                                                    try {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      await controller
                                                          .verifyPhoneOtp(
                                                              controller
                                                                  .defaultUserId
                                                                  .value,
                                                              controller
                                                                  .mobileOtp
                                                                  .value
                                                                  .text,
                                                              context);
                                                    } catch (e) {
                                                      showToasterrorborder(
                                                          "Failed to Verify Mobile OTP",
                                                          // ignore: use_build_context_synchronously
                                                          context);
                                                      if (kDebugMode) {
                                                        print(
                                                            "Error verifying OTP: $e");
                                                      }
                                                    }
                                                  }
                                                },
                                                isLoading: controller.isLoading,
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink();
                                  })
                            : NormalButton(
                                // SEND MOBILE OTP
                                text: "Send OTP",
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  controller.isMlmTyping.value = true;
                                  controller.isNameTyping.value = true;
                                  controller.isMobileTyping.value = true;

                                  controller.mlmCategoryValidation();
                                  controller.nameValidation(context);
                                  controller.mobileValidation();

                                  if (controller.selectedCount.value == 0) {
                                    showToasterrorborder(
                                        "Please Select I am a MLM", context);
                                  } else if (controller
                                          .name.value.text.isEmpty ||
                                      controller.nameError.value) {
                                    showToasterrorborder(
                                        "Please Enter Your Name", context);
                                  } else if (controller
                                      .mobile.value.text.isEmpty) {
                                    showToasterrorborder(
                                        "Please Enter Mobile Number", context);
                                  } else if (controller.nameError.value) {
                                    showToasterrorborder(
                                        "Please Enter Valid Name", context);
                                  } else {
                                    if (controller.selectedCountry.value
                                            ?.callingCode ==
                                        '+91') {
                                      if (controller.mobile.value.text.length !=
                                          10) {
                                        showToasterrorborder(
                                            "Please Enter Valid 10-Digit Mobile Number",
                                            context);
                                        return;
                                      }
                                    } else {
                                      if (controller.mobile.value.text.length <
                                          6) {
                                        showToasterrorborder(
                                            "Please Enter Valid Mobile Number",
                                            context);
                                        return;
                                      }
                                    }

                                    sendOtp();
                                    controller.mobileOtpSend.value = true;
                                    controller.startTimer();
                                  }
                                },

                                isLoading: controller.isLoading,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetFunc(
    BuildContext context,
    size,
    SignupController controller,
    List<GetUserTypeUsertype> userTypes,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.grey,
                    ),
                    width: 80,
                    height: 5,
                  ),
                ),
                5.sbh,
                Center(
                  child: Text(
                    'I am a MLM',
                    style:
                        textStyleW600(size.width * 0.045, AppColors.blackText),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: userTypes.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.toggleSelected(index, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        controller.toggleSelected(
                                            index, context);
                                      },
                                      child: Image.asset(
                                        controller.isTypeSelectedList[index]
                                            ? Assets.imagesTrueCircle
                                            : Assets.imagesCircle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    userTypes[index].name ?? '',
                                    style: textStyleW500(size.width * 0.041,
                                        AppColors.blackText),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100),
                Center(
                  child: NormalButton(
                    text: "Continue",
                    onPressed: () {
                      if (controller.selectedCount > 0) {
                        Get.back();
                      } else {
                        showToasterrorborder(
                            "Please select at least one field.", context);
                      }
                    },
                    isLoading: controller.isLoading,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onPressedShowBottomSheet() async {
    if (!controller.countryCodeReadOnly.value) {
      final country = await showCountryPickerSheet(Get.context!);
      if (country != null) {
        controller.selectedCountry.value = country;
        if (country.callingCode != '+91') {
          _showNonIndiaPopup();
        }
      }
    }
  }

  void _showNonIndiaPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Country Selection'),
          content: const Text('You have selected a country other than India.'),
          actions: <Widget>[
            NormalButton(
              height: 45,
              onPressed: () {
                Get.back();
              },
              text: 'OK',
              isLoading: controller.isLoading,
            )
          ],
        );
      },
    );
  }
}
