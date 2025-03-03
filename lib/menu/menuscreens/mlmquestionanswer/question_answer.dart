import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_card.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_question.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuationAnswer extends StatefulWidget {
  const QuationAnswer({super.key});

  @override
  State<QuationAnswer> createState() => _QuationAnswerState();
}

class _QuationAnswerState extends State<QuationAnswer> {
  final QuestionAnswerController controller =
      Get.put(QuestionAnswerController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'questionanswer';
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final RxBool showShimmer = true.obs;

  @override
  void initState() {
    super.initState();
    // Start a timer to switch from shimmer to UI after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      showShimmer.value = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
    videoController.fetchVideo(position, context);
  }

  Future<void> _refreshData() async {
    await controller.getQuestion(1);
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
          'Question Answer',
          style: textStyleW700(
            size.width * 0.048,
            AppColors.blackText,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              if (position.isEmpty) {
                await videoController.fetchVideo('', context);
                Get.toNamed(Routes.tutorialvideo, arguments: {'position': ''});
              } else if (position == 'questionanswer') {
                await videoController.fetchVideo('questionanswer', context);
                Get.toNamed(Routes.tutorialvideo,
                    arguments: {'position': 'questionanswer'});
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
        color: AppColors.background,
        backgroundColor: AppColors.primaryColor,
        onRefresh: _refreshData,
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
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const CustomShimmerQuestion(
                          width: 175,
                          height: 180,
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value &&
                          controller.questionList.isEmpty) {
                        return Center(
                            child: CustomLottieAnimation(
                          child: Lottie.asset(
                            Assets.lottieLottie,
                          ),
                        ));
                      }

                      if (controller.questionList.isEmpty) {
                        return Center(
                          child: Text(
                            'Data not found',
                            style: textStyleW600(
                              size.width * 0.030,
                              AppColors.blackText,
                              isMetropolis: true,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: controller.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.questionList.length +
                            (controller.isLoading.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == controller.questionList.length) {
                            return Center(
                                child: CustomLottieAnimation(
                              child: Lottie.asset(
                                Assets.lottieLottie,
                              ),
                            ));
                          }
                          final post = controller.questionList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.getString(Constants.accessToken);
                                Get.toNamed(
                                  Routes.userquestion,
                                  arguments: post,
                                );
                              },
                              child: QuestionCard(
                                userImage: post.userData?.imagePath ?? '',
                                userName: post.userData?.name ?? '',
                                postCaption: post.title ?? '',
                                viewcounts: post.pgcnt ?? 0,
                                dateTime: post.creatdate ?? '',
                                controller: controller,
                                questionId: post.id ?? 0,
                                bookmarkCount: post.totalbookmark ?? 0,
                                likedCount: post.totallike ?? 0,
                                likedbyuser: post.likedByUser ?? false,
                                bookmarkedbyuser:
                                    post.bookmarkedByUser ?? false,
                                answerCount: post.totalquestionAnswer ?? 0,
                                url: post.fullUrl ?? '',
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
      floatingActionButton: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.getString(Constants.accessToken);
          Get.toNamed(Routes.addquestionanswer);
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
