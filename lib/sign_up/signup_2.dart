import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/add_comapany_classfied.dart';

import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_plan_list_entity.dart';
import 'package:mlmdiary/sign_up/controller/signup2_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/common_header.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/company_border_textfield.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:path_provider/path_provider.dart';

class AddMoreDetails extends StatefulWidget {
  const AddMoreDetails({
    super.key,
  });

  @override
  State<AddMoreDetails> createState() => _AddMoreDetailsState();
}

class _AddMoreDetailsState extends State<AddMoreDetails> {
  final Signup2Controller controller = Get.put(Signup2Controller());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());

  final ImagePicker _picker = ImagePicker();
  Rx<io.File?> file = Rx<io.File?>(null);
  final TextEditingController _loc = TextEditingController();
  Color _color5 = Colors.black26;
  late double lat = 0.0;
  late double log = 0.0;
  final RxList<String> selectedCompanies = <String>[].obs;

  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";

  @override
  void initState() {
    super.initState();
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
                Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(13.05),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          child: GestureDetector(
                            child: ClipOval(
                              child: file.value != null
                                  ? Image.file(
                                      file.value!,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      Assets.imagesIcon,
                                    ),
                            ),
                            onTap: () {
                              if (file.value == null) {
                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => bottomsheet(context),
                                );
                              }
                            },
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
                Obx(
                  () => CompanyBorderTextfield(
                    height: 65,
                    keyboard: TextInputType.multiline,
                    textInputType: const [],
                    hint: "Company Name",
                    readOnly: controller.companyNameOnly.value,
                    controller: controller.companyName.value,
                    byDefault: !controller.isCompanyNameTyping.value,
                    onChanged: (value) {
                      clasifiedController.fetchCompanyNames(value.toString());
                    },
                    onTap: () async {
                      final result = await Get.to(() => AddCompanyClassified(
                            selectedCompanies: selectedCompanies,
                          ));
                      if (result != null && result is List<String>) {
                        selectedCompanies.clear();
                        selectedCompanies.addAll(result);
                        controller.companyName.value.text =
                            selectedCompanies.join(", ");
                      }
                    },
                  ),
                ),
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
                          showBottomSheetFunc(
                              context, size, controller, controller.planList);
                          controller.planCategoryValidation();
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                  child: TextFormField(
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
                          _color5 = AppColors.greenBorder;
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
                      hintText: "Location/ Address / City *",
                      hintStyle: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'assets/fonst/Metropolis-Black.otf')
                          .copyWith(color: Colors.black45),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: _color5),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: _color5),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: _color5),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          _color5 = AppColors.redText;
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
                          _color5 = AppColors.redText;
                        });
                      } else if (value.isNotEmpty) {
                        setState(() {
                          _color5 = AppColors.greenBorder;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                CustomButton(
                  title: "Submit",
                  btnColor: AppColors.primaryColor,
                  titleColor: AppColors.white,
                  onTap: () {
                    if (file.value == null) {
                      showToasterrorborder("Please Upload Photo", context);
                    } else if (controller.companyName.value.text.isEmpty) {
                      showToasterrorborder(
                          "Please Enter Company Name", context);
                    } else {
                      if (controller.selectedCountPlan > 0) {
                        // Retrieve city information from the location text field
                        if (controller.city.value.text.isEmpty) {
                          showToasterrorborder(
                              "Please select a valid location.", context);
                        } else {
                          controller.saveCompanyDetails(
                            imageFile: file.value,
                          );
                        }
                      } else {
                        showToasterrorborder(
                            "Please select at least one plan.", context);
                      }
                    }
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
    size,
    Signup2Controller controller,
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
              mainAxisSize: MainAxisSize.min,
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
                              controller.togglePlanSelected(index, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        controller.togglePlanSelected(
                                            index, context);
                                      },
                                      child: Image.asset(
                                        controller.isPlanSelectedList[index]
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
                        showToasterrorborder(
                            "Please select at least one field.", context);
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

  Future<void> takephoto(ImageSource imageSource) async {
    final pickedfile =
        await _picker.pickImage(source: imageSource, imageQuality: 100);
    if (pickedfile != null && pickedfile.path.isNotEmpty) {
      io.File imageFile = io.File(pickedfile.path);
      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInKB = fileSizeInBytes / 1024;

      if (kDebugMode) {
        print('Original image size: $fileSizeInKB KB');
      }

      if (fileSizeInKB > 5000) {
        Fluttertoast.showToast(msg: 'Please Select an image below 5 MB');
        return;
      }

      if (fileSizeInKB < 200) {
        Fluttertoast.showToast(msg: 'Please Select an image above 200 KB');
        return;
      }

      io.File? processedFile = imageFile;

      processedFile = await _cropImage(imageFile);
      if (processedFile == null) {
        Fluttertoast.showToast(msg: 'Image cropping failed');
        return;
      }

      double processedFileSizeInKB = processedFile.lengthSync() / 1024;

      if (processedFileSizeInKB > 250) {
        processedFile = await _compressImage(processedFile);
        if (processedFile == null) {
          Fluttertoast.showToast(msg: 'Image compression failed');
          return;
        }
      }

      double finalFileSizeInKB = processedFile.lengthSync() / 1024;
      if (kDebugMode) {
        print('Final image size: $finalFileSizeInKB KB');
      }

      file.value = processedFile;

      Get.back();
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

    if (croppedFile != null) {
      return io.File(croppedFile.path);
    } else {
      return null;
    }
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

      if (fileSizeInKB < 200) {
        quality += 5;
      } else {
        quality -= 5;
      }

      if (quality <= 0 || quality > 100) {
        break;
      }
    }

    return compressedFile;
  }
}
