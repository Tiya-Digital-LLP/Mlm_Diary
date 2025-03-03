import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
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
import 'package:mlmdiary/widgets/normal_button.dart';
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
  late double lat = 0.0;
  late double log = 0.0;
  static List<io.File> imagesList = <io.File>[];

  final RxList<String> selectedCompanies = <String>[].obs;

  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";

  @override
  void initState() {
    super.initState();
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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              decoration: BoxDecoration(color: AppColors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomBackButton(),
                      ],
                    ),
                    CommonHeader(
                      onBackTap: () {},
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(13.05),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundColor: AppColors.background,
                              child: GestureDetector(
                                child: ClipOval(
                                  child: file.value != null
                                      ? Image.file(
                                          file.value!,
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.supervised_user_circle_outlined,
                                          color: AppColors.primaryColor,
                                          size: 80,
                                        ),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    context: context,
                                    builder: (context) => bottomsheet(),
                                  );
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
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Gender",
                        style: textStyleW400(
                            size.width * 0.045,
                            // ignore: deprecated_member_use
                            AppColors.blackText.withOpacity(0.5)),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                                          : AppColors.blackText
                                              // ignore: deprecated_member_use
                                              .withOpacity(0.5),
                                    ),
                                    if (controller.isGenderToggle.value == true)
                                      Positioned(
                                        top: 3,
                                        left: 3,
                                        child: Image.asset(
                                          Assets.imagesSelectedCircle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Male",
                                  style:
                                      (controller.isGenderToggle.value == true)
                                          ? textStyleW600(size.width * 0.040,
                                              AppColors.primaryColor)
                                          : textStyleW400(size.width * 0.038,
                                              AppColors.blackText),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
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
                                          : AppColors.blackText
                                              // ignore: deprecated_member_use
                                              .withOpacity(0.5),
                                    ),
                                    if (controller.isGenderToggle.value ==
                                        false)
                                      Positioned(
                                        top: 3,
                                        left: 3,
                                        child: Image.asset(
                                          Assets.imagesSelectedCircle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Female",
                                  style:
                                      (controller.isGenderToggle.value == false)
                                          ? textStyleW600(size.width * 0.040,
                                              AppColors.primaryColor)
                                          : textStyleW400(size.width * 0.038,
                                              AppColors.blackText),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => CompanyBorderTextfield(
                        height: 58,
                        keyboard: TextInputType.name,
                        textInputType: const [],
                        hint: "Company Name *",
                        readOnly: !controller.companyNameOnly.value,
                        controller: controller.companyName.value,
                        isError: controller.comapnyNameError.value,
                        byDefault: !controller.isCompanyNameTyping.value,
                        onChanged: (value) {
                          clasifiedController
                              .fetchCompanyNames(value.toString());
                        },
                        onTap: () async {
                          final result =
                              await Get.to(() => AddCompanyClassified(
                                    selectedCompanies: selectedCompanies,
                                  ));
                          if (result != null && result is List<String>) {
                            selectedCompanies.clear();
                            selectedCompanies.addAll(result);
                            controller.companyName.value.text =
                                selectedCompanies.join(", ");
                          }
                          controller.companyNameOnly.value = false;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => BorderContainer(
                        isError: controller.planTypeError.value,
                        byDefault: !controller.isPlanTyping.value,
                        height: 58,
                        child: TextField(
                          controller:
                              controller.getSelectedPlanOptionsTextController(),
                          readOnly: true,
                          onTap: () {
                            showBottomSheetFunc(
                                context, size, controller, controller.planList);
                            controller.planCategoryValidation();
                          },
                          style: textStyleW700(
                              size.width * 0.038, AppColors.blackText),
                          cursorColor: AppColors.blackText,
                          decoration: InputDecoration(
                            labelText: "Select Plan *",
                            labelStyle: textStyleW400(
                                size.width * 0.038, AppColors.blackText),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.5,
                              horizontal: 2,
                            ),
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.blackText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: AppColors.white,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                          controller: controller.location.value,
                          readOnly: true,
                          style: textStyleW700(
                              size.width * 0.038, AppColors.blackText),
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: googleApikey,
                              mode: Mode.fullscreen,
                              hint: 'Search and Save Location.',
                              cursorColor: AppColors.primaryColor,
                              types: ['geocode', 'establishment'],
                              strictbounds: false,
                              onError: (err) {},
                            );

                            if (place != null) {
                              setState(() {
                                controller.location.value.text =
                                    place.description.toString();
                                _loc.text = controller.location.value.text;
                                controller.isLocationTyping.value = true;
                                controller.locationValidation();
                              });
                              final plist = GoogleMapsPlaces(
                                apiKey: googleApikey,
                                apiHeaders:
                                    await const GoogleApiHeaders().getHeaders(),
                              );
                              String placeid = place.placeId ?? "0";
                              final detail =
                                  await plist.getDetailsByPlaceId(placeid);
                              for (var component
                                  in detail.result.addressComponents) {
                                for (var type in component.types) {
                                  if (type == "administrative_area_level_1") {
                                    controller.state.value.text =
                                        component.longName;
                                  } else if (type == "locality") {
                                    controller.city.value.text =
                                        component.longName;
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
                            labelText: "Location / Address / City *",
                            labelStyle: textStyleW400(
                                size.width * 0.038, AppColors.blackText),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 2,
                            ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                controller.locationValidation();
                              });
                            } else {}
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) {
                              showToasterrorborder(
                                  'Please Search and Save your Business Location',
                                  context);
                              setState(() {
                                controller.locationValidation();
                              });
                            } else if (value.isNotEmpty) {
                              setState(() {
                                controller.locationValidation();
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    100.sbh,
                    Align(
                      alignment: Alignment.center,
                      child: NormalButton(
                        text: "Submit",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.isPlanTyping.value = true;
                          controller.isLocationTyping.value = true;

                          controller.planCategoryValidation();
                          controller.locationValidation();

                          if (file.value == null) {
                            showToasterrorborder(
                                "Please Upload Photo", context);
                          } else if (controller
                              .companyName.value.text.isEmpty) {
                            showToasterrorborder(
                                "Please Enter Company Name", context);
                          } else {
                            if (controller.selectedCountPlan > 0) {
                              if (controller.city.value.text.isEmpty) {
                                showToasterrorborder(
                                    "Please select a valid location.", context);
                              } else {
                                controller.saveCompanyDetails(
                                  imageFile: file.value,
                                  context: context,
                                );
                              }
                            } else {
                              showToasterrorborder(
                                  "Please select at least one plan.", context);
                            }
                          }
                        },
                        isLoading: controller.isLoading,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
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
                                    style: textStyleW600(size.width * 0.038,
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
                  child: NormalButton(
                    text: "Continue",
                    onPressed: () {
                      if (controller.selectedCountPlan > 0) {
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

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 18.0, color: AppColors.blackText),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takephoto(
                      ImageSource.camera,
                    );
                  },
                  icon: Icon(Icons.camera, color: AppColors.primaryColor),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
              TextButton.icon(
                  onPressed: () {
                    takephoto(
                      ImageSource.gallery,
                    );
                  },
                  icon: Icon(Icons.image, color: AppColors.primaryColor),
                  label: Text(
                    'Gallary',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void takephoto(ImageSource imageSource) async {
    final pickedfile =
        await _picker.pickImage(source: imageSource, imageQuality: 100);
    if (pickedfile != null) {
      io.File imageFile = io.File(pickedfile.path);
      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInKB = fileSizeInBytes / 1024;

      if (kDebugMode) {
        print('Original image size: $fileSizeInKB KB');
      }

      if (fileSizeInKB > 5000) {
        // ignore: use_build_context_synchronously
        showToasterrorborder('Please Select an image below 5 MB', context);
        return;
      }

      // Crop the image
      io.File? croppedFile = await _cropImage(imageFile);

      if (croppedFile == null) {
        // ignore: use_build_context_synchronously
        showToasterrorborder('Failed to crop image', context);
        return;
      }

      // Check size after cropping
      double croppedFileSizeInKB = croppedFile.lengthSync() / 1024;
      if (kDebugMode) {
        print('Cropped image size: $croppedFileSizeInKB KB');
      }

      io.File? processedFile;

      // Only compress if the file size is greater than 250 KB
      if (croppedFileSizeInKB > 250) {
        processedFile = await _compressImage(croppedFile);

        if (processedFile == null) {
          // ignore: use_build_context_synchronously
          showToasterrorborder('Failed to compress image', context);
          if (kDebugMode) {
            print('Failed to compress image');
          }
          return;
        }
      } else {
        // No compression needed, use the cropped file
        processedFile = croppedFile;
      }

      double processedFileSizeInKB = processedFile.lengthSync() / 1024;
      if (kDebugMode) {
        print('Processed image size: $processedFileSizeInKB KB');
      }

      // Debugging statement to ensure new file is being set
      if (kDebugMode) {
        print('Setting new image with path: ${processedFile.path}');
      }

      // Update observable
      file.value = processedFile;

      // Add to imagesList
      if (file.value != null) {
        imagesList.add(file.value!);
      }

      // Close the bottom sheet
      Get.back();
    } else {
      // ignore: use_build_context_synchronously
      showToasterrorborder('Please select an image', context);
      return; // Exit function if no image is selected
    }
  }

  Future<io.File?> _cropImage(io.File imageFile) async {
    try {
      final cropper = ImageCropper();

      // Crop the image
      final CroppedFile? croppedFile = await cropper.cropImage(
        sourcePath: imageFile.path,
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
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        return io.File(croppedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during image cropping: $e');
      }
      return null;
    }
  }

  Future<io.File?> _compressImage(io.File imageFile) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg'; // Unique temp file

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
