import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/customfilter/custom_filter.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class QuationAnswer extends StatefulWidget {
  const QuationAnswer({super.key});

  @override
  State<QuationAnswer> createState() => _QuationAnswerState();
}

class _QuationAnswerState extends State<QuationAnswer> {
  final _search = TextEditingController();
  final QuestionAnswerController controller =
      Get.put(QuestionAnswerController());

  @override
  void initState() {
    super.initState();
    controller.getQuestion(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Question Answer',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchInput(
                    controller: _search,
                    onSubmitted: (value) {
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();

                      setState(() {});
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        WidgetsBinding.instance.focusManager.primaryFocus;

                        setState(() {});
                      }
                    },
                  ),
                ),
                5.sbw,
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const BottomSheetContent();
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
              if (controller.isLoading.value &&
                  controller.questionList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.questionList.isEmpty) {
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
                padding: EdgeInsets.zero,
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.questionList.length +
                    (controller.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.questionList.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = controller.questionList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.userquestion,
                          arguments: controller.questionList[index],
                        );
                      },
                      child: QuestionCard(
                        userImage: post.userData!.imagePath ?? '',
                        userName: post.userData!.name ?? '',
                        postCaption: post.title ?? '',
                        viewcounts: post.pgcnt ?? 0,
                        dateTime: post.creatdate ?? '',
                        controller: controller,
                        questionId: post.id ?? 0,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
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
