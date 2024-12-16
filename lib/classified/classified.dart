import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/classified_card.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom_filter_screen.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_classified.dart';
import 'package:mlmdiary/widgets/custon_test_app_bar.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/remimaining_count_controller./remaining_count.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassifiedScreen extends StatefulWidget {
  const ClassifiedScreen({super.key});

  @override
  State<ClassifiedScreen> createState() => _ClassifiedScreenState();
}

class _ClassifiedScreenState extends State<ClassifiedScreen> {
  final ClasifiedController controller = Get.put(ClasifiedController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());

  static const String position = 'classified';
  final RxBool showShimmer = true.obs;
  @override
  void initState() {
    super.initState();
    // Start a timer to switch from shimmer to UI after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      showShimmer.value = false;
    });
    _refreshData();
    videoController.fetchVideo(position, context);
  }

  Future<void> _refreshData() async {
    controller.resetSelections();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustonTestAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Classified',
        onTap: () {},
        position: position,
        homeScreenController: homeScreenController,
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          homeScreenController.newIndex.value = 0;
          homeScreenController.tappedIndex.value = 0;
          return true;
        },
        child: RefreshIndicator(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.white,
          onRefresh: _refreshData,
          child: Container(
            color: AppColors.background,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                      5.sbw,
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const ClassifiedBottomSheetContent();
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height * 0.048,
                          width: size.height * 0.048,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.white, shape: BoxShape.circle),
                          child: SvgPicture.asset(Assets.svgFilter),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (showShimmer.value) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const CustomShimmerClassified(
                                width: 175, height: 240);
                          },
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Obx(() {
                          if (controller.isLoading.value &&
                              controller.classifiedList.isEmpty) {
                            return Center(
                              child: CustomLottieAnimation(
                                child: Lottie.asset(
                                  Assets.lottieLottie,
                                ),
                              ),
                            );
                          }

                          if (controller.classifiedList.isEmpty) {
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

                          return ListView.builder(
                            controller: controller.scrollController,
                            padding: EdgeInsets.zero,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.classifiedList.length +
                                (controller.isLoading.value ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == controller.classifiedList.length) {
                                return Center(
                                  child: CustomLottieAnimation(
                                    child: Lottie.asset(
                                      Assets.lottieLottie,
                                    ),
                                  ),
                                );
                              }

                              final post = controller.classifiedList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.getString(Constants.accessToken);
                                    Get.toNamed(
                                      Routes.mlmclassifieddetail,
                                      arguments: post,
                                    );
                                  },
                                  child: ClassifiedCard(
                                    image: post.userData?.imagePath ?? '',
                                    dateTime: post.createdate ?? '',
                                    updatedateTime: post.datemodified ?? '',

                                    classifiedId: post.id ?? 0,
                                    userImage: post.imageUrl ?? '',
                                    userName: post.userData?.name ?? '',
                                    postTitle: post.title ?? '',
                                    postCaption: post.description ?? '',
                                    likedCount: post.totallike ?? 0,
                                    controller: controller,
                                    viewcounts: post.pgcnt ?? 0,
                                    bookmarkCount: post.totalbookmark ?? 0,
                                    isPopular: post.popular == 'Y',
                                    url: post.fullUrl ?? '',
                                    likedbyuser: post.likedByUser ?? false,
                                    bookmarkedbyuser:
                                        post.bookmarkedByUser ?? false,
                                    commentcount: post.totalcomment ?? 0,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GetBuilder<CustomFloatingActionButtonController>(
        init: CustomFloatingActionButtonController(context),
        builder: (controller) => InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.getString(Constants.accessToken);
            String selectedType = 'classified';
            await controller.handleTap(selectedType);
          },
          child: Obx(
            () => Ink(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    controller.isLoading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor,
                            ),
                          )
                        : SvgPicture.asset(Assets.svgPlusIcon)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSignupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const SignupDialog();
    },
  );
}
