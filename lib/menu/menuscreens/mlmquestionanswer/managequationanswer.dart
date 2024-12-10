import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/manage_quation_answer_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_question.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class ManageQuationAnswer extends StatefulWidget {
  const ManageQuationAnswer({super.key});

  @override
  State<ManageQuationAnswer> createState() => _ManageQuationAnswerState();
}

class _ManageQuationAnswerState extends State<ManageQuationAnswer> {
  final QuestionAnswerController controller =
      Get.put(QuestionAnswerController());
  final RxBool showShimmer = true.obs;

  @override
  void initState() {
    super.initState();
    // Start a timer to switch from shimmer to UI after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      showShimmer.value = false;
    });
    _refreshData();
  }

  Future<void> _refreshData() async {
    await controller.fetchMyQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage Question Answer',
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (showShimmer.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const CustomShimmerQuestion(
                            width: 175, height: 240);
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value &&
                          controller.myquestionList.isEmpty) {
                        return Center(
                            child: CustomLottieAnimation(
                          child: Lottie.asset(
                            Assets.lottieLottie,
                          ),
                        ));
                      }

                      if (controller.myquestionList.isEmpty) {
                        return Center(
                          child: Text(
                            controller.isLoading.value
                                ? 'Loading...'
                                : 'Data not found',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.myquestionList.length,
                        itemBuilder: (context, index) {
                          final post = controller.myquestionList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.question,
                                  arguments: controller.myquestionList[index],
                                );
                              },
                              child: ManageQuestionCard(
                                  userImage: post.userData!.imagePath ?? '',
                                  userName: post.userData!.name ?? '',
                                  postCaption: post.title ?? '',
                                  viewcounts: post.pgcnt ?? 0,
                                  dateTime: post.creatdate ?? '',
                                  controller: controller,
                                  questionId: post.id ?? 0,
                                  bookmarkCount: post.totalbookmark ?? 0,
                                  likedCount: post.totallike ?? 0,
                                  totalreply: post.totalquestionAnswer ?? 0),
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
