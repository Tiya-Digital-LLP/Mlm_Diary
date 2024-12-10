import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// ignore: depend_on_referenced_packages
import 'package:google_api_headers/google_api_headers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/custom/add_comapany_classfied.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/controller/manage_classified_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/company_border_textfield.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/discription_text_field.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/normal_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';

class ManageClassifiedPlusIcon extends StatefulWidget {
  final int classfiedId;
  const ManageClassifiedPlusIcon({super.key, required this.classfiedId});

  @override
  State<ManageClassifiedPlusIcon> createState() =>
      _ManageClassifiedPlusIconState();
}

class _ManageClassifiedPlusIconState extends State<ManageClassifiedPlusIcon> {
  final ImagePicker _picker = ImagePicker();
  Rx<io.File?> file = Rx<io.File?>(null);
  static List<io.File> imagesList = <io.File>[];
  final TextEditingController _loc = TextEditingController();
  final RxList<String> selectedCompanies = <String>[].obs;

  late double lat = 0.0;
  late double log = 0.0;
  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";

  final ManageClasifiedController controller =
      Get.put(ManageClasifiedController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage Classified',
        onTap: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => BorderTextField(
                      keyboard: TextInputType.name,
                      textInputType: const [],
                      hint: "Enter Title",
                      readOnly: controller.titleReadOnly.value,
                      controller: controller.title.value,
                      isError: controller.titleError.value,
                      byDefault: !controller.isTitleTyping.value,
                      onChanged: (value) {
                        controller.titleValidation(context);
                        controller.isTitleTyping.value = true;
                      },
                      height: 58,
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderContainer(
                      isError: controller.categoryError.value,
                      height: 58,
                      child: TextField(
                        controller:
                            controller.getSelectedCategoryTextController(),
                        readOnly: true,
                        onTap: () {
                          showSelectCategory(
                            context,
                            size,
                            controller,
                            controller.categorylist,
                          );
                          controller.mlmCategoryValidation();
                        },
                        style: textStyleW500(
                            size.width * 0.04, AppColors.blackText),
                        cursorColor: AppColors.blackText,
                        decoration: InputDecoration(
                            labelText: "Select Category",
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.5,
                              horizontal: 2,
                            ),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.blackText,
                            )),
                      ),
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderContainer(
                      isError: controller.subCategoryError.value,
                      height: 58,
                      child: TextField(
                        controller:
                            controller.getSelectedSubCategoryTextController(),
                        readOnly: true,
                        onTap: () {
                          showSelectSubCategory(
                            context,
                            size,
                            controller,
                            controller.subcategoryList,
                          );
                          controller.mlmsubCategoryValidation();
                        },
                        style: textStyleW500(
                            size.width * 0.04, AppColors.blackText),
                        cursorColor: AppColors.blackText,
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            labelText: "Select Sub Category",
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.5,
                              horizontal: 2,
                            ),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.blackText,
                            )),
                      ),
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => CompanyBorderTextfield(
                      height: 58,
                      keyboard: TextInputType.multiline,
                      textInputType: const [],
                      hint: "Company Name",
                      readOnly: !controller.companyNameOnly.value,
                      controller: controller.companyName.value,
                      isError: controller.companyError.value,
                      byDefault: !controller.isCompanyNameTyping.value,
                      onChanged: (value) {
                        controller.fetchCompanyNames(value.toString());
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
                        controller.companyNameOnly.value = false;
                      },
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => DiscriptionTextField(
                      keyboard: TextInputType.multiline,
                      textInputType: const [],
                      hint: "Description",
                      controller: controller.discription.value,
                      isError: controller.discriptionError.value,
                      byDefault: !controller.isDiscriptionTyping.value,
                      onChanged: (value) {
                        controller.discriptionValidation(context);
                        controller.isDiscriptionTyping.value = true;
                      },
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderTextField(
                      keyboard: TextInputType.url,
                      textInputType: const [],
                      hint: "Website Url (Optional)",
                      controller: controller.url.value,
                      isError: controller.urlError.value,
                      byDefault: !controller.isUrlTyping.value,
                      onChanged: (value) {
                        controller.isUrlTyping.value = true;
                      },
                      height: 58,
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => TextFormField(
                      controller: controller.location.value,
                      readOnly: true,
                      style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'assets/fonts/Metropolis-Black.otf'),
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
                            controller.validateAddress();
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
                                controller.city.value.text = component.longName;
                              } else if (type == "country") {
                                controller.country.value.text =
                                    component.longName;
                              }
                            }
                          }

                          final geometry = detail.result.geometry!;
                          setState(() {
                            controller.lat.value.text =
                                geometry.location.lat.toString();
                            controller.lng.value.text =
                                geometry.location.lng.toString();
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Location/ Address / City *",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: AppColors.white,
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
                  ),
                  20.sbh,
                  Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(13.05),
                      child: Stack(
                        children: [
                          GestureDetector(
                            child: file.value != null
                                ? Image.file(
                                    file.value!,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : controller.userImage.value.isNotEmpty
                                    ? Image.network(
                                        '${controller.userImage.value}?t=${DateTime.now().millisecondsSinceEpoch}',
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        Assets.imagesLogo,
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => bottomsheet(context));
                            },
                          ),
                          Visibility(
                            visible: file.value != null,
                            child: Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: const EdgeInsets.all(2.0),
                                  child: Card(
                                      shape: const CircleBorder(),
                                      child: GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.redText,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            imagesList.remove(file.value);
                                            file.value = null;
                                          });
                                        },
                                      )),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  10.sbh,
                  NormalButton(
                    onPressed: () {
                      handleSaveButtonPressed();
                    },
                    text: 'Submit',
                    isLoading: controller.isLoading,
                  ),
                  20.sbh,
                  Text(
                    'If you keep editing your Classified, it will be the first show. You can Add only One Classified and if you want to Add more than One Classified then you have to Pay.',
                    style:
                        textStyleW500(size.width * 0.030, AppColors.blackText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleSaveButtonPressed() async {
    FocusScope.of(context).unfocus();
    if (file.value == null && controller.userImage.value.isEmpty) {
      showToasterrorborder("Please Upload Photo", context);
    } else if (controller
        .getSelectedCategoryTextController()
        .value
        .text
        .isEmpty) {
      showToasterrorborder("Please Select Category", context);
    } else if (controller
        .getSelectedSubCategoryTextController()
        .value
        .text
        .isEmpty) {
      showToasterrorborder("Please Select SubCategory", context);
    } else if (controller.companyName.value.text.isEmpty) {
      showToasterrorborder("Please Add Your Company Name", context);
    } else if (controller.location.value.text.isEmpty) {
      showToasterrorborder("The address field is required.", context);
    } else if (controller.isCategorySelectedList.contains(true)) {
      if (controller.addressValidationColor.value != AppColors.redText) {
        await controller.updateClassified(
            file.value, widget.classfiedId, context);
      } else {
        showToasterrorborder("Please enter a valid address.", context);
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
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                icon: Icon(Icons.image, color: AppColors.primaryColor),
                label: Text(
                  'Gallery',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 100);
    if (pickedFile != null) {
      if (kDebugMode) {
        print('Picked image path: ${pickedFile.path}');
      }
      io.File imageFile = io.File(pickedFile.path);

      if (imageFile.lengthSync() / 1024 > 5000) {
        Fluttertoast.showToast(msg: 'Please select an image below 5 MB');
        return;
      }

      // Crop image
      io.File? croppedFile = await _cropImage(imageFile);
      if (croppedFile == null || croppedFile.lengthSync() == 0) {
        Fluttertoast.showToast(msg: 'Image cropping failed');
        return;
      }
      if (kDebugMode) {
        print('Cropped image path: ${croppedFile.path}');
      }

      // Compress image
      io.File? compressedFile = await _compressImage(croppedFile);
      if (compressedFile == null || compressedFile.lengthSync() == 0) {
        Fluttertoast.showToast(msg: 'Image compression failed');
        return;
      }
      if (kDebugMode) {
        print('Compressed image path: ${compressedFile.path}');
      }

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFile = io.File(
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await compressedFile.copy(tempFile.path);

      if (tempFile.existsSync() && tempFile.lengthSync() > 0) {
        file.value = tempFile;
        if (kDebugMode) {
          print('Updated file observable: ${file.value?.path}');
        }
        Get.back();
      } else {
        if (kDebugMode) {
          print('Temporary file saving failed');
        }
        Fluttertoast.showToast(
            msg: 'Failed to save the image. Please try again.');
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
}

// Catagory
void showSelectCategory(
  BuildContext context,
  Size size,
  ManageClasifiedController controller,
  List<GetCategoryCategory> categorylist,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return Obx(() {
        if (controller.isLoading.value && categorylist.isEmpty) {
          return Center(
            child: CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            ),
          );
        }

        if (categorylist.isEmpty) {
          return const Center(
            child: Text(
              'Data not found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }

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
                    'Select Category',
                    style:
                        textStyleW600(size.width * 0.045, AppColors.blackText),
                  ),
                ),
                20.sbh,
                Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: categorylist.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.toggleCategorySelected(
                                    index, context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          controller.toggleCategorySelected(
                                              index, context);
                                        },
                                        child: Image.asset(
                                          controller
                                                  .isCategorySelectedList[index]
                                              ? Assets.imagesTrueCircle
                                              : Assets.imagesCircle,
                                        ),
                                      ),
                                    ),
                                    15.sbw,
                                    Text(
                                      categorylist[index].name ?? '',
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
                      }),
                ),
                Center(
                  child: CustomButton(
                    title: "Continue",
                    btnColor: AppColors.primaryColor,
                    titleColor: AppColors.white,
                    onTap: () {
                      if (controller.selectedCountCategory > 0) {
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
                    isLoading: controller.isLoading,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}

// SubCatagory
void showSelectSubCategory(
  BuildContext context,
  Size size,
  ManageClasifiedController controller,
  List<GetSubCategoryCategory> subcategoryList,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return Obx(() {
        if (controller.isLoading.value && subcategoryList.isEmpty) {
          return Center(
            child: CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            ),
          );
        }

        if (subcategoryList.isEmpty) {
          return const Center(
            child: Text(
              'Data not found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }
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
                    'Select Sub Category',
                    style:
                        textStyleW600(size.width * 0.045, AppColors.blackText),
                  ),
                ),
                20.sbh,
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: subcategoryList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.toggleSubCategorySelected(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        controller
                                            .toggleSubCategorySelected(index);
                                      },
                                      child: Image.asset(
                                        (controller.isSubCategorySelectedList[
                                                index])
                                            ? Assets.imagesTrueCircle
                                            : Assets.imagesCircle,
                                      ),
                                    ),
                                  ),
                                  15.sbw,
                                  Text(
                                    subcategoryList[index].name ?? '',
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
                      if (controller.selectedCountSubCategory > 0) {
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
                    isLoading: controller.isLoading,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
