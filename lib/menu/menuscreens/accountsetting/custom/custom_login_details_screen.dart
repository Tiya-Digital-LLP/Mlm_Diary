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
import 'package:mlmdiary/widgets/normal_button.dart';
import 'package:mlmdiary/widgets/password_border_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomLoginDetailsScreen extends StatefulWidget {
  const CustomLoginDetailsScreen({super.key});

  @override
  State<CustomLoginDetailsScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<CustomLoginDetailsScreen> {
  final Rx<Country?> selectedCountry = Rx<Country?>(null);
  final AccountSeetingController controller =
      Get.put(AccountSeetingController());

  final RxBool isChanging = false.obs;
  final RxBool isChangingEmail = false.obs;
  final RxBool isChangingPassword = false.obs;

  int? userId;

  @override
  void initState() {
    initCountry();
    fetchUserId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserProfile();
    });
    super.initState();
  }

  void initCountry() async {
    Country? defaultCountry = await getCountryByCountryCode(context, 'IN');
    selectedCountry.value = defaultCountry;
    if (kDebugMode) {
      print('Country: $selectedCountry');
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
                          Icon(
                            Icons.flag,
                            size: 17,
                            color: AppColors.bottomIcon,
                          ),
                          3.sbw,
                          Text(
                            userProfile!.countrycode1 ?? 'N/A',
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
                                      height: 65,
                                      child: selectedCountry.value == null
                                          ? Container()
                                          : Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    selectedCountry.value!.flag,
                                                    package:
                                                        countryCodePackageName,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  8.sbw,
                                                  Text(
                                                    selectedCountry
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
                                        height: 65,
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
                              16.sbh,
                              Obx(() {
                                // Show OTP field based on the value of showPhoneOtpField
                                if (controller.showPhoneOtpField.value) {
                                  return Column(
                                    children: [
                                      BorderTextField(
                                        controller: controller.mobileOtp.value,
                                        hint: "Enter OTP",
                                        textInputType: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboard: TextInputType.number,
                                        isError:
                                            controller.mobileOtpError.value,
                                        byDefault:
                                            !controller.isMobileOtpTyping.value,
                                        onChanged: (value) {
                                          controller.mobileOtpValidation();
                                          controller.isMobileOtpTyping.value =
                                              true;
                                        },
                                      ),
                                      16.sbh,
                                      NormalButton(
                                        onPressed: () {
                                          // Access the TextEditingController instance and then get its text
                                          final mobileOtpText =
                                              controller.mobileOtp.value.text;
                                          final countryText = selectedCountry
                                              .value!.callingCode;

                                          // Call updateVerifyPhoneOtp method here
                                          controller.updateVerifyPhoneOtp(
                                              mobileOtpText,
                                              countryText,
                                              context);
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
                              16.sbh,
                              Obx(() {
                                // Show button only if OTP field is hidden
                                if (!controller.showPhoneOtpField.value) {
                                  return NormalButton(
                                    onPressed: () {
                                      // Call your API function here
                                      controller.sendPhoneOtp(
                                          controller.mobile.value.text,
                                          selectedCountry.value!.callingCode,
                                          context);
                                    },
                                    text: 'Send Otp',
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
                                  keyboard: TextInputType.name,
                                  textInputType: const [],
                                  hint: "New Email Address",
                                  controller: controller.email.value,
                                  byDefault: !controller.isEmailTyping.value,
                                  height: 65,
                                ),
                              ),
                              16.sbh,
                              Obx(() {
                                if (controller.showEmailOtpField.value) {
                                  return Column(
                                    children: [
                                      BorderTextField(
                                        controller: controller.emailOtp.value,
                                        hint: "Enter OTP",
                                        textInputType: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboard: TextInputType.number,
                                        isError: controller.emailOtpError.value,
                                        byDefault:
                                            !controller.isemailOtpTyping.value,
                                        onChanged: (value) {
                                          controller.emailOtpValidation();
                                          controller.isemailOtpTyping.value =
                                              true;
                                        },
                                      ),
                                      16.sbh,
                                      NormalButton(
                                        onPressed: () {
                                          controller.updateVerifyEmailOtp(
                                              controller.emailOtp.value.text,
                                              context);
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
                                // Show button only if OTP field is hidden
                                if (!controller.showEmailOtpField.value) {
                                  return NormalButton(
                                    onPressed: () {
                                      // Call your API function here
                                      controller.updateEmail();
                                    },
                                    text: 'Send Otp',
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
                                  hint: "Your Password",
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
                                  hint: "Confirm Your Password",
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
                                  // Check if passwords match
                                  if (controller.password.value.text !=
                                      controller.confirmPassword.value.text) {
                                    showToasterrorborder(
                                        "Both Passwords Should be the Same.",
                                        context);
                                  } else {
                                    // Call the method to send the change password request
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
      ],
    );
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      selectedCountry.value = country;
    }
  }
}
