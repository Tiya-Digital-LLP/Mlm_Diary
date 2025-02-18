import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/controller/account_setting_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';
import 'package:mlmdiary/widgets/normal_button.dart';
import 'package:mlmdiary/widgets/password_border_text_field.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_auth/smart_auth.dart';

class CustomLoginDetailsScreen extends StatefulWidget {
  const CustomLoginDetailsScreen({super.key});

  @override
  State<CustomLoginDetailsScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<CustomLoginDetailsScreen> {
  final AccountSeetingController controller =
      Get.put(AccountSeetingController());

  final RxBool isChanging = false.obs;
  final RxBool isChangingEmail = false.obs;
  final RxBool isChangingPassword = false.obs;

  int? userId;

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
    fetchUserId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserProfile();
    });
    super.initState();
  }

  void initCountry() async {
    Country? defaultCountry = await getCountryByCountryCode(context, 'IN');
    controller.selectedCountry.value = defaultCountry;
    if (kDebugMode) {
      print('Country: ${controller.selectedCountry}');
    }
  }

  Future<void> fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProfile = controller.userProfile.value.userProfile;

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number',
                              style: textStyleW400(
                                size.width * 0.032,
                                AppColors.blackText,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                isChanging.toggle();
                                if (!isChanging.value) {
                                  controller.resetValuesMobile();
                                }
                              },
                              child: Obx(() => Text(
                                    isChanging.value ? 'Cancel' : 'Change',
                                    style: textStyleW700(
                                        size.width * 0.032,
                                        isChanging.value
                                            ? AppColors.redText
                                            : AppColors.primaryColor),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      10.sbh,
                      Row(
                        children: [
                          Image.asset(
                            controller.selectedCountry.value!.flag,
                            package: countryCodePackageName,
                            width: 20,
                            height: 20,
                          ),
                          3.sbw,
                          Text(
                            '+${userProfile!.countrycode1 ?? 'N/A'}',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                          3.sbw,
                          Text(
                            userProfile.mobile ?? 'N/A',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ],
                      ),
                      16.sbh,
                      Obx(() {
                        if (isChanging.value) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: _onPressedShowBottomSheet,
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
                                                    package:
                                                        countryCodePackageName,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  8.sbw,
                                                  Text(
                                                    controller.selectedCountry
                                                        .value!.callingCode,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.045,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                  10.sbw,
                                  Expanded(
                                    flex: 5,
                                    child: Obx(
                                      () => BorderTextField(
                                        height: 58,
                                        hint: "New Mobile Number",
                                        readOnly:
                                            controller.mobileReadOnly.value,
                                        controller: controller.mobile.value,
                                        textInputType: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboard: TextInputType.phone,
                                        isError: controller.mobileError.value,
                                        byDefault:
                                            !controller.isMobileTyping.value,
                                        onChanged: (value) {
                                          controller.mobileValidation();
                                          controller.isMobileTyping.value =
                                              true;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() {
                                // Show OTP field based on the value of showPhoneOtpField
                                if (controller.showPhoneOtpField.value) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Column(
                                      children: [
                                        Pinput(
                                          controller:
                                              controller.mobileOtp.value,
                                          length: 4,
                                          onChanged: (pin) {
                                            controller.mobileOtp.value.text =
                                                pin;

                                            if (pin.length == 4) {
                                              final mobileOtpText = controller
                                                  .mobileOtp.value.text;
                                              final countryText = controller
                                                  .selectedCountry
                                                  .value!
                                                  .callingCode
                                                  .replaceAll('+', '');

                                              controller.updateVerifyPhoneOtp(
                                                  mobileOtpText,
                                                  countryText,
                                                  context);
                                            }
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
                                                  BorderRadius.circular(8),
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
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        10.sbh,
                                        Obx(
                                          () => (controller.timerValue.value ==
                                                  0)
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    controller.isMobileTyping
                                                        .value = true;
                                                    controller
                                                        .mobileValidation();

                                                    if (controller.mobile.value
                                                        .text.isEmpty) {
                                                      showToasterrorborder(
                                                          "Please Enter Mobile Number",
                                                          context);
                                                    } else {
                                                      if (controller
                                                              .selectedCountry
                                                              .value
                                                              ?.callingCode ==
                                                          '+91') {
                                                        if (controller
                                                                .mobile
                                                                .value
                                                                .text
                                                                .length !=
                                                            10) {
                                                          showToasterrorborder(
                                                              "Please Enter Valid 10-Digit Mobile Number",
                                                              context);
                                                          return;
                                                        }
                                                      } else {
                                                        if (controller
                                                                .mobile
                                                                .value
                                                                .text
                                                                .length <
                                                            6) {
                                                          showToasterrorborder(
                                                              "Please Enter Valid Mobile Number",
                                                              context);
                                                          return;
                                                        }
                                                      }

                                                      await controller
                                                          .sendPhoneOtp(
                                                        controller
                                                            .mobile.value.text
                                                            .trim(),
                                                        controller
                                                            .selectedCountry
                                                            .value!
                                                            .callingCode
                                                            .replaceAll(
                                                                '+', ''),
                                                        context,
                                                      );
                                                      controller.timerValue
                                                          .value = 30;
                                                      controller.stopTimer();
                                                      controller.startTimer();
                                                    }
                                                  },
                                                  child: Text(
                                                    "Resend OTP",
                                                    style: textStyleW500(
                                                      size.width * 0.042,
                                                      AppColors.primaryColor,
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  'Resend OTP ${controller.timerValue.value} seconds',
                                                  style: textStyleW500(
                                                      size.width * 0.042,
                                                      AppColors.blackText),
                                                ),
                                        ),
                                        16.sbh,
                                        NormalButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();

                                            controller.mobileOtpValidation();

                                            if (controller
                                                .mobileOtpError.value) {
                                              showToasterrorborder(
                                                  "Please Enter OTP", context);
                                              return;
                                            }

                                            final mobileOtpText =
                                                controller.mobileOtp.value.text;
                                            final countryText = controller
                                                .selectedCountry
                                                .value!
                                                .callingCode;

                                            controller.updateVerifyPhoneOtp(
                                                mobileOtpText,
                                                countryText,
                                                context);
                                          },
                                          text: 'Verify',
                                          isLoading: controller.isLoading,
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                              16.sbh,
                              Obx(() {
                                // Show button only if OTP field is hidden
                                if (!controller.showPhoneOtpField.value) {
                                  return NormalButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();

                                      controller.isMobileTyping.value = true;

                                      controller.mobileValidation();

                                      if (controller
                                          .mobile.value.text.isEmpty) {
                                        showToasterrorborder(
                                            "Please Enter Mobile Number",
                                            context);
                                      } else {
                                        if (controller.selectedCountry.value
                                                ?.callingCode ==
                                            '+91') {
                                          if (controller
                                                  .mobile.value.text.length !=
                                              10) {
                                            showToasterrorborder(
                                                "Please Enter Valid 10-Digit Mobile Number",
                                                context);
                                            return;
                                          }
                                        } else {
                                          if (controller
                                                  .mobile.value.text.length <
                                              6) {
                                            showToasterrorborder(
                                                "Please Enter Valid Mobile Number",
                                                context);
                                            return;
                                          }
                                        }

                                        controller.sendPhoneOtp(
                                          controller.mobile.value.text.trim(),
                                          controller.selectedCountry.value!
                                              .callingCode
                                              .replaceAll('+', ''),
                                          context,
                                        );
                                        controller.timerValue.value = 30;
                                        controller.startTimer();
                                      }
                                    },
                                    text: 'Send OTP',
                                    isLoading: controller.isLoading,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email Address',
                              style: textStyleW400(
                                size.width * 0.032,
                                AppColors.blackText,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                isChangingEmail.toggle();
                                if (!isChangingEmail.value) {
                                  controller.resetValuesEmail();
                                }
                              },
                              child: Obx(() => Text(
                                    isChangingEmail.value ? 'Cancel' : 'Change',
                                    style: textStyleW700(
                                        size.width * 0.032,
                                        isChangingEmail.value
                                            ? AppColors.redText
                                            : AppColors.primaryColor),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      10.sbh,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          userProfile.email ?? '',
                          style: textStyleW700(
                            size.width * 0.032,
                            AppColors.blackText,
                          ),
                        ),
                      ),
                      16.sbh,
                      Obx(() {
                        if (isChangingEmail.value) {
                          return Column(
                            children: [
                              Obx(
                                () => BorderTextField(
                                  controller: controller.email.value,
                                  hint: "Email Address *",
                                  textInputType: const [],
                                  keyboard: TextInputType.emailAddress,
                                  isError: controller.emailError.value,
                                  byDefault: !controller.isEmailTyping.value,
                                  onChanged: (value) {
                                    controller.emailValidation();
                                    controller.isEmailTyping.value = true;
                                  },
                                ),
                              ),
                              16.sbh,
                              Obx(() {
                                if (controller.showEmailOtpField.value) {
                                  return Column(
                                    children: [
                                      Pinput(
                                        controller: controller.emailOtp.value,
                                        length: 4,
                                        onChanged: (pin) {
                                          controller.emailOtp.value.text = pin;

                                          if (pin.length == 4) {
                                            controller.updateVerifyEmailOtp(
                                                controller.emailOtp.value.text,
                                                context);
                                          }
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
                                                BorderRadius.circular(8),
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
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      10.sbh,
                                      Obx(
                                        () => (controller.timerValue.value == 0)
                                            ? GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  controller.isEmailTyping
                                                      .value = true;

                                                  controller.emailValidation();

                                                  if (controller.email.value
                                                      .text.isEmpty) {
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
                                                    controller
                                                        .updateEmail(context);
                                                    controller
                                                        .timerValue.value = 30;
                                                    controller.stopTimer();
                                                    controller.startTimer();
                                                  }
                                                },
                                                child: Text(
                                                  "Resend OTP",
                                                  style: textStyleW500(
                                                    size.width * 0.042,
                                                    AppColors.primaryColor,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                'Resend OTP ${controller.timerValue.value} seconds',
                                                style: textStyleW500(
                                                    size.width * 0.042,
                                                    AppColors.blackText),
                                              ),
                                      ),
                                      16.sbh,
                                      NormalButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          controller.isEmailTyping.value = true;

                                          controller.emailValidation();

                                          if (controller
                                              .email.value.text.isEmpty) {
                                            showToasterrorborder(
                                                "Please Enter Email", context);
                                          } else if (controller
                                                  .emailError.value ==
                                              true) {
                                            showToasterrorborder(
                                                "Please Enter Valid Email",
                                                context);
                                          } else {
                                            controller.updateEmail(context);
                                          }
                                        },
                                        text: 'Verify',
                                        isLoading: controller.isLoading,
                                      )
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                              Obx(() {
                                if (!controller.showEmailOtpField.value) {
                                  return NormalButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      controller.isEmailTyping.value = true;

                                      controller.emailValidation();

                                      if (controller.email.value.text.isEmpty) {
                                        showToasterrorborder(
                                            "Please Enter Email", context);
                                      } else if (controller.emailError.value ==
                                          true) {
                                        showToasterrorborder(
                                            "Please Enter Valid Email",
                                            context);
                                      } else {
                                        controller.updateEmail(context);
                                        controller.timerValue.value = 30;
                                        controller.startTimer();
                                      }
                                    },
                                    text: 'Send OTP',
                                    isLoading: controller.isLoading,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password',
                              style: textStyleW400(
                                size.width * 0.032,
                                AppColors.blackText,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                isChangingPassword.toggle();
                                if (!isChangingPassword.value) {
                                  controller.resetValuesPassword();
                                }
                              },
                              child: Obx(
                                () => Text(
                                  isChangingPassword.value
                                      ? 'Cancel'
                                      : 'Change',
                                  style: textStyleW700(
                                      size.width * 0.032,
                                      isChangingPassword.value
                                          ? AppColors.redText
                                          : AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.sbh,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '●●●●●●●●●',
                          style: textStyleW700(
                            size.width * 0.032,
                            AppColors.blackText,
                          ),
                        ),
                      ),
                      16.sbh,
                      Obx(() {
                        if (isChangingPassword.value) {
                          return Column(
                            children: [
                              Obx(
                                () => PasswordBorderTextField(
                                  controller: controller.password.value,
                                  hint: "New Password",
                                  textInputType: const [],
                                  keyboard: TextInputType.text,
                                  isError: controller.passwordError.value,
                                  byDefault: !controller.isPasswordTyping.value,
                                  onChanged: (value) {
                                    controller.passwordValidation();
                                    controller.isPasswordTyping.value = true;
                                  },
                                  maxLength: 18,
                                ),
                              ),
                              10.sbh,
                              Obx(
                                () => PasswordBorderTextField(
                                  controller: controller.confirmPassword.value,
                                  hint: "Confirm Password",
                                  textInputType: const [],
                                  isError:
                                      controller.confirmPasswordError.value,
                                  keyboard: TextInputType.text,
                                  byDefault:
                                      !controller.isConfirmPasswordTyping.value,
                                  maxLength: 18,
                                  onChanged: (value) {
                                    controller.confirmPasswordValidation();
                                    controller.isConfirmPasswordTyping.value =
                                        true;
                                  },
                                ),
                              ),
                              16.sbh,
                              NormalButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  // Run validations
                                  controller.passwordValidation();
                                  controller.confirmPasswordValidation();

                                  if (controller.password.value.text.isEmpty) {
                                    showToasterrorborder(
                                        "Please enter a new password.",
                                        context);
                                  } else if (controller.passwordError.value) {
                                    showToasterrorborder(
                                        "Password must be at least 6 characters.",
                                        context);
                                  } else if (controller
                                      .confirmPassword.value.text.isEmpty) {
                                    showToasterrorborder(
                                        "Please enter confirm password.",
                                        context);
                                  } else if (controller
                                      .confirmPasswordError.value) {
                                    showToasterrorborder(
                                        "Confirm Password must be at least 6 characters and match Password.",
                                        context);
                                  } else {
                                    controller.sendChangePasswordRequest(
                                      context,
                                      userId!,
                                      controller.password.value.text,
                                    );
                                  }
                                },
                                text: 'Change Password',
                                isLoading: controller.isLoading,
                              )
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            LogoutDialog.show(context, () {
              controller.deleteAccount(context);
            });
          },
          child: Text(
            'Delete Account',
            style: textStyleW400(
              size.width * 0.032,
              // ignore: deprecated_member_use
              AppColors.redText.withOpacity(0.5),
            ),
          ),
        )
      ],
    );
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      controller.selectedCountry.value = country;
    }
  }
}
