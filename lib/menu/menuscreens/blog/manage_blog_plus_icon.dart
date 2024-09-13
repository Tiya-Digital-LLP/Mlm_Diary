import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/discription_text_field.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/normal_button.dart';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

class ManageBlogPlusIcon extends StatefulWidget {
  const ManageBlogPlusIcon({super.key});

  @override
  State<ManageBlogPlusIcon> createState() => _ManageBlogPlusIconState();
}

class _ManageBlogPlusIconState extends State<ManageBlogPlusIcon> {
  final ManageBlogController controller = Get.put(ManageBlogController());
  final ImagePicker _picker = ImagePicker();
  Rx<io.File?> file = Rx<io.File?>(null);
  static List<io.File> imagesList = <io.File>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMyBlog();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage Blog',
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
                      height: 65,
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderContainer(
                      isError: controller.categoryError.value,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller:
                              controller.getSelectedCategoryTextController(),
                          readOnly: true,
                          onTap: () {
                            log("BEFORE ==  ${controller.categoryError.value}");

                            showSelectCategory(context, size, controller,
                                controller.categorylist);
                            controller.mlmCategoryValidation();

                            log("AFTER == ${controller.categoryError.value}");
                          },
                          style: textStyleW500(
                              size.width * 0.04, AppColors.blackText),
                          cursorColor: AppColors.blackText,
                          decoration: InputDecoration(
                              hintText: "Select Category",
                              contentPadding: const EdgeInsets.only(
                                top: 3,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.blackText,
                              )),
                        ),
                      ),
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderContainer(
                      isError: controller.subCategoryError.value,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller:
                              controller.getSelectedSubCategoryTextController(),
                          readOnly: true,
                          onTap: () {
                            log("BEFORE ==  ${controller.subCategoryError.value}");

                            showSelectSubCategory(
                              context,
                              size,
                              controller,
                              controller.subcategoryList,
                            );
                            controller.mlmsubCategoryValidation();

                            log("AFTER == ${controller.subCategoryError.value}");
                          },
                          style: textStyleW500(
                              size.width * 0.04, AppColors.blackText),
                          cursorColor: AppColors.blackText,
                          decoration: InputDecoration(
                              hintText: "Select Sub Category",
                              contentPadding: const EdgeInsets.only(top: 3),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.blackText,
                              )),
                        ),
                      ),
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
                      hint: "Website Url",
                      controller: controller.url.value,
                      isError: controller.urlError.value,
                      byDefault: !controller.isUrlTyping.value,
                      onChanged: (value) {
                        controller.urlValidation();
                        controller.isUrlTyping.value = true;
                      },
                      height: 65,
                    ),
                  ),
                  10.sbh,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13.05),
                    child: Stack(
                      children: [
                        Obx(
                          () => GestureDetector(
                            child: file.value != null
                                ? Image.file(
                                    file.value!,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : controller.userImage.value.isNotEmpty
                                    ? Image.network(
                                        controller.userImage.value,
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
                                      child: Icon(Icons.delete,
                                          color: AppColors.redText),
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
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.terms);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "News will be displayed after reviewing by admin it may be chargeable   ",
                            style: textStyleW500(
                                size.width * 0.030, AppColors.blackText),
                          ),
                          TextSpan(
                            text: "Read More",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
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
    if (controller.title.value.text.isEmpty) {
      showToasterrorborder("Please Enter Your Blog Title", context);
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
    } else if (controller.discription.value.text.isEmpty) {
      showToasterrorborder(
          "Please Enter Description Minimum 250 Characters", context);
    } else if (file.value == null && controller.userImage.value.isEmpty) {
      showToasterrorborder("Please Upload Photo", context);
    } else {
      try {
        await controller.updateBlog(imageFile: file.value);
      } catch (e) {
        if (kDebugMode) {
          print("Error submitting news: $e");
        }
      }
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

        // Save to a different directory if necessary
        final tempDir = await getTemporaryDirectory();
        final tempFile = io.File(
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await croppedFile.copy(tempFile.path);

        file.value = tempFile; // Update file observable with new file
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
}

//category

void showSelectCategory(
  BuildContext context,
  Size size,
  ManageBlogController controller,
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
  ManageBlogController controller,
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
