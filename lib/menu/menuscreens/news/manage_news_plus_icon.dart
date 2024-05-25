import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/discription_text_field.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class ManageNewsPlusIcon extends StatefulWidget {
  const ManageNewsPlusIcon({super.key});

  @override
  State<ManageNewsPlusIcon> createState() => _ManageNewsPlusIconState();
}

class _ManageNewsPlusIconState extends State<ManageNewsPlusIcon> {
  final ManageNewsController controller = Get.put(ManageNewsController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage News',
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
                      maxLength: 25,
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
                              controller.getSelectedOptionsTextController(),
                          readOnly: true,
                          onTap: () {
                            log("BEFORE ==  ${controller.categoryError.value}");

                            showSelectCategory(context, size, controller);
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
                          controller: controller
                              .getSelectedSubCategoryOptionsTextController(),
                          readOnly: true,
                          onTap: () {
                            log("BEFORE ==  ${controller.subCategoryError.value}");

                            showSelectSubCategory(
                              context,
                              size,
                              controller,
                              subCategoryList,
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
                      maxLength: 25,
                      keyboard: TextInputType.multiline,
                      textInputType: const [],
                      hint: "Description",
                      controller: controller.discription.value,
                      isError: controller.discriptionError.value,
                      byDefault: !controller.isDiscriptionTyping.value,
                      onChanged: (value) {
                        controller.discriptionValidation();
                        controller.isDiscriptionTyping.value = true;
                      },
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderTextField(
                      maxLength: 25,
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
                  20.sbh,
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(Assets.svgUploadImage)),
                  10.sbh,
                  NormalButton(
                    onPressed: () {},
                    text: 'Submit',
                  ),
                  20.sbh,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.advertisewithus);
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
}

// Catagory
void showSelectCategory(
    BuildContext context, Size size, ManageNewsController controller) {
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
                  'Select Category',
                  style: textStyleW600(size.width * 0.045, AppColors.blackText),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: mlmList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedCountCategory < 3 ||
                              controller.isTrueList[index]) {
                            controller.toggleSelected(index);
                          } else {
                            Fluttertoast.showToast(
                              msg: "You can select a maximum of 3 fields.",
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
                                    if (controller.selectedCountCategory < 3 ||
                                        controller.isTrueList[index]) {
                                      controller.toggleSelected(index);
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            "You can select a maximum of 3 fields.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    (controller.isTrueList[index])
                                        ? Assets.imagesTrueCircle
                                        : Assets.imagesCircle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                mlmList[index],
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
                    if (controller.selectedCountCategory > 0) {
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

// SubCatagory
void showSelectSubCategory(
  BuildContext context,
  Size size,
  ManageNewsController controller,
  List<String> subCategoryList,
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
                  'Select Sub Category',
                  style: textStyleW600(size.width * 0.045, AppColors.blackText),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: subCategoryList.length,
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
                                    controller.toggleSubCategorySelected(index);
                                  },
                                  child: Image.asset(
                                    (controller.isSubCategoryList[index])
                                        ? Assets.imagesTrueCircle
                                        : Assets.imagesCircle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                subCategoryList[index],
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
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
