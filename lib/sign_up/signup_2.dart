import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/sign_up/signup_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/common_header.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';

class AddMoreDetails extends StatefulWidget {
  const AddMoreDetails({super.key});

  @override
  State<AddMoreDetails> createState() => _AddMoreDetailsState();
}

class _AddMoreDetailsState extends State<AddMoreDetails> {
  final SignupController controller = Get.put(SignupController());
  PickedFile? _imagefiles;
  io.File? file, file1, file2;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placeMarks.isNotEmpty) {
        final Placemark placeMark = placeMarks.first;

        if (placeMark.locality != null) {
          setState(() {
            controller.location.value.text = placeMark.locality!;
          });
        }
      }
    } catch (e) {
      log('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
                Stack(
                  children: [
                    Column(
                      children: [
                        imageprofile(context),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: textStyleW400(size.width * 0.045,
                          AppColors.blackText.withOpacity(0.5)),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Obx(
                  () => Row(
                    children: [
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
                                  color: (controller.isGenderToggle.value ==
                                          true)
                                      ? AppColors.primaryColor
                                      : AppColors.blackText.withOpacity(0.5),
                                ),
                                (controller.isGenderToggle.value == true)
                                    ? Positioned(
                                        top: 3,
                                        left: 3,
                                        child: Image.asset(
                                            Assets.imagesSelectedCircle))
                                    : Container()
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Male",
                              style: (controller.isGenderToggle.value == true)
                                  ? textStyleW500(size.width * 0.045,
                                      AppColors.primaryColor)
                                  : textStyleW400(
                                      size.width * 0.045,
                                      AppColors.blackText.withOpacity(0.5),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
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
                                  color: (controller.isGenderToggle.value ==
                                          false)
                                      ? AppColors.primaryColor
                                      : AppColors.blackText.withOpacity(0.5),
                                ),
                                (controller.isGenderToggle.value == false)
                                    ? Positioned(
                                        top: 3,
                                        left: 3,
                                        child: Image.asset(
                                            Assets.imagesSelectedCircle))
                                    : Container()
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Female",
                              style: (controller.isGenderToggle.value == false)
                                  ? textStyleW500(size.width * 0.045,
                                      AppColors.primaryColor)
                                  : textStyleW400(
                                      size.width * 0.045,
                                      AppColors.blackText.withOpacity(0.5),
                                    ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Obx(() => BorderTextField(
                      maxLength: 25,
                      keyboard: TextInputType.name,
                      textInputType: const [],
                      hint: "Company Name",
                      readOnly: controller.companyNameOnly.value,
                      controller: controller.companyName.value,
                      isError: controller.comapnyNameError.value,
                      byDefault: !controller.isCompanyNameTyping.value,
                      onChanged: (value) {
                        controller.companyNameValidation();
                        controller.isCompanyNameTyping.value = true;
                      },
                    )),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Obx(
                  () => BorderContainer(
                    isError: controller.planTypeError.value,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller:
                            controller.getSelectedPlanOptionsTextController(),
                        readOnly: true,
                        onTap: () {
                          log("BEFORE ==  ${controller.planTypeError.value}");

                          showBottomSheetFunc(
                              context, size, controller, planList);
                          controller.planCategoryValidation();

                          log("AFTER == ${controller.planTypeError.value}");
                        },
                        style: textStyleW500(
                            size.width * 0.04, AppColors.blackText),
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
                SizedBox(
                  height: size.height * 0.015,
                ),
                Obx(() => BorderTextField(
                      maxLength: 25,
                      keyboard: TextInputType.name,
                      textInputType: const [],
                      hint: "Loaction",
                      controller: controller.location.value,
                      isError: controller.locationError.value,
                      byDefault: !controller.isLocationTyping.value,
                      onChanged: (value) {
                        controller.locationValidation();
                        controller.isLocationTyping.value = true;
                      },
                    )),
                Expanded(
                  child: Container(),
                ),
                CustomButton(
                  title: "Submit",
                  btnColor: AppColors.primaryColor,
                  titleColor: AppColors.white,
                  onTap: () {
                    if (controller.imageFile == null) {
                      ToastUtils.showToast("Please Add Your Profile Picture");
                    } else {}
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom +
                      size.height * 0.015,
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
    Size size,
    SignupController controller,
    List<String> planList,
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
                    'Select Plan',
                    style:
                        textStyleW600(size.width * 0.045, AppColors.blackText),
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
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
                                const SizedBox(width: 15),
                                Text(
                                  planList[index],
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
                      if (controller.selectedCountPlan > 0) {
                        Navigator.pop(context);
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

  Widget imageprofile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => bottomsheet(),
        );
      },
      child: Center(
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 60.0,
              backgroundImage: _imagefiles == null
                  ? const AssetImage(Assets.imagesIcon) as ImageProvider
                  : FileImage(file!),
              backgroundColor: const Color.fromARGB(255, 240, 238, 238),
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
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
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
                    takephoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera, color: AppColors.primaryColor),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
              TextButton.icon(
                  onPressed: () {
                    takephoto(ImageSource.gallery);
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

  void takephoto(ImageSource imageSource) async {
    final pickedfile = await _picker.pickImage(source: imageSource);

    _imagefiles = pickedfile as PickedFile?;
    file = await _cropImage(imagefile: io.File(_imagefiles!.path));

    Get.back();
  }

  Future<io.File?> _cropImage({required io.File imagefile}) async {
    if (_imagefiles != null) {
      final croppedFile = await ImageCropper().cropImage(
          sourcePath: _imagefiles!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: AppColors.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ]);
      if (croppedFile != null) {
        setState(() {});
        return io.File(croppedFile.path);
      } else {
        return io.File(_imagefiles!.path);
      }
    } else {
      return null;
    }
  }
}
