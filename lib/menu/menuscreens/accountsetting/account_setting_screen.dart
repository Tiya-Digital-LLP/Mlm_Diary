import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/controller/account_setting_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AccountSeetingController controller =
      Get.put(AccountSeetingController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.all(size.height * 0.012),
            child: const Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
          ),
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Account Settings',
                style: textStyleW700(size.width * 0.048, AppColors.blackText),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: _tabController,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(42.26),
                          color: AppColors.primaryColor),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            'User Info',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Social Media',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Login Details',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(Assets.imagesIcon),
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
                          10.sbh,
                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BorderContainer(
                                isError: controller.mlmTypeError.value,
                                height: 65,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextField(
                                    controller: controller
                                        .getSelectedOptionsTextController(),
                                    readOnly: true,
                                    onTap: () {
                                      log("BEFORE ==  ${controller.mlmTypeError.value}");

                                      showBottomSheetFunc(
                                          context, size, controller);
                                      controller.mlmCategoryValidation();

                                      log("AFTER == ${controller.mlmTypeError.value}");
                                    },
                                    style: textStyleW500(
                                        size.width * 0.04, AppColors.blackText),
                                    cursorColor: AppColors.blackText,
                                    decoration: InputDecoration(
                                        hintText: " I am a MLM*",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BorderTextField(
                                maxLength: 25,
                                keyboard: TextInputType.name,
                                textInputType: const [],
                                hint: "Your Name",
                                controller: controller.name.value,
                                byDefault: !controller.isNameTyping.value,
                                height: 65,
                              ),
                            ),
                          ),
                          10.sbh,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Obx(
                              () => Row(
                                children: [
                                  Text(
                                    "Gender",
                                    style: textStyleW400(size.width * 0.045,
                                        AppColors.blackText.withOpacity(0.5)),
                                  ),
                                  20.sbw,
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
                                              color: (controller.isGenderToggle
                                                          .value ==
                                                      true)
                                                  ? AppColors.primaryColor
                                                  : AppColors.blackText
                                                      .withOpacity(0.5),
                                            ),
                                            (controller.isGenderToggle.value ==
                                                    true)
                                                ? Positioned(
                                                    top: 3,
                                                    left: 3,
                                                    child: Image.asset(Assets
                                                        .imagesSelectedCircle))
                                                : Container()
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Male",
                                          style: (controller
                                                      .isGenderToggle.value ==
                                                  true)
                                              ? textStyleW500(
                                                  size.width * 0.045,
                                                  AppColors.primaryColor)
                                              : textStyleW400(
                                                  size.width * 0.045,
                                                  AppColors.blackText
                                                      .withOpacity(0.5),
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
                                              color: (controller.isGenderToggle
                                                          .value ==
                                                      false)
                                                  ? AppColors.primaryColor
                                                  : AppColors.blackText
                                                      .withOpacity(0.5),
                                            ),
                                            (controller.isGenderToggle.value ==
                                                    false)
                                                ? Positioned(
                                                    top: 3,
                                                    left: 3,
                                                    child: Image.asset(Assets
                                                        .imagesSelectedCircle))
                                                : Container()
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Female",
                                          style: (controller
                                                      .isGenderToggle.value ==
                                                  false)
                                              ? textStyleW500(
                                                  size.width * 0.045,
                                                  AppColors.primaryColor)
                                              : textStyleW400(
                                                  size.width * 0.045,
                                                  AppColors.blackText
                                                      .withOpacity(0.5),
                                                ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          10.sbh,
                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BorderTextField(
                                maxLength: 25,
                                keyboard: TextInputType.name,
                                textInputType: const [],
                                hint: "Company",
                                controller: controller.companyname.value,
                                byDefault:
                                    !controller.isCompanyNameTyping.value,
                                height: 65,
                              ),
                            ),
                          ),
                          10.sbh,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Obx(
                              () => BorderContainer(
                                isError: controller.planTypeError.value,
                                height: 65,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextField(
                                    controller: controller
                                        .getSelectedPlanOptionsTextController(),
                                    readOnly: true,
                                    onTap: () {
                                      log("BEFORE ==  ${controller.planTypeError.value}");

                                      showBottomSheetFuncPlan(
                                          context, size, controller, planList);
                                      controller.planCategoryValidation();

                                      log("AFTER == ${controller.planTypeError.value}");
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
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          10.sbh,
                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BorderTextField(
                                maxLength: 25,
                                keyboard: TextInputType.name,
                                textInputType: const [],
                                hint: "Location",
                                controller: controller.location.value,
                                byDefault: !controller.isLocationTyping.value,
                                height: 65,
                              ),
                            ),
                          ),
                          10.sbh,
                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BorderTextField(
                                maxLength: 25,
                                keyboard: TextInputType.name,
                                textInputType: const [],
                                hint: "About you",
                                controller: controller.about.value,
                                byDefault: !controller.isAboutTyping.value,
                                height: 65,
                              ),
                            ),
                          ),
                          10.sbh,
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: BorderTextField(
                                maxLength: 25,
                                keyboard: TextInputType.name,
                                textInputType: const [],
                                hint: "About company",
                                controller: controller.company.value,
                                byDefault: !controller.isAboutCompany.value,
                                height: 65,
                              ),
                            ),
                          ),
                          20.sbh,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: NormalButton(onPressed: () {}, text: 'Save'),
                          )
                        ],
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {},
                      child: const SizedBox(
                        child: Center(child: Text('User Notification')),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {},
                      child: const SizedBox(
                        child: Center(child: Text('Admin Notification')),
                      ),
                    ),
                  ]),
            ),
          ],
        ));
  }
}

void showBottomSheetFuncPlan(
  BuildContext context,
  Size size,
  AccountSeetingController controller,
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

void showBottomSheetFunc(
    BuildContext context, Size size, AccountSeetingController controller) {
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
                  'I am a MLM*',
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
                          if (controller.selectedCount < 3 ||
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
                                    if (controller.selectedCount < 3 ||
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
                    if (controller.selectedCount > 0) {
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
