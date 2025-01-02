// ignore_for_file: deprecated_member_use

import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/contactus/controller/contactus_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/discription_text_field.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/normal_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final ContactusController controller = Get.put(ContactusController());
  final ProfileController profileController = Get.put(ProfileController());

  final Rx<Country?> _selectedCountry = Rx<Country?>(null);

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    _selectedCountry.value = country;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact us',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: AppColors.background,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.svgContactUsBgImage,
                  height: 150,
                ),
                select_sub_dropdown(
                  controller.listitem2.cast<String>(),
                  'Select Subject',
                  'Select Subject',
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Obx(
                  () => BorderTextField(
                    keyboard: TextInputType.name,
                    textInputType: const [],
                    hint: "Your Name*",
                    controller: controller.name.value,
                    byDefault: !controller.isNameTyping.value,
                    isError: controller.nameError.value,
                    onChanged: (value) {
                      controller.nameValidation(context);
                      controller.isNameTyping.value = true;
                    },
                    height: 58,
                  ),
                ),
                10.sbh,
                Obx(
                  () => BorderTextField(
                    keyboard: TextInputType.emailAddress,
                    textInputType: const [],
                    hint: "Email Address*",
                    controller: controller.email.value,
                    isError: controller.emailError.value,
                    byDefault: !controller.isEmailTyping.value,
                    onChanged: (value) {
                      controller.emailValidation();
                      controller.isEmailTyping.value = true;
                    },
                    height: 58,
                  ),
                ),
                10.sbh,
                Row(
                  children: [
                    GestureDetector(
                      onTap: _onPressedShowBottomSheet,
                      child: SizedBox(
                        width: 120,
                        height: 58,
                        child: BorderContainer(
                          height: 58,
                          child: Obx(() {
                            final country = _selectedCountry.value;
                            return country == null
                                ? Container()
                                : Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          country.flag,
                                          package: countryCodePackageName,
                                          width: 25,
                                          height: 25,
                                        ),
                                        8.sbw,
                                        Text(
                                          country.callingCode,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: size.width * 0.045,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                        ),
                      ),
                    ),
                    10.sbw,
                    Expanded(
                      child: Obx(
                        () => BorderTextField(
                          height: 58,
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
                10.sbh,
                Obx(
                  () => BorderTextField(
                    keyboard: TextInputType.multiline,
                    textInputType: const [],
                    readOnly: true,
                    hint: "Company",
                    controller: controller.company.value,
                    byDefault: !controller.isCompanyTyping.value,
                    onChanged: (value) {},
                    height: 58,
                  ),
                ),
                10.sbh,
                Obx(
                  () => DiscriptionTextField(
                    keyboard: TextInputType.multiline,
                    textInputType: const [],
                    hint: "Message*",
                    controller: controller.message.value,
                    byDefault: !controller.isMessageTyping.value,
                    isError: controller.messageError.value,
                    onChanged: (value) {
                      controller.messageValidation();
                      controller.isMessageTyping.value = true;
                    },
                  ),
                ),
                20.sbh,
                NormalButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    controller.nameValidation(context);
                    controller.emailValidation();
                    controller.mobileValidation();
                    controller.messageValidation();

                    if (controller.selectedItem.value.isEmpty) {
                      controller.dropItemError.value =
                          true; // Explicitly set the error state
                      showToasterrorborder(
                        "Please select an item from the dropdown.",
                        context,
                      );
                    } else if (controller.name.value.text.isEmpty) {
                      showToasterrorborder(
                        "Name field cannot be empty.",
                        context,
                      );
                    } else if (controller.email.value.text.isEmpty) {
                      showToasterrorborder(
                        "Email field cannot be empty.",
                        context,
                      );
                    } else if (controller.message.value.text.isEmpty) {
                      showToasterrorborder(
                        "Message field cannot be empty.",
                        context,
                      );
                    } else if (controller.mobile.value.text.isEmpty) {
                      showToasterrorborder(
                        "Mobile Number field cannot be empty.",
                        context,
                      );
                    } else if (controller.nameError.value) {
                      showToasterrorborder(
                        "Please enter a valid name. It should start with a capital letter and contain only alphabets.",
                        context,
                      );
                    } else if (controller.emailError.value) {
                      showToasterrorborder(
                        "Please enter a valid email address.",
                        context,
                      );
                    } else if (controller.mobileError.value) {
                      showToasterrorborder(
                        "Please enter a valid 10-digit mobile number.",
                        context,
                      );
                    } else if (controller.messageError.value) {
                      showToasterrorborder(
                        "Please enter a Purpose Message.",
                        context,
                      );
                    } else {
                      controller.dropItemError.value = false;
                      controller.contactus(context);
                    }
                  },
                  text: 'Submit',
                  isLoading: controller.isLoading,
                ),
                30.sbh,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.white,
                      boxShadow: [customBoxShadow()]),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Helpline Number',
                          style: textStyleW600(
                              size.width * 0.042, AppColors.blackText),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '+91 8866409933',
                              style: textStyleW700(
                                  size.width * 0.060, AppColors.blackText),
                            ),
                            60.sbw,
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  final Uri phoneUri =
                                      Uri(scheme: 'tel', path: '8866409933');
                                  launchUrl(phoneUri);
                                  if (kDebugMode) {
                                    print('tap with number');
                                  }
                                },
                                icon: SvgPicture.asset(
                                  Assets.svgMobileIconContactUs,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'For MLM Paid Advertising',
                          style: textStyleW500(
                              size.width * 0.032, AppColors.blackText),
                        ),
                      ],
                    ),
                  ),
                ),
                10.sbh,
                Obx(
                  () {
                    final mlmSocial =
                        profileController.mlmSocial.value.sitesetting;
                    final profile =
                        profileController.userProfile.value.userProfile;

                    if (controller.isLoading.value) {
                      return Center(
                          child: CustomLottieAnimation(
                        child: Lottie.asset(
                          Assets.lottieLottie,
                        ),
                      ));
                    }

                    return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: ShapeDecoration(
                            color: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.05),
                            ),
                            shadows: [customBoxShadow()]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Follow MLM Diary',
                              style: textStyleW500(
                                  size.width * 0.030, AppColors.blackText),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    if (mlmSocial!.whatsapp != null) {
                                      final String phoneNumber =
                                          mlmSocial.whatsapp!;
                                      final String name =
                                          profile!.name ?? 'N/A';
                                      String message =
                                          "Hello, I am $name. I want to know regarding MLM Diary App.";
                                      final Uri whatsappUri = Uri.parse(
                                          "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

                                      if (await canLaunchUrl(whatsappUri)) {
                                        await launchUrl(whatsappUri);
                                        if (kDebugMode) {
                                          print('URL: $whatsappUri');
                                        }
                                      } else {
                                        if (kDebugMode) {
                                          print(
                                              'Could not launch $whatsappUri');
                                        }
                                        showToasterrorborder(
                                            "Could not launch WhatsApp",
                                            // ignore: use_build_context_synchronously
                                            context);
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Found", context);
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                      Assets.svgLogosWhatsappIcon,
                                      height: 26,
                                      width: 26),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (mlmSocial!.facebookLink != null) {
                                      _launchURL(
                                          mlmSocial.facebookLink.toString());
                                      if (kDebugMode) {
                                        print('URL: ${mlmSocial.facebookLink}');
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Fond", context);
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                      Assets.svgLogosFacebook,
                                      height: 26,
                                      width: 26),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (mlmSocial!.intagramLink != null) {
                                      _launchURL(
                                          mlmSocial.intagramLink.toString());
                                      if (kDebugMode) {
                                        print('URL: ${mlmSocial.intagramLink}');
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Fond", context);
                                    }
                                  },
                                  icon: SvgPicture.asset(Assets.svgInstagram,
                                      height: 26, width: 26),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (mlmSocial!.linkedinLink != null) {
                                      _launchURL(
                                          mlmSocial.linkedinLink.toString());
                                      if (kDebugMode) {
                                        print('URL: ${mlmSocial.linkedinLink}');
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Fond", context);
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                      Assets.svgLogosLinkedinIcon,
                                      height: 26,
                                      width: 26),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (mlmSocial!.youtubeLink != null) {
                                      _launchURL(
                                          mlmSocial.youtubeLink.toString());
                                      if (kDebugMode) {
                                        print('URL: ${mlmSocial.youtubeLink}');
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Fond", context);
                                    }
                                  },
                                  icon: SvgPicture.asset(Assets.svgYoutube,
                                      height: 26, width: 26),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (mlmSocial!.telegramLink != null) {
                                      _launchURL(
                                          mlmSocial.telegramLink.toString());
                                      if (kDebugMode) {
                                        print('URL: ${mlmSocial.telegramLink}');
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Fond", context);
                                    }
                                  },
                                  icon: SvgPicture.asset(Assets.svgTelegram,
                                      height: 26, width: 26),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (mlmSocial!.twitterLink != null) {
                                      _launchURL(
                                          mlmSocial.twitterLink.toString());
                                      if (kDebugMode) {
                                        print('URL: ${mlmSocial.twitterLink}');
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Fond", context);
                                    }
                                  },
                                  icon: SvgPicture.asset(Assets.svgTwitter,
                                      height: 26, width: 26),
                                ),
                              ],
                            ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget select_sub_dropdown(List<String> listitem, String hint, String label) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: controller.dropItemError.value
              ? AppColors.redText
              : (controller.selectedItem.value.isNotEmpty
                  ? AppColors.greenBorder
                  : AppColors.containerBorder.withOpacity(0.4)),
        ),
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<String>(
                    value: controller.selectedItem.isNotEmpty
                        ? controller.selectedItem.value
                        : null,
                    hint: controller.selectedItem.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              hint,
                              style: textStyleW500(size.width * 0.04,
                                  AppColors.blackText.withOpacity(0.6)),
                            ),
                          )
                        : null,
                    dropdownColor: AppColors.white,
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    iconSize: 30,
                    isExpanded: true,
                    items: listitem.map((valueItem) {
                      return DropdownMenuItem<String>(
                        value: valueItem,
                        child: Text(
                          valueItem,
                          style: textStyleW500(
                              size.width * 0.04, AppColors.blackText),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedItem.value = value.toString();
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      _selectedCountry.value = country;
    }
  }
}
