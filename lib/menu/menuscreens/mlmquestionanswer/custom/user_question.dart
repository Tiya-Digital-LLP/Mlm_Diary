import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_question_list_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';

class UserQuestion extends StatefulWidget {
  const UserQuestion({super.key});

  @override
  State<UserQuestion> createState() => _UserQuestionState();
}

class _UserQuestionState extends State<UserQuestion> {
  final QuestionAnswerController controller =
      Get.put(QuestionAnswerController());
  final post = Get.arguments as GetQuestionListQuestions;
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAnswers(1, post.id ?? 0);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getQuestion(1);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.countViewQuestion(post.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Question',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0XFFCCC9C9),
                          radius: size.width * 0.07,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: post.userData!.imagePath ?? '',
                              height: 97,
                              width: 105,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        10.sbw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.userData!.name ?? '',
                                style: textStyleW700(
                                    size.width * 0.036, AppColors.blackText),
                              ),
                              Row(
                                children: [
                                  Text(
                                    postTimeFormatter
                                        .formatPostTime(post.creatdate ?? ''),
                                    style: textStyleW400(size.width * 0.028,
                                        AppColors.blackText.withOpacity(0.8)),
                                  ),
                                  8.sbw,
                                  Text(
                                    'asked a question',
                                    style: textStyleW400(size.width * 0.032,
                                        AppColors.blackText.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.sbh,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            post.title ?? '',
                            style: textStyleW700(
                                size.width * 0.035, AppColors.blackText),
                          ),
                        )
                      ],
                    ),
                  ),
                  20.sbh,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.028,
                                    width: size.height * 0.028,
                                    child: SvgPicture.asset(Assets.svgLike),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "50k",
                                    style: TextStyle(
                                        fontFamily: "Metropolis",
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.045),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgReply),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "12",
                              style: TextStyle(
                                  fontFamily: "Metropolis",
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.045),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgView),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              post.pgcnt.toString(),
                              style: TextStyle(
                                  fontFamily: "Metropolis",
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.045),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgSavePost),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgSend),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  20.sbh,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.white,
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.5))),
                    ),
                  ),
                  20.sbh,
                ],
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'Answer (${post.totalquestionAnswer.toString()})',
                        style: textStyleW700(
                            size.width * 0.038, AppColors.blackText),
                      ),
                    ],
                  )
                ],
              ),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.answerList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.answerList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No answers found',
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.answerList.length,
                  itemBuilder: (context, index) {
                    final answer = controller.answerList[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0XFFCCC9C9),
                            radius: size.width * 0.07,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: answer.userData!.imagePath ?? '',
                                height: 97,
                                width: 105,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          10.sbw,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      answer.userData!.name ?? '',
                                      style: textStyleW700(size.width * 0.036,
                                          AppColors.blackText),
                                    ),
                                    8.sbw,
                                    Text(
                                      postTimeFormatter.formatPostTime(
                                          answer.createdate ?? ''),
                                      style: textStyleW400(size.width * 0.032,
                                          AppColors.blackText.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                Html(
                                  data: answer.ansTitle ?? '',
                                  style: {
                                    "html": Style(),
                                  },
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await controller.toggleanswerLike(
                                            answer.id ?? 0, context);
                                        setState(() {});
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.018,
                                            width: size.height * 0.018,
                                            child: Icon(
                                              controller.answerlikedStatusMap[
                                                          answer.id ?? 0] ??
                                                      false
                                                  ? Icons.thumb_up_off_alt_sharp
                                                  : Icons
                                                      .thumb_up_off_alt_outlined,
                                              color:
                                                  controller.answerlikedStatusMap[
                                                              answer.id ?? 0] ??
                                                          false
                                                      ? AppColors.primaryColor
                                                      : null,
                                            ),
                                          ),
                                          15.sbw,
                                          Text(
                                            controller.answerlikeCountMap[
                                                        answer.id ?? 0]
                                                    ?.toString() ??
                                                '0',
                                            style: TextStyle(
                                                fontFamily: "Metropolis",
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.width * 0.035),
                                          )
                                        ],
                                      ),
                                    ),
                                    18.sbw,
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Reply',
                                        style: TextStyle(
                                            fontFamily: "Metropolis",
                                            fontWeight: FontWeight.w600,
                                            fontSize: size.width * 0.035,
                                            color: AppColors.blackText
                                                .withOpacity(0.7)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        color: AppColors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.searchbar,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  maxLines: 5,
                                  controller: controller.answer.value,
                                  decoration: const InputDecoration(
                                    hintText: 'Write your answer here',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                  boxShadow: [
                                    customBoxShadow(),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    final String answerText =
                                        controller.answer.value.text;
                                    if (answerText.isNotEmpty) {
                                      controller.answerValidation(context);
                                      if (!controller.answerError.value) {
                                        controller.addAnswers(post.id ?? 0);
                                      }
                                    }
                                  },
                                  child: const Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
