import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/plan&companyintrest/controller/intrest_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class PlanandCompany extends StatefulWidget {
  const PlanandCompany({super.key});

  @override
  State<PlanandCompany> createState() => _PlanandCompanyState();
}

class _PlanandCompanyState extends State<PlanandCompany> {
  final IntrestController controller = Get.put(IntrestController());

  bool isNextStep = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
    _refreshDataCompany();
  }

  Future<void> _refreshData() async {
    await controller.fetchSelectedPlanList();
  }

  Future<void> _refreshDataCompany() async {
    await controller.fetchSelectedCompanyList(1);
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
              if (controller.isLoading.value &&
                  controller.companyList.isEmpty) {
                return Center(
                  child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomSearchInput(
                          controller: controller.search,
                          onSubmitted: (value) {
                            controller.companyList.clear();
                            controller.isEndOfData.value = false;
                            controller.fetchSelectedCompanyList(1);
                          },
                          onChanged: (value) {
                            _refreshDataCompany();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshDataCompany,
                        child: ListView.builder(
                          itemCount: controller.companyList.length +
                              (controller.isLoading.value ? 1 : 0),
                          controller: controller.scrollController,
                          itemBuilder: (context, index) {
                            if (index == controller.companyList.length) {
                              return Center(
                                child: CustomLottieAnimation(
                                  child: Lottie.asset(
                                    Assets.lottieLottie,
                                  ),
                                ),
                              );
                            }

                            final post = controller.companyList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              child: Card(
                                elevation: 2.5,
                                color: AppColors.white,
                                child: Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      controller.toggleCompanySelected(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            controller.isCompanySelectedList[
                                                    index]
                                                ? Assets.imagesTrueCircle
                                                : Assets.imagesCircle,
                                          ),
                                          15.sbw,
                                          Expanded(
                                            child: Text(
                                              post.name ?? '',
                                              style: textStyleW700(
                                                  size.width * 0.036,
                                                  AppColors.blackText),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          : Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomSearchInput(
                        controller: controller.search,
                        onSubmitted: (value) {
                          _refreshData();
                        },
                        onChanged: (value) {
                          _refreshData();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView.builder(
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
                                        // User-initiated selection
                                        controller.togglePlanSelected(
                                          index,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  controller.togglePlanSelected(
                                                      index);
                                                },
                                                child: Image.asset(
                                                  controller.isPlanSelectedList[
                                                          index]
                                                      ? Assets.imagesTrueCircle
                                                      : Assets.imagesCircle,
                                                ),
                                              ),
                                            ),
                                            15.sbw,
                                            Text(
                                              controller.planList[index].name ??
                                                  '',
                                              style: textStyleW700(
                                                  size.width * 0.036,
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
                      ),
                    ),
                  ),
                ],
              );
            }),
      floatingActionButton: isNextStep
          ? InkWell(
              onTap: () async {
                Get.toNamed(Routes.addcompany);
              },
              child: Ink(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    Assets.svgPlusIcon,
                  ),
                ),
              ),
            )
          : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 60,
          child: CustomButton(
            title: isNextStep ? "Done" : "Next",
            btnColor: AppColors.primaryColor,
            titleColor: AppColors.white,
            onTap: () async {
              if (isNextStep) {
                bool hasAutoSelected = controller.companyList
                    .any((company) => company.selected == true);
                if (controller.selectedCountCompany > 0 || hasAutoSelected) {
                  List<String> selectedComapanyname = [];
                  for (int i = 0; i < controller.companyList.length; i++) {
                    if (controller.isCompanySelectedList[i]) {
                      selectedComapanyname
                          .add(controller.companyList[i].name.toString());
                    }
                  }

                  await controller.updateCompany(selectedComapanyname, context);
                  Get.back();
                } else {
                  showToasterrorborder(
                      "Please select at least one Company.", context);
                }
              } else {
                bool hasAutoSelected =
                    controller.planList.any((plan) => plan.selected == true);

                if (controller.selectedCountPlan > 0 || hasAutoSelected) {
                  setState(() {
                    isNextStep = true;
                  });

                  List<String> selectedPlanname = [];
                  for (int i = 0; i < controller.planList.length; i++) {
                    if (controller.isPlanSelectedList[i]) {
                      selectedPlanname
                          .add(controller.planList[i].name.toString());
                    }
                  }

                  await controller.updateUserPlan(selectedPlanname, context);
                } else {
                  showToasterrorborder(
                      "Please select at least one field.", context);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
