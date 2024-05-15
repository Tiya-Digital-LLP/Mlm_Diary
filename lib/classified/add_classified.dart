import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class AddClassified extends StatefulWidget {
  const AddClassified({super.key});

  @override
  State<AddClassified> createState() => _AddClassifiedState();
}

class _AddClassifiedState extends State<AddClassified> {
  final ClasifiedController controller = Get.put(ClasifiedController());

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
                      height: 60,
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
                    () => BorderContainer(
                      isError: controller.companyError.value,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller:
                              controller.getSelectedCompanyTextController(),
                          readOnly: true,
                          onTap: () {
                            log("BEFORE ==  ${controller.companyError.value}");

                            showSelectCompany(context, size, controller);
                            controller.mlmsubCompanyValidation();

                            log("AFTER == ${controller.companyError.value}");
                          },
                          style: textStyleW500(
                              size.width * 0.04, AppColors.blackText),
                          cursorColor: AppColors.blackText,
                          decoration: InputDecoration(
                              hintText: "Select Company",
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
                            log("BEFORE ==  ${controller.planTypeError.value}");

                            showPlan(context, size, controller, planList);
                            controller.planCategoryValidation();

                            log("AFTER == ${controller.planTypeError.value}");
                          },
                          style: textStyleW500(
                              size.width * 0.04, AppColors.blackText),
                          cursorColor: AppColors.blackText,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 3),
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
                  10.sbh,
                  Obx(
                    () => BorderTextField(
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
                      height: 60,
                    ),
                  ),
                  10.sbh,
                  Obx(
                    () => BorderTextField(
                      maxLength: 25,
                      keyboard: TextInputType.streetAddress,
                      textInputType: const [],
                      hint: "Location",
                      controller: controller.location.value,
                      isError: controller.locationError.value,
                      byDefault: !controller.isLocationTyping.value,
                      onChanged: (value) {
                        controller.locationValidation();
                        controller.isLocationTyping.value = true;
                      },
                      height: 60,
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
}

// Catagory
void showSelectCategory(
    BuildContext context, Size size, ClasifiedController controller) {
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
  ClasifiedController controller,
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

// Company
void showSelectCompany(
    BuildContext context, Size size, ClasifiedController controller) {
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
                  'Select Company',
                  style: textStyleW600(size.width * 0.045, AppColors.blackText),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: companyList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedCountCompany < 3 ||
                              controller.isCompanyList[index]) {
                            controller.toggleCompanySelected(index);
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
                                    if (controller.selectedCountCompany < 3 ||
                                        controller.isCompanyList[index]) {
                                      controller.toggleCompanySelected(index);
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
                                    (controller.isCompanyList[index])
                                        ? Assets.imagesTrueCircle
                                        : Assets.imagesCircle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                companyList[index],
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
                    if (controller.selectedCountCompany > 0) {
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

// plan
void showPlan(
  BuildContext context,
  Size size,
  ClasifiedController controller,
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
                  style: textStyleW600(size.width * 0.045, AppColors.blackText),
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
