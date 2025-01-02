import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
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

class AddQuestionAnswer extends StatefulWidget {
  const AddQuestionAnswer({super.key});

  @override
  State<AddQuestionAnswer> createState() => _AddClassifiedState();
}

class _AddClassifiedState extends State<AddQuestionAnswer> {
  final QuestionAnswerController controller =
      Get.put(QuestionAnswerController());
  Rx<io.File?> file = Rx<io.File?>(null);
  late double lat = 0.0;
  late double log = 0.0;
  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";

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
        titleText: 'Add Question Answer',
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
                      maxLength: 100,
                      textInputType: const [],
                      hint: "Enter Title",
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
                    () => DiscriptionTextField(
                      keyboard: TextInputType.multiline,
                      textInputType: const [],
                      hint: "Enter answer",
                      controller: controller.answer.value,
                      isError: controller.answerError.value,
                      byDefault: !controller.isAnswerTyping.value,
                      onChanged: (value) {
                        controller.answerValidation(context);
                        controller.isAnswerTyping.value = true;
                      },
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
                  NormalButton(
                    onPressed: () {
                      handleSaveButtonPressed();
                    },
                    text: 'Submit',
                    isLoading: controller.isLoading,
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
    controller.titleValidation(context);
    controller.mlmCategoryValidation();
    controller.mlmsubCategoryValidation();

    if (controller.title.value.text.isEmpty) {
      showToasterrorborder("Please Enter Your Question", context);
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
    } else if (controller.isCategorySelectedList.contains(true)) {
      await controller.addQuestion(imageFile: file.value);
    } else {
      //
    }
  }

//category

  void showSelectCategory(
    BuildContext context,
    Size size,
    QuestionAnswerController controller,
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
                      style: textStyleW600(
                          size.width * 0.045, AppColors.blackText),
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
    QuestionAnswerController controller,
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
                      style: textStyleW600(
                          size.width * 0.045, AppColors.blackText),
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
                                                  .isSubCategorySelectedList[
                                              index]) {
                                            controller
                                                .toggleSubCategorySelected(
                                                    index);
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
}
