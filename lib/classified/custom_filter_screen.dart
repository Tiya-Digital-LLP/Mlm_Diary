import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';

class ClassifiedBottomSheetContent extends StatefulWidget {
  const ClassifiedBottomSheetContent({super.key});

  @override
  State<ClassifiedBottomSheetContent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ClassifiedBottomSheetContent> {
  final ClasifiedController controller = Get.put(ClasifiedController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 80,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // ignore: deprecated_member_use
                  color: AppColors.grey.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: Text(
                'Filter',
                style: textStyleW700(
                  size.width * 0.048,
                  AppColors.blackText,
                ),
              ),
            ),
            10.sbh,
            Obx(
              () => BorderContainer(
                isError: controller.categoryError.value,
                height: 58,
                child: TextField(
                  controller: controller.getSelectedCategoryTextController(),
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
                  style: textStyleW700(size.width * 0.038, AppColors.blackText),
                  cursorColor: AppColors.blackText,
                  decoration: InputDecoration(
                      labelText: "Select Category",
                      labelStyle: textStyleW400(
                          size.width * 0.038, AppColors.blackText),
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
              () => BorderContainer(
                isError: controller.subCategoryError.value,
                height: 58,
                child: TextField(
                  controller: controller.getSelectedSubCategoryTextController(),
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
                  style: textStyleW700(size.width * 0.038, AppColors.blackText),
                  cursorColor: AppColors.blackText,
                  decoration: InputDecoration(
                      labelText: "Select Sub Category",
                      labelStyle: textStyleW400(
                          size.width * 0.038, AppColors.blackText),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          controller.resetSelections();
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          side: BorderSide(color: AppColors.redText),
                        ),
                        child: Text(
                          'Cancel',
                          style: textStyleW700(
                            size.width * 0.04,
                            AppColors.redText,
                            isMetropolis: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.getTestClassified(1);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: Text(
                          'Apply',
                          style: textStyleW700(
                            size.width * 0.04,
                            AppColors.white,
                            isMetropolis: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
                  style: textStyleW700(
                    size.width * 0.048,
                    AppColors.blackText,
                  ),
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
                              if (!controller.isCategorySelectedList[index]) {
                                controller.toggleCategorySelected(
                                    index, context);
                              } else {
                                showToasterrorborder(
                                    'Please select only one category.',
                                    context);
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
                                            .isCategorySelectedList[index]) {
                                          controller.toggleCategorySelected(
                                              index, context);
                                        } else {
                                          showToasterrorborder(
                                              'Please select only one category.',
                                              context);
                                        }
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
                      showToasterrorborder(
                          'Please select at least one field.', context);
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

// SubCatagory
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
                  style: textStyleW700(
                    size.width * 0.048,
                    AppColors.blackText,
                  ),
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
                            if (!controller.isSubCategorySelectedList[index]) {
                              controller.toggleSubCategorySelected(index);
                            } else {
                              showToasterrorborder(
                                  'Please select only one Sub category.',
                                  context);
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
                                        showToasterrorborder(
                                            'Please select only one Sub category.',
                                            context);
                                      }
                                    },
                                    child: Image.asset(
                                      (controller
                                              .isSubCategorySelectedList[index])
                                          ? Assets.imagesTrueCircle
                                          : Assets.imagesCircle,
                                    ),
                                  ),
                                ),
                                15.sbw,
                                Text(
                                  subcategoryList[index].name ?? '',
                                  style: textStyleW600(
                                      size.width * 0.038, AppColors.blackText),
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
                      showToasterrorborder(
                          'Please select at least one field.', context);
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
