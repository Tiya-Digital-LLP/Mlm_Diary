import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/contactus/controller/contactus_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final ContactusController controller = Get.put(ContactusController());
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
                select_sub_dropdown(controller.listitem2, 'Select Subject'),
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
                    onChanged: (value) {},
                    height: 70,
                  ),
                ),
                10.sbh,
                Obx(
                  () => BorderTextField(
                    keyboard: TextInputType.emailAddress,
                    textInputType: const [],
                    hint: "Email Address*",
                    controller: controller.email.value,
                    byDefault: !controller.isEmailTyping.value,
                    onChanged: (value) {},
                    height: 70,
                  ),
                ),
                10.sbh,
                Row(
                  children: [
                    GestureDetector(
                      onTap: _onPressedShowBottomSheet,
                      child: SizedBox(
                        width: 120,
                        height: 68,
                        child: BorderContainer(
                          height: 60,
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
                          height: 70,
                          hint: " Mobile Number",
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
                    keyboard: TextInputType.name,
                    textInputType: const [],
                    hint: "Company",
                    controller: controller.company.value,
                    byDefault: !controller.isCompanyTyping.value,
                    onChanged: (value) {},
                    height: 70,
                  ),
                ),
                10.sbh,
                Obx(
                  () => BorderTextField(
                    keyboard: TextInputType.name,
                    textInputType: const [],
                    hint: "Message*",
                    controller: controller.message.value,
                    byDefault: !controller.isMessageTyping.value,
                    onChanged: (value) {},
                    height: 100,
                  ),
                ),
                20.sbh,
                NormalButton(
                  onPressed: () async {
                    await controller.contactus(context);
                    // ignore: use_build_context_synchronously
                    showToastverifedborder('inquiry save', context);
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
                              '+91 8866409966',
                              style: textStyleW700(
                                  size.width * 0.060, AppColors.blackText),
                            ),
                            80.sbw,
                            Expanded(
                              child: SvgPicture.asset(
                                Assets.svgMobileIconContactUs,
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
                Container(
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
                              iconSize: 25,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                Assets.svgLogosWhatsappIcon,
                                height: 25,
                                width: 25,
                              ),
                            ),
                            IconButton(
                              iconSize: 25,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: SvgPicture.asset(Assets.svgLogosFacebook,
                                  height: 25, width: 25),
                            ),
                            IconButton(
                              iconSize: 25,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: SvgPicture.asset(Assets.svgInstagram,
                                  height: 25, width: 25),
                            ),
                            IconButton(
                              iconSize: 25,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                  Assets.svgLogosLinkedinIcon,
                                  height: 25,
                                  width: 25),
                            ),
                            IconButton(
                              iconSize: 25,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: SvgPicture.asset(Assets.svgYoutube,
                                  height: 25, width: 25),
                            ),
                            IconButton(
                              iconSize: 25,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: SvgPicture.asset(Assets.svgTelegram,
                                  height: 25, width: 25),
                            ),
                            IconButton(
                              iconSize: 25,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: SvgPicture.asset(Assets.svgTwitter,
                                  height: 25, width: 25),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget select_sub_dropdown(List listitem, String hint) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: AppColors.containerBorder.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.white,
      ),
      child: Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              value: controller.selectedItem.isNotEmpty
                  ? controller.selectedItem.value
                  : null,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  hint,
                  style: textStyleW500(
                      size.width * 0.04, AppColors.blackText.withOpacity(0.6)),
                ),
              ),
              dropdownColor: AppColors.white,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.arrow_drop_down),
              ),
              iconSize: 30,
              isExpanded: true,
              items: listitem.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(
                    valueItem,
                    style:
                        textStyleW500(size.width * 0.030, AppColors.blackText),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedItem.value = value.toString();
              },
              underline: const SizedBox.shrink(),
            ),
          )),
    );
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
