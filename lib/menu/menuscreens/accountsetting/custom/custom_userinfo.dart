import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/custom/add_comapany_classfied.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_plan_list_entity.dart';
import 'package:mlmdiary/generated/get_user_type_entity.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/controller/account_setting_controller.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/controller/manage_classified_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/company_border_textfield.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/discription_text_field.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/normal_button.dart';
import 'package:path_provider/path_provider.dart';

class CustomUserinfo extends StatefulWidget {
  const CustomUserinfo({
    super.key,
    required String tabContent,
  });

  @override
  State<CustomUserinfo> createState() => _CustomUserinfoState();
}

class _CustomUserinfoState extends State<CustomUserinfo> {
  late final String tabContent;
  final AccountSeetingController controller =
      Get.put(AccountSeetingController());
  final TextEditingController _loc = TextEditingController();
  final ManageClasifiedController manageClasifiedController =
      Get.put(ManageClasifiedController());
  final RxList<String> selectedCompanies = <String>[].obs;

  final ImagePicker _picker = ImagePicker();
  Rx<io.File?> file = Rx<io.File?>(null);
  late double lat = 0.0;
  late double log = 0.0;
  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
            child: CustomLottieAnimation(
          child: Lottie.asset(
            Assets.lottieLottie,
          ),
        ));
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (file.value == null) {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => bottomsheet(context),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: <Widget>[
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(13.05),
                        child: CircleAvatar(
                          radius: 60.0,
                          child: file.value != null
                              ? ClipOval(
                                  child: Image.file(
                                    file.value!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : controller.userImage.value.isNotEmpty
                                  ? ClipOval(
                                      child: Image.network(
                                        controller.userImage.value,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.asset(
                                        Assets.imagesIcon,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 3.0,
                      right: 5.0,
                      child: SizedBox(
                        width: 40,
                        height: 33,
                        child: Image.asset(Assets.imagesCamera),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.sbh,
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BorderContainer(
                  isError: controller.mlmTypeError.value,
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: controller.getSelectedOptionsTextController(),
                      readOnly: true,
                      onTap: () {
                        showBottomSheetFunc(
                            context, size, controller, controller.userTypes);
                        controller.mlmCategoryValidation();
                      },
                      style:
                          textStyleW500(size.width * 0.04, AppColors.blackText),
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
            ),
            10.sbh,
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BorderTextField(
                  keyboard: TextInputType.name,
                  textInputType: const [],
                  hint: "Your Name",
                  controller: controller.name.value,
                  height: 65,
                  byDefault: !controller.isNameTyping.value,
                ),
              ),
            ),
            10.sbh,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Row(
                  children: [
                    Text(
                      "Gender",
                      style: textStyleW400(size.width * 0.045,
                          AppColors.blackText.withOpacity(0.5)),
                    ),
                    20.sbw,
                    InkWell(
                      onTap: () {
                        controller.isGenderToggle.value = true;
                      },
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                Assets.imagesCircle,
                                color: (controller.isGenderToggle.value == true)
                                    ? AppColors.primaryColor
                                    : AppColors.blackText.withOpacity(0.5),
                              ),
                              if (controller.isGenderToggle.value == true)
                                Positioned(
                                  top: 3,
                                  left: 3,
                                  child:
                                      Image.asset(Assets.imagesSelectedCircle),
                                ),
                            ],
                          ),
                          10.sbw,
                          Text(
                            "Male",
                            style: (controller.isGenderToggle.value == true)
                                ? textStyleW500(
                                    size.width * 0.045, AppColors.primaryColor)
                                : textStyleW400(size.width * 0.045,
                                    AppColors.blackText.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    20.sbw,
                    InkWell(
                      onTap: () {
                        controller.isGenderToggle.value = false;
                      },
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                Assets.imagesCircle,
                                color:
                                    (controller.isGenderToggle.value == false)
                                        ? AppColors.primaryColor
                                        : AppColors.blackText.withOpacity(0.5),
                              ),
                              if (controller.isGenderToggle.value == false)
                                Positioned(
                                  top: 3,
                                  left: 3,
                                  child:
                                      Image.asset(Assets.imagesSelectedCircle),
                                ),
                            ],
                          ),
                          10.sbw,
                          Text(
                            "Female",
                            style: (controller.isGenderToggle.value == false)
                                ? textStyleW500(
                                    size.width * 0.045, AppColors.primaryColor)
                                : textStyleW400(size.width * 0.045,
                                    AppColors.blackText.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.sbh,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => CompanyBorderTextfield(
                  height: 65,
                  keyboard: TextInputType.multiline,
                  textInputType: const [],
                  hint: "Company Name",
                  controller: controller.companyname.value,
                  byDefault: !controller.isCompanyNameTyping.value,
                  onChanged: (value) {
                    manageClasifiedController
                        .fetchCompanyNames(value.toString());
                  },
                  onTap: () async {
                    final result = await Get.to(() => AddCompanyClassified(
                          selectedCompanies: selectedCompanies,
                        ));
                    if (result != null && result is List<String>) {
                      selectedCompanies.clear();
                      selectedCompanies.addAll(result);
                      controller.companyname.value.text =
                          selectedCompanies.join(", ");
                    }
                  },
                ),
              ),
            ),
            10.sbh,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => BorderContainer(
                  isError: controller.planTypeError.value,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller:
                          controller.getSelectedPlanOptionsTextController(),
                      readOnly: true,
                      onTap: () {
                        showBottomSheetFuncPlan(
                            context, size, controller, controller.planList);
                        controller.planCategoryValidation();
                      },
                      style:
                          textStyleW500(size.width * 0.04, AppColors.blackText),
                      cursorColor: AppColors.blackText,
                      decoration: InputDecoration(
                          hintText: "Select Plan",
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.blackText,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            10.sbh,
            Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                child: Obx(
                  () => TextFormField(
                    controller: controller.location.value,
                    readOnly: true,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'assets/fonst/Metropolis-Black.otf'),
                    onTap: () async {
                      var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.fullscreen,
                        types: ['geocode', 'establishment'],
                        strictbounds: false,
                        onError: (err) {},
                      );

                      if (place != null) {
                        setState(() {
                          controller.location.value.text =
                              place.description.toString();
                          _loc.text = controller.location.value.text;
                          controller.validateAddress();
                        });
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        for (var component in detail.result.addressComponents) {
                          for (var type in component.types) {
                            if (type == "administrative_area_level_1") {
                              controller.state.value.text = component.longName;
                            } else if (type == "locality") {
                              controller.city.value.text = component.longName;
                            } else if (type == "country") {
                              controller.country.value.text =
                                  component.longName;
                            }
                          }
                        }

                        final geometry = detail.result.geometry!;
                        setState(() {
                          lat = geometry.location.lat;
                          log = geometry.location.lng;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: "Location/ Address / City *",
                      hintStyle: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'assets/fonst/Metropolis-Black.otf')
                          .copyWith(color: Colors.black45),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: controller.addressValidationColor.value),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: controller.addressValidationColor.value),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: controller.addressValidationColor.value),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          controller.validateAddress();
                        });
                      } else {}
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (value.isEmpty) {
                        Fluttertoast.showToast(
                            timeInSecForIosWeb: 2,
                            msg:
                                'Please Search and Save your Business Location');
                        setState(() {
                          controller.validateAddress();
                        });
                      } else if (value.isNotEmpty) {
                        setState(() {
                          controller.validateAddress();
                        });
                      }
                    },
                  ),
                )),
            10.sbh,
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DiscriptionTextField(
                  keyboard: TextInputType.name,
                  textInputType: const [],
                  hint: "About you",
                  controller: controller.aboutyou.value,
                  byDefault: !controller.isAboutTyping.value,
                  height: 95,
                ),
              ),
            ),
            10.sbh,
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: DiscriptionTextField(
                  keyboard: TextInputType.name,
                  textInputType: const [],
                  hint: "About company",
                  controller: controller.aboutcompany.value,
                  byDefault: !controller.isAboutCompany.value,
                  height: 95,
                ),
              ),
            ),
            20.sbh,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NormalButton(
                onPressed: handleSaveButtonPressed,
                text: 'Save',
                isLoading: controller.isLoading,
              ),
            ),
          ],
        );
      }
    });
  }

  // Method to handle save button pressed
  Future<void> handleSaveButtonPressed() async {
    if (file.value == null && controller.userImage.value.isEmpty) {
      showToasterrorborder("Please Upload Photo", context);
    } else if (controller
        .getSelectedOptionsTextController()
        .value
        .text
        .isEmpty) {
      showToasterrorborder("Please Enter UserTypes", context);
    } else if (controller.name.value.text.isEmpty) {
      showToasterrorborder("Please Enter Your Name", context);
    } else if (controller.companyname.value.text.isEmpty) {
      showToasterrorborder("Please Enter Company Name", context);
    } else if (controller
        .getSelectedPlanOptionsTextController()
        .value
        .text
        .isEmpty) {
      showToasterrorborder("Please Select Plam", context);
    } else if (controller.location.value.text.isEmpty) {
      showToasterrorborder("The address field is required.", context);
    } else if (controller.isTypeSelectedList.contains(true)) {
      if (controller.city.value.text.isEmpty) {
        showToasterrorborder("Please select a valid location.", context);
      } else {
        // Perform address validation
        if (controller.addressValidationColor.value != AppColors.redText) {
          await controller.updateUserProfile(imageFile: file.value);
          Get.back();
        } else {
          showToasterrorborder("Please enter a valid address.", context);
        }
      }
    } else {
      showToasterrorborder("Please select at least one plan.", context);
    }
  }

  Widget bottomsheet(BuildContext context) {
    return Container(
      height: 100.0,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera, color: AppColors.primaryColor),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
              TextButton.icon(
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image, color: AppColors.primaryColor),
                  label: Text(
                    'Gallery',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void showBottomSheetFunc(
    BuildContext context,
    Size size,
    AccountSeetingController controller,
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
                                15.sbw,
                                Text(
                                  userTypes[index].name ?? '',
                                  style: textStyleW500(
                                    size.width * 0.041,
                                    controller.isTypeSelectedList[
                                            index] // Highlight selected MLM type
                                        ? AppColors
                                            .primaryColor // Apply highlight color
                                        : AppColors
                                            .blackText, // Apply default color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        20.sbh,
                      ],
                    );
                  },
                ),
                Center(
                  child: CustomButton(
                    title: "Continue",
                    btnColor: AppColors.primaryColor,
                    titleColor: AppColors.white,
                    onTap: () {
                      if (controller.isTypeSelectedList.contains(true)) {
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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 100);
    if (pickedFile != null) {
      io.File imageFile = io.File(pickedFile.path);
      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInKB = fileSizeInBytes / 1024;

      if (fileSizeInKB > 5000) {
        Fluttertoast.showToast(msg: 'Please select an image below 5 MB');
        return;
      }

      io.File? croppedFile = await _cropImage(imageFile);
      if (croppedFile != null) {
        double croppedFileSizeInKB = croppedFile.lengthSync() / 1024;

        if (croppedFileSizeInKB > 250) {
          croppedFile = await _compressImage(croppedFile);
          if (croppedFile == null) {
            Fluttertoast.showToast(msg: 'Image compression failed');
            return;
          }
        }

        file.value = croppedFile;
        Get.back();
      } else {
        Fluttertoast.showToast(msg: 'Image cropping failed');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please select an image');
    }
  }

  Future<io.File?> _cropImage(io.File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile != null ? io.File(croppedFile.path) : null;
  }

  Future<io.File?> _compressImage(io.File imageFile) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.path}/temp.jpg';
    int quality = 90;
    io.File? compressedFile;
    while (true) {
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: quality,
      );

      if (result == null) {
        return null;
      }

      compressedFile = io.File(result.path);
      double fileSizeInKB = compressedFile.lengthSync() / 1024;

      if (fileSizeInKB <= 250 && fileSizeInKB >= 200) {
        break;
      }

      quality = fileSizeInKB < 200 ? quality + 5 : quality - 5;
      if (quality <= 0 || quality > 100) {
        break;
      }
    }
    return compressedFile;
  }

  void showBottomSheetFuncPlan(
    BuildContext context,
    Size size,
    AccountSeetingController controller,
    List<GetPlanListPlan> planList,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
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
                    'Select Plan',
                    style:
                        textStyleW600(size.width * 0.045, AppColors.blackText),
                  ),
                ),
                20.sbh,
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: planList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.togglePlanSelected(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        controller.togglePlanSelected(index);
                                      },
                                      child: Image.asset(
                                        (controller.isPlanSelectedList[index])
                                            ? Assets.imagesTrueCircle
                                            : Assets.imagesCircle,
                                      ),
                                    ),
                                  ),
                                  15.sbw,
                                  Text(
                                    planList[index].name ?? '',
                                    style: textStyleW500(size.width * 0.041,
                                        AppColors.blackText),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          20.sbh,
                        ],
                      );
                    },
                  ),
                ),
                Center(
                  child: CustomButton(
                    title: "Continue",
                    btnColor: AppColors.primaryColor,
                    titleColor: AppColors.white,
                    onTap: () {
                      if (controller.selectedCountPlan > 0) {
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
}
