import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/forgotpassword/controller/forgot_password_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_mobile_field.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    initCountry();
    _tabController = TabController(length: 2, vsync: this);
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

  String getFormattedCountryCode() {
    // Removes the '+' sign from the country code
    return controller.selectedCountry.value?.callingCode.replaceAll('+', '') ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: AppColors.white),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomBackButton(),
              ),
              SizedBox(
                height: size.height * 0.20,
                width: size.height * 0.20,
                child: Image.asset(Assets.imagesLock),
              ),
              SizedBox(height: size.height * 0.035),
              Text(
                "Forgot password?",
                style: textStyleW700(size.width * 0.075, AppColors.blackText),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                "Enter your email for verification process,\nwe will send 4 digits code to your email",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: textStyleW500(size.width * 0.040, AppColors.blackText),
              ),
              20.sbh,
              Container(
                color: AppColors.white,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _tabController,
                  indicatorColor: AppColors.primaryColor,
                  indicatorWeight: 1.5,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.grey,
                  tabs: const [
                    Tab(text: 'Email'),
                    Tab(text: 'Mobile'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          20.sbh,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Obx(
                              () => BorderTextField(
                                height: 58,
                                controller: controller.email.value,
                                hint: "Enter Your Email",
                                textInputType: const [],
                                isError: controller.emailError.value,
                                keyboard: TextInputType.emailAddress,
                                byDefault: !controller.isEmailTyping.value,
                                onChanged: (value) {
                                  controller.emailValidation();
                                  controller.isEmailTyping.value = true;
                                },
                              ),
                            ),
                          ),
                          20.sbh,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: NormalButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                controller.emailValidation();
                                if (controller.email.value.text.isEmpty) {
                                  showToasterrorborder(
                                      "Please Enter Email", context);
                                } else {
                                  controller.sendForgotPasswordRequest(
                                    context,
                                    getFormattedCountryCode(),
                                  );

                                  controller.startTimer();
                                }
                              },
                              text: 'Submit',
                              isLoading: controller.isLoading,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => SingleChildScrollView(
                          child: Column(children: [
                            20.sbh,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: _onPressedShowBottomSheet,
                                    child: SizedBox(
                                      width: 120,
                                      height: 58,
                                      child: BorderContainer(
                                        height: 58,
                                        child: controller
                                                    .selectedCountry.value ==
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: textStyleW400(
                                                        size.width * 0.038,
                                                        AppColors.blackText,
                                                        isMetropolis: true,
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
                                        hint: "Enter Your Mobile Number",
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
                            ),
                            20.sbh,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: NormalButton(
                                text: "Submit",
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  controller.mobileValidation();
                                  if (controller.mobile.value.text.isEmpty) {
                                    showToasterrorborder(
                                        "Please Enter Mobile", context);
                                  } else {
                                    controller.sendForgotPasswordRequest(
                                      context,
                                      getFormattedCountryCode(),
                                    );
                                    controller.startTimer();
                                  }
                                },
                                isLoading: controller.isLoading,
                              ),
                            ),
                          ]),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(context);
    if (country != null) {
      controller.selectedCountry.value = country;
    }
  }
}
