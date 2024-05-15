import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/modal_class/manage_quation_class.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';

class Question extends StatefulWidget {
  final ManageQuation post;
  const Question({super.key, required this.post});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  TextEditingController replyController = TextEditingController();
  RxString replyText = ''.obs;
  RxBool showReply = false.obs;
  List<String> replies = [];

  @override
  void dispose() {
    replyController.dispose();
    super.dispose();
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
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          width: 41,
                          height: 41,
                          widget.post.userImage,
                          fit: BoxFit.fill,
                        ),
                        10.sbw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.post.userName,
                                    style: textStyleW700(size.width * 0.036,
                                        AppColors.blackText),
                                  ),
                                  8.sbw,
                                  Text(
                                    'asked a question',
                                    style: textStyleW400(size.width * 0.032,
                                        AppColors.blackText.withOpacity(0.8)),
                                  )
                                ],
                              ),
                              Text(
                                '2 minutes',
                                style: textStyleW400(size.width * 0.028,
                                    AppColors.blackText.withOpacity(0.8)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          widget.post.postCaption,
                          style: textStyleW400(size.width * 0.035,
                              AppColors.blackText.withOpacity(0.8)),
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
                              "286",
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
                        'Answers (12)',
                        style: textStyleW700(
                            size.width * 0.038, AppColors.blackText),
                      ),
                    ],
                  )
                ],
              ),
              // Inside the Column widget where you display replies
              Column(
                children: replies.map((reply) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display user image, name, and time here
                        Image.asset(
                          width: 41,
                          height: 41,
                          widget.post.userImage,
                          fit: BoxFit.fill,
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
                                    'John Doe',
                                    style: textStyleW700(size.width * 0.036,
                                        AppColors.blackText),
                                  ),
                                  8.sbw,
                                  Text(
                                    '2 minutes',
                                    style: textStyleW400(size.width * 0.032,
                                        AppColors.blackText.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                              Text(
                                reply,
                                style: textStyleW400(size.width * 0.035,
                                    AppColors.blackText.withOpacity(0.8)),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.018,
                                    width: size.height * 0.018,
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
                                        fontSize: size.width * 0.035),
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
                }).toList(),
              )
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
                                  controller: replyController,
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
                                    // Check if the reply text is not empty
                                    if (replyController.text.isNotEmpty) {
                                      // Update the reply text and toggle the visibility
                                      setState(() {
                                        replies.add(replyController.text);
                                        replyText.value = replyController.text;
                                        showReply.value = !showReply.value;
                                      });

                                      // Clear the text field
                                      replyController.clear();
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
