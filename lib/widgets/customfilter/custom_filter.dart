import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/customfilter/controller/filter_controller.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomSheetContent> {
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.white,
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
                color: AppColors.grey.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Text(
              'Filter',
              style: textStyleW700(size.width * 0.043, AppColors.blackText),
            ),
          ),
          10.sbh,
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BorderContainer(
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

                      showBottomSheetFunc(context, size, controller, planList);
                      controller.planCategoryValidation();

                      log("AFTER == ${controller.planTypeError.value}");
                    },
                    style:
                        textStyleW500(size.width * 0.04, AppColors.blackText),
                    cursorColor: AppColors.blackText,
                    decoration: InputDecoration(
                        hintText: "Select Plan Name",
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.blackText,
                        )),
                  ),
                ),
              ),
            ),
          ),
          10.sbh,
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BorderContainer(
                isError: controller.companyError.value,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller.getSelectedCompanyTextController(),
                    readOnly: true,
                    onTap: () {
                      log("BEFORE ==  ${controller.companyError.value}");

                      showBottomSheetFunc1(
                          context, size, controller, companyList);
                      controller.mlmsubCompanyValidation();

                      log("AFTER == ${controller.companyError.value}");
                    },
                    style:
                        textStyleW500(size.width * 0.04, AppColors.blackText),
                    cursorColor: AppColors.blackText,
                    decoration: InputDecoration(
                        hintText: "Select Work Company Name",
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.blackText,
                        )),
                  ),
                ),
              ),
            ),
          ),
          10.sbh,
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BorderTextField(
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
                  height: 85,
                ),
              )),
          10.sbh,
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BorderContainer(
                isError: controller.userTypeError.value,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller.getSelectedUserTypeTextController(),
                    readOnly: true,
                    onTap: () {
                      log("BEFORE ==  ${controller.userTypeError.value}");

                      showBottomSheetFunc2(
                          context, size, controller, userTypeList);
                      controller.userTypeValidation();

                      log("AFTER == ${controller.userTypeError.value}");
                    },
                    style:
                        textStyleW500(size.width * 0.04, AppColors.blackText),
                    cursorColor: AppColors.blackText,
                    decoration: InputDecoration(
                        hintText: "User Type",
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.blackText,
                        )),
                  ),
                ),
              ),
            ),
          ),
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
                        style:
                            textStyleW700(size.width * 0.04, AppColors.redText),
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
                        style:
                            textStyleW700(size.width * 0.04, AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showBottomSheetFunc(
  BuildContext context,
  Size size,
  FilterController controller,
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
                  width: 80,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              10.sbh,
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

void showBottomSheetFunc1(
  BuildContext context,
  Size size,
  FilterController controller,
  List<String> companyList,
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
                  width: 80,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              10.sbh,
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
                          controller.toggleCompanySelected(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.toggleCompanySelected(index);
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

void showBottomSheetFunc2(
  BuildContext context,
  Size size,
  FilterController controller,
  List<String> userTypeList,
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
                  width: 80,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              10.sbh,
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
                itemCount: userTypeList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.toggleUserTypeSelected(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.toggleUserTypeSelected(index);
                                  },
                                  child: Image.asset(
                                    (controller.isUserTypeList[index])
                                        ? Assets.imagesTrueCircle
                                        : Assets.imagesCircle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                userTypeList[index],
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
                    if (controller.selectedUserType > 0) {
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
