import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompanies_card.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class MlmCompanies extends StatefulWidget {
  const MlmCompanies({super.key});

  @override
  State<MlmCompanies> createState() => _MlmCompaniesState();
}

class _MlmCompaniesState extends State<MlmCompanies> {
  final CompanyController controller = Get.put(CompanyController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'company';
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  void initState() {
    super.initState();
    _refreshData();
    videoController.fetchVideo(position, context);
  }

  Future<void> _refreshData() async {
    await controller.getAdminCompany(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              customBorder: const CircleBorder(),
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'MLM Companies',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.048,
            color: Colors.black,
            fontFamily: Assets.fontsSatoshiRegular,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              if (position.isEmpty) {
                await videoController.fetchVideo('', context);
                Get.toNamed(Routes.tutorialvideo, arguments: {'position': ''});
              } else if (position == 'company') {
                await videoController.fetchVideo('company', context);
                Get.toNamed(Routes.tutorialvideo,
                    arguments: {'position': 'company'});
              }
            },
            child: SvgPicture.asset(
              Assets.svgPlay,
              height: size.width * 0.08,
              width: size.width * 0.08,
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomSearchInput(
                      controller: controller.search,
                      onSubmitted: (value) {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                        _refreshData();
                      },
                      onChanged: (value) {
                        _refreshData();
                      },
                    ),
                  ),
                ],
              ),
              10.sbh,
              Obx(() {
                if (controller.isLoading.value &&
                    controller.companyAdminList.isEmpty) {
                  return Center(
                      child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ));
                }

                if (controller.companyAdminList.isEmpty) {
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
                return Expanded(
                    child: Container(
                  color: AppColors.background,
                  child: ListView.builder(
                    controller: controller.scrollController,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.companyAdminList.length +
                        (controller.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.companyAdminList.length) {
                        return Center(
                            child: CustomLottieAnimation(
                          child: Lottie.asset(
                            Assets.lottieLottie,
                          ),
                        ));
                      }

                      final post = controller.companyAdminList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.mlmcompaniesdetails,
                              arguments: post,
                            );
                          },
                          child: MlmCompaniesCard(
                            userImage: post.imageUrl ?? '',
                            companyId: post.id ?? 0,
                            controller: controller,
                            viewcounts: post.pgcnt ?? 0,
                            likedCount: post.totallike ?? 0,
                            postTitle: post.sname ?? '',
                            postCaption: post.description ?? '',
                            location: post.location ?? '',
                            shareurl: post.fullUrl ?? '',
                            commentcount: post.totalcomment ?? 0,
                            likedbyuser: post.likedByUser ?? false,
                            bookmarkedbyuser: post.bookmarkedByUser ?? false,
                          ),
                        ),
                      );
                    },
                  ),
                ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
