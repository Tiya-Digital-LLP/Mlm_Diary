import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:google_api_headers/google_api_headers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/add_comapany_classfied.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
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

class AddClassified extends StatefulWidget {
  const AddClassified({super.key});

  @override
  State<AddClassified> createState() => _AddClassifiedState();
}

class _AddClassifiedState extends State<AddClassified> {
  final ClasifiedController controller = Get.put(ClasifiedController());
  Rx<io.File?> file = Rx<io.File?>(null);
  late double lat = 0.0;
  late double log = 0.0;
  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";
  final RxList<String> selectedCompanies = <String>[].obs;
  static List<io.File> imagesList = <io.File>[];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _loc = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Add Classified',
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
                        controller.titleValidation();
                        controller.isTitleTyping.value = true;
                      },
                      height: 58,
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderContainer(
                      isError: controller.categoryError.value,
                      byDefault: !controller.isCategoryTyping.value,
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
                            vertical: 5,
                            horizontal: 2,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.blackText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderContainer(
                      isError: controller.subCategoryError.value,
                      byDefault: !controller.isSubCategoryTyping.value,
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
                            labelText: "Select Sub Category",
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
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
                        labelStyle: const TextStyle(
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
                            controller.locationValidation();
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
                  10.sbh,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13.05),
                    child: Stack(
                      children: [
                        GestureDetector(
                          child: file.value != null
                              ? Image.file(
                                  file.value!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(Assets.svgUploadImage),
                          onTap: () {
                            if (file.value == null) {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => bottomsheet());
                            }
                          },
                        ),
                        Visibility(
                          visible: file.value == null ? false : true,
                          child: Positioned(
                              top: 10,
                              left: 320,
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
                                        size: 22,
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
    controller.titleValidation();
    controller.discriptionValidation(context);
    controller.mlmCategoryValidation();
    controller.mlmsubCategoryValidation();
    controller.locationValidation();

    if (controller.title.value.text.isEmpty) {
      showToasterrorborder("Please Enter Your Classified Title", context);
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
      showToasterrorborder("Please Select Sub Category", context);
    } else if (controller.companyName.value.text.isEmpty) {
      showToasterrorborder("Please Add Your Company Name", context);
    } else if (controller.discription.value.text.isEmpty) {
      showToasterrorborder(
          "Please Enter Description Minimum 250 Characters", context);
    } else if (controller.location.value.text.isEmpty) {
      showToasterrorborder("Please Search and Save Location.", context);
    } else if (file.value == null) {
      showToasterrorborder("Please Upload Photo", context);
    } else if (controller.isCategorySelectedList.contains(true)) {
      // Perform address validation
      if (controller.addressValidationColor.value != AppColors.redText) {
        await controller.addClassifiedDetails(
          imageFile: file.value,
        );
      } else {
        showToasterrorborder("Please enter a valid address.", context);
      }
    } else {
      //
    }
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
        Fluttertoast.showToast(msg: 'Please Select an image below 5 MB');
        return;
      }

      io.File? processedFile = imageFile;

      if (fileSizeInKB > 250) {
        processedFile = await _cropImage(imageFile);
        if (processedFile == null) {
          Fluttertoast.showToast(msg: 'Please select an image');
          if (kDebugMode) {
            print('failed to compress image');
          }
          return;
        }
        processedFile = await _compressImage(processedFile);
      }

      double processedFileSizeInKB = processedFile!.lengthSync() / 1024;
      if (kDebugMode) {
        print('Processed image size: $processedFileSizeInKB KB');
      }

      setState(() {
        file.value = processedFile;
      });

      if (file.value != null) {
        imagesList.add(file.value!);
      }

      Get.back();
    } else {
      // ignore: use_build_context_synchronously
      showToasterrorborder('Please select an image', context);
      return; // Exit function if no image is selected
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

//category

void showSelectCategory(
  BuildContext context,
  Size size,
  ClasifiedController controller,
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
                              controller.toggleCategorySelected(index, context);
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
                                        controller.isCategorySelectedList[index]
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
                    },
                  ),
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
                          msg: "Please select at least one category.",
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

// SubCategory
void showSelectSubCategory(
  BuildContext context,
  Size size,
  ClasifiedController controller,
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
                              if (!controller
                                  .isSubCategorySelectedList[index]) {
                                controller.toggleSubCategorySelected(index);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please select only one Sub category.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        if (!controller
                                            .isSubCategorySelectedList[index]) {
                                          controller
                                              .toggleSubCategorySelected(index);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg:
                                                "Please select only one Sub category.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        controller.isSubCategorySelectedList[
                                                index]
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
