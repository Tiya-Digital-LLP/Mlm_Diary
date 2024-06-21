import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/sign_up/controller/signup2_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class PlanandCompany extends StatefulWidget {
  const PlanandCompany({super.key});

  @override
  State<PlanandCompany> createState() => _PlanandCompanyState();
}

class _PlanandCompanyState extends State<PlanandCompany> {
  final Signup2Controller controller = Get.put(Signup2Controller());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());

  bool isNextStep = false;

  @override
  void initState() {
    super.initState();
    controller.fetchPlanList();
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
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                if (isNextStep) {
                  setState(() {
                    isNextStep = false;
                  });
                } else {
                  Get.back();
                }
              },
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Plan & Company Interest',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: isNextStep
          ? Obx(() {
              if (clasifiedController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                ),
                child: clasifiedController.companyNames.isEmpty
                    ? Center(
                        child: Text(
                          'No companies found.',
                          style: textStyleW500(
                              size.width * 0.041, AppColors.blackText),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: SizedBox(
                              width: double.infinity,
                              child: CustomSearchInput(
                                controller:
                                    clasifiedController.searchController,
                                onSubmitted: (value) {
                                  clasifiedController.fetchCompanyNames(value);
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  clasifiedController.companyNames.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 2,
                                  ),
                                  child: Card(
                                    elevation: 2.5,
                                    color: AppColors.white,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          clasifiedController
                                              .toggleCompanySelected(index);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              clasifiedController
                                                          .isCompanySelectedList[
                                                      index]
                                                  ? Assets.imagesTrueCircle
                                                  : Assets.imagesCircle,
                                            ),
                                            15.sbw,
                                            Expanded(
                                              child: Text(
                                                clasifiedController
                                                    .companyNames[index],
                                                style: textStyleW700(
                                                  size.width * 0.036,
                                                  AppColors.blackText,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              );
            })
          : Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: controller.planList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        child: SizedBox(
                          height: 60,
                          child: Card(
                            elevation: 2.5,
                            color: AppColors.white,
                            child: GestureDetector(
                              onTap: () {
                                controller.togglePlanSelected(index, context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                      controller.planList[index].name ?? '',
                                      style: textStyleW700(size.width * 0.036,
                                          AppColors.blackText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 60,
          child: CustomButton(
            title: isNextStep ? "Done" : "Next",
            btnColor: AppColors.primaryColor,
            titleColor: AppColors.white,
            onTap: () {
              if (isNextStep) {
                if (clasifiedController.selectedCountCompany > 0) {
                  Get.back();
                } else {
                  showToasterrorborder(
                    "Please select at least one Company.",
                    context,
                  );
                }
              } else {
                if (controller.selectedCountPlan > 0) {
                  setState(() {
                    isNextStep = true;
                  });
                  clasifiedController.fetchCompanyNames("");
                } else {
                  showToasterrorborder(
                    "Please select at least one field.",
                    context,
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
