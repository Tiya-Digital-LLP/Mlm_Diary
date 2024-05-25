import 'dart:developer';

import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_user_type_entity.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/sign_up/controller/signup_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/common_header.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/password_border_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final Rx<Country?> selectedCountry = Rx<Country?>(null);

  final SignupController controller = Get.put((SignupController()));

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    Country? defaultCountry = await getCountryByCountryCode(context, 'IN');
    selectedCountry.value = defaultCountry;
    if (kDebugMode) {
      print('Country: $selectedCountry');
    }
  }

  bool isDomesticPhoneNumber(String mobile) {
    return selectedCountry.value != null &&
        selectedCountry.value!.callingCode == '+91';
  }

  void sendOtp() {
    final mobileNumber = controller.mobile.value.text;
    final userName = controller.name.value.text;
    final countryCode = selectedCountry.value?.callingCode ?? '';

    if (isDomesticPhoneNumber(mobileNumber)) {
      controller.sendDomesticPhoneOtp(mobileNumber, userName, countryCode);
    } else {
      controller.sendForeignPhoneOtp(mobileNumber, userName, countryCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              hintText: "I am a MLM*",
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.blackText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Obx(
                      () => BorderTextField(
                        maxLength: 25,
                        height: 65,
                        keyboard: TextInputType.name,
                        textInputType: const [],
                        hint: "Your Name",
                        readOnly: controller.nameReadOnly.value,
                        controller: controller.name.value,
                        isError: controller.nameError.value,
                        byDefault: !controller.isNameTyping.value,
                        onChanged: (value) {
                          controller.nameValidation();
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
                              height: 65,
                              child: BorderContainer(
                                height: 60,
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
                                              package: countryCodePackageName,
                                              width: 25,
                                              height: 25,
                                            ),
                                            8.sbw,
                                            Text(
                                              selectedCountry
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
                              () => BorderTextField(
                                maxLength: 11,
                                height: 65,
                                hint: "Mobile Number",
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
                                    hint: "Email Address",
                                    textInputType: const [],
                                    keyboard: TextInputType.emailAddress,
                                    isError: controller.emailError.value,
                                    byDefault: !controller.isEmailTyping.value,
                                    maxLength: 25,
                                    onChanged: (value) {
                                      controller.emailValidation();
                                      controller.isEmailTyping.value = true;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  Obx(() => (controller.emailOtpSend.value)
                                      ? (controller.showPasswordField.value)
                                          ? Column(
                                              children: [
                                                PasswordBorderTextField(
                                                    controller: controller
                                                        .password.value,
                                                    hint: "Your Password",
                                                    textInputType: const [],
                                                    keyboard:
                                                        TextInputType.text,
                                                    isError: controller
                                                        .passwordError.value,
                                                    byDefault: !controller
                                                        .isPasswordTyping.value,
                                                    onChanged: (value) {
                                                      controller
                                                          .passwordValidation();
                                                      controller
                                                          .isPasswordTyping
                                                          .value = true;
                                                    },
                                                    maxLength: 18),
                                                SizedBox(
                                                  height: size.height * 0.015,
                                                ),
                                                PasswordBorderTextField(
                                                  controller: controller
                                                      .confirmPassword.value,
                                                  hint: "Confirm Your Password",
                                                  textInputType: const [],
                                                  isError: controller
                                                      .confirmPasswordError
                                                      .value,
                                                  keyboard: TextInputType.text,
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
                                                  height: size.height * 0.02,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        height:
                                                            size.height * 0.030,
                                                        width:
                                                            size.height * 0.030,
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
                                                            child: Image.asset(
                                                              (controller
                                                                      .termsCondition
                                                                      .value)
                                                                  ? Assets
                                                                      .imagesCheck
                                                                  : Assets
                                                                      .imagesSquare,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: size.width * 0.02,
                                                    ),
                                                    Text(
                                                      "I agree with ",
                                                      style: textStyleW400(
                                                          size.width * 0.045,
                                                          AppColors.blackText),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(Routes
                                                            .advertisewithus);
                                                      },
                                                      child: Text(
                                                        "Terms & Conditions",
                                                        style: textStyleW500(
                                                            size.width * 0.045,
                                                            const Color(
                                                                0XFF005C94)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                CustomButton(
                                                  title: "Continue",
                                                  btnColor:
                                                      AppColors.primaryColor,
                                                  titleColor: AppColors.white,
                                                  onTap: () {
                                                    if (controller.password
                                                        .value.text.isEmpty) {
                                                      ToastUtils.showToast(
                                                          "Please Enter Password");
                                                    } else if (controller
                                                            .password
                                                            .value
                                                            .text
                                                            .length <
                                                        6) {
                                                      ToastUtils.showToast(
                                                          "Password Have Must be 6 Character");
                                                    } else if (controller
                                                        .confirmPassword
                                                        .value
                                                        .text
                                                        .isEmpty) {
                                                      ToastUtils.showToast(
                                                          "Please Enter Confirm Password");
                                                    } else if (controller
                                                            .password
                                                            .value
                                                            .text !=
                                                        controller
                                                            .confirmPassword
                                                            .value
                                                            .text) {
                                                      ToastUtils.showToast(
                                                          "Both Password Should be Same");
                                                    } else if (controller
                                                            .termsCondition
                                                            .value ==
                                                        false) {
                                                      ToastUtils.showToast(
                                                          "Please Agree Terms & Conditions");
                                                    } else {
                                                      log("Signup Process Start");

                                                      controller.registerUser(
                                                        controller.defaultUserId
                                                            .value,
                                                        controller.password
                                                            .value.text,
                                                      );
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Already have account?  ",
                                                      style: textStyleW400(
                                                          size.width * 0.045,
                                                          AppColors.blackText),
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
                                                          fontSize: size.width *
                                                              0.045,
                                                          color:
                                                              AppColors.redText,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                BorderTextField(
                                                  controller:
                                                      controller.emailOtp.value,
                                                  hint: "Enter OTP",
                                                  textInputType: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboard:
                                                      TextInputType.number,
                                                  isError: controller
                                                      .emailOtpError.value,
                                                  byDefault: !controller
                                                      .isEmailOtpTyping.value,
                                                  maxLength: 6,
                                                  onChanged: (value) {
                                                    controller
                                                        .emailOtpValidation();
                                                    controller.isEmailOtpTyping
                                                        .value = true;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.015,
                                                ),
                                                (controller.timerValue.value ==
                                                        0)
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          // Resend email OTP
                                                          String email =
                                                              controller.email
                                                                  .value.text;
                                                          int userId =
                                                              controller
                                                                  .defaultUserId
                                                                  .value;
                                                          if (email
                                                                  .isNotEmpty &&
                                                              userId != 0) {
                                                            controller
                                                                .sendEmailOtp(
                                                                    email,
                                                                    userId);
                                                            controller
                                                                .timerValue
                                                                .value = 30;
                                                            controller
                                                                .startTimer();
                                                            ToastUtils.showToast(
                                                                "Email OTP Resend Successfully");
                                                          } else {
                                                            ToastUtils.showToast(
                                                                "Please enter a valid email");
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
                                                            size.width * 0.042,
                                                            AppColors
                                                                .blackText),
                                                      ),
                                                SizedBox(
                                                  height: size.height * 0.015,
                                                ),
                                                CustomButton(
                                                  title: "Verify",
                                                  btnColor:
                                                      AppColors.primaryColor,
                                                  titleColor: AppColors.white,
                                                  onTap: () {
                                                    if (controller.emailOtp
                                                        .value.text.isEmpty) {
                                                      ToastUtils.showToast(
                                                          "Please Enter Email OTP");
                                                    } else if (controller
                                                            .emailOtp
                                                            .value
                                                            .text
                                                            .length <
                                                        6) {
                                                      ToastUtils.showToast(
                                                          "OTP Must be 6 Digits");
                                                    } else {
                                                      String email = controller
                                                          .email.value.text;
                                                      int userId = controller
                                                          .defaultUserId.value;
                                                      String otp = controller
                                                          .emailOtp.value.text;

                                                      // Call the verifyEmail method from the controller
                                                      controller.verifyEmail(
                                                          email, userId, otp);
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.015,
                                                ),
                                                Text(
                                                  "Please check your email, and enter verification code below. You may need to check your Spam or Junk folder as well.",
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          size.width * 0.042),
                                                )
                                              ],
                                            )
                                      : CustomButton(
                                          // SEND EMAIL OTP
                                          title: "Send OTP",
                                          btnColor: AppColors.primaryColor,
                                          titleColor: AppColors.white,
                                          onTap: () {
                                            String email =
                                                controller.email.value.text;
                                            int userId =
                                                controller.defaultUserId.value;
                                            if (controller
                                                .email.value.text.isEmpty) {
                                              ToastUtils.showToast(
                                                  "Please Enter Email");
                                            } else if (controller
                                                    .emailError.value ==
                                                true) {
                                              ToastUtils.showToast(
                                                  "Please Enter Valid Email");
                                            } else {
                                              ToastUtils.showToast(
                                                  "Email OTP Sent Successfully");
                                              controller.sendEmailOtp(
                                                  email, userId);
                                              controller.emailOtpSend.value =
                                                  true;
                                              controller.startTimer();
                                            }
                                          },
                                        ))
                                ])
                              : Column(
                                  children: [
                                    // ENTER MOBILE OTP
                                    BorderTextField(
                                      controller: controller.mobileOtp.value,
                                      hint: "Enter OTP",
                                      textInputType: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboard: TextInputType.number,
                                      isError: controller.mobileOtpError.value,
                                      byDefault:
                                          !controller.isMobileOtpTyping.value,
                                      maxLength: 6,
                                      onChanged: (value) {
                                        controller.mobileOtpValidation();
                                        controller.isMobileOtpTyping.value =
                                            true;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    // OTP Timer
                                    (controller.timerValue.value == 0)
                                        ? GestureDetector(
                                            onTap: () async {
                                              try {
                                                await controller.verifyOtp(
                                                    controller
                                                        .defaultUserId.value);
                                                controller.timerValue.value =
                                                    30;
                                                controller.startTimer();
                                                ToastUtils.showToast(
                                                    "OTP Resent Successfully");
                                              } catch (e) {
                                                ToastUtils.showToast(
                                                    "Failed to Resend OTP");
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
                                                AppColors.primaryColor,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Resent OTP ${controller.timerValue.value} seconds',
                                            style: textStyleW500(
                                                size.width * 0.042,
                                                AppColors.blackText),
                                          ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    CustomButton(
                                      // Mobile OTP VERIFICATION
                                      title: "Verify",
                                      btnColor: AppColors.primaryColor,
                                      titleColor: AppColors.white,
                                      onTap: () async {
                                        if (controller
                                            .mobileOtp.value.text.isEmpty) {
                                          ToastUtils.showToast(
                                              "Please Enter Mobile OTP");
                                        } else if (controller
                                                .mobileOtp.value.text.length <
                                            6) {
                                          ToastUtils.showToast(
                                              "Mobile OTP Must be 6 Digits");
                                        } else {
                                          try {
                                            await controller.verifyPhoneOtp(
                                              controller.defaultUserId
                                                  .value, // Pass the user ID
                                              controller.mobileOtp.value
                                                  .text, // Pass the OTP entered by the user
                                            );
                                            controller.stopTimer();
                                          } catch (e) {
                                            ToastUtils.showToast(
                                                "Failed to Verify Mobile OTP");
                                            if (kDebugMode) {
                                              print("Error verifying OTP: $e");
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                )
                          : CustomButton(
                              // SEND MOBILE OTP
                              title: "Send OTP",
                              btnColor: AppColors.primaryColor,
                              titleColor: AppColors.white,
                              onTap: () {
                                if (controller.selectedCount.value < 1) {
                                  ToastUtils.showToast(
                                      "Please Select At least One MLM Type");
                                } else if (controller.name.value.text.isEmpty) {
                                  ToastUtils.showToast("Please Enter Name");
                                } else if (controller
                                    .mobile.value.text.isEmpty) {
                                  ToastUtils.showToast(
                                      "Please Enter Mobile Number");
                                } else if (controller.nameError.value == true) {
                                  ToastUtils.showToast(
                                      "Please Enter Valid Name");
                                } else if (controller.mobile.value.text.length <
                                    6) {
                                  ToastUtils.showToast(
                                      "Please Enter Valid Mobile Number");
                                } else {
                                  log("Mobile OTP Sent Successfully");
                                  ToastUtils.showToast("OTP Sent Successfully");
                                  controller.mobileOtpSend.value = true;
                                  controller.startTimer();
                                  sendOtp();
                                }
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
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
                    'I am a MLM*',
                    style:
                        textStyleW600(size.width * 0.045, AppColors.blackText),
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: userTypes.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.toggleSelected(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      controller.toggleSelected(index);
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
                                  style: textStyleW500(
                                      size.width * 0.041, AppColors.blackText),
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
                const SizedBox(height: 100),
                Center(
                  child: CustomButton(
                    title: "Continue",
                    btnColor: AppColors.primaryColor,
                    titleColor: AppColors.white,
                    onTap: () {
                      if (controller.selectedCount > 0) {
                        Get.back();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please select at least one field.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
