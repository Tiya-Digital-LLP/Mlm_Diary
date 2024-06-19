import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_answers_entity.dart';
import 'package:mlmdiary/generated/get_question_list_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_link/text_link.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;

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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _refreshData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAnswers(1, post.id!);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getQuestion(1);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.countViewQuestion(post.id ?? 0);
    });
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !controller.isEndOfData.value) {
      int nextPage = (controller.answerList.length ~/ 10) + 1;
      controller.getAnswers(nextPage, post.id!);
    }
  }

  Future<void> _refreshData() async {
    controller.getAnswers(1, post.id ?? 0);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Constants.userId);
  }

  Widget _buildComment(GetAnswersAnswers comment, Size size) {
    return FutureBuilder<int?>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final currentUserID = snapshot.data ?? 0;

          bool isCurrentUserComment = comment.userId == currentUserID;
          if (kDebugMode) {
            print('Current User ID: $currentUserID');
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(comment.userimage ?? ''),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.name ?? '',
                            style: TextStyle(
                              fontSize: size.width * 0.043,
                              color: AppColors.blackText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            postTimeFormatter
                                .formatPostTime(comment.createdate ?? ''),
                            style: TextStyle(
                              fontSize: size.width * 0.022,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          _buildHtmlContent(comment.ansTitle.toString(), size),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        _buildReplyBottomSheet(
                                      context,
                                      comment.id!,
                                      size,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Reply',
                                  style: TextStyle(
                                    fontSize: size.width * 0.028,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              10.sbw,
                              GestureDetector(
                                onTap: () async {
                                  await controller.toggleanswerLike(
                                      comment.id ?? 0, context);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.018,
                                      width: size.height * 0.018,
                                      child: Icon(
                                        controller.answerlikedStatusMap[
                                                    comment.id ?? 0] ??
                                                false
                                            ? Icons.thumb_up_off_alt_sharp
                                            : Icons.thumb_up_off_alt_outlined,
                                        color: controller.answerlikedStatusMap[
                                                    comment.id ?? 0] ??
                                                false
                                            ? AppColors.primaryColor
                                            : null,
                                      ),
                                    ),
                                    15.sbw,
                                    Text(
                                      controller.answerlikeCountMap[
                                                  comment.id ?? 0]
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
                              if (isCurrentUserComment)
                                TextButton(
                                  onPressed: () {
                                    _showEditCommentDialog(comment);
                                  },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: size.width * 0.028,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              if (isCurrentUserComment)
                                TextButton(
                                  onPressed: () => _showDeleteConfirmation(
                                    context,
                                    comment.id ?? 0,
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: size.width * 0.028,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildHtmlContent(String htmlContent, Size size) {
    final parsedHtml = htmlParser.parse(htmlContent);
    final text = parsedHtml.body?.text ?? '';

    return LinkText(
      text: text,
      style: textStyleW400(
        size.width * 0.028,
        AppColors.blackText.withOpacity(0.8),
      ),
      linkStyle: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _buildReplyBottomSheet(
    BuildContext context,
    int commentId,
    Size size,
  ) {
    return Container(
      height: 100,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
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
                    horizontal: 16.0,
                    vertical: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: controller.commment.value,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Write your answer here',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (controller.commment.value.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Please enter your reply",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                              );
                              return;
                            }

                            await controller.addReplyAnswerComment(
                              post.id!,
                              commentId,
                            );
                            controller.commment.value.clear();
                            Get.back();
                          },
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
    );
  }

  Widget _buildSingleReply(
    GetAnswersAnswersComments reply,
    Size size,
  ) {
    return FutureBuilder<int?>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final currentUserID = snapshot.data ?? 0;
          bool isCurrentUserReply = reply.userid == currentUserID;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(reply.userimage ?? ''),
                  radius: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reply.name ?? '',
                        style: TextStyle(
                          fontSize: size.width * 0.035,
                          color: AppColors.blackText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        postTimeFormatter
                            .formatPostTime(reply.createdate ?? ''),
                        style: TextStyle(
                          fontSize: size.width * 0.022,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      4.sbh,
                      Align(
                        alignment: Alignment.topLeft,
                        child: _buildHtmlContent(reply.comment ?? '', size),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => _buildReplyBottomSheet(
                                context,
                                reply.id!,
                                size,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'Reply',
                                style: TextStyle(
                                  fontSize: size.width * 0.028,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              10.sbw,
                              GestureDetector(
                                onTap: () async {
                                  await controller.toggleanswerLike(
                                      reply.id ?? 0, context);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.018,
                                      width: size.height * 0.018,
                                      child: Icon(
                                        controller.answerlikedStatusMap[
                                                    reply.id ?? 0] ??
                                                false
                                            ? Icons.thumb_up_off_alt_sharp
                                            : Icons.thumb_up_off_alt_outlined,
                                        color: controller.answerlikedStatusMap[
                                                    reply.id ?? 0] ??
                                                false
                                            ? AppColors.primaryColor
                                            : null,
                                      ),
                                    ),
                                    15.sbw,
                                    Text(
                                      controller
                                              .answerlikeCountMap[reply.id ?? 0]
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
                              if (isCurrentUserReply)
                                TextButton(
                                  onPressed: () {
                                    _showEditReplyDialog(reply);
                                  },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: size.width * 0.028,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              if (isCurrentUserReply)
                                TextButton(
                                  onPressed: () => _showDeleteConfirmation(
                                      context, reply.id ?? 0),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: size.width * 0.028,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, int commentId) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Comment?'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
              await controller.deleteComment(post.id!, commentId);
              await _refreshData();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed) {
      // Comment deleted, refresh data if needed
      await _refreshData();
    }
  }

  // Example usage:
  void _showEditCommentDialog(GetAnswersAnswers comment) {
    _showEditDialog(comment, false);
  }

  void _showEditReplyDialog(GetAnswersAnswersComments reply) {
    _showEditDialog(reply, true);
  }

  void _showEditReplytoReplyDialog(GetAnswersAnswersCommentsReplies reply) {
    _showEditDialog(reply, true);
  }

  void _showEditDialog(dynamic data, bool isReply) {
    final TextEditingController editController =
        TextEditingController(text: data.comment ?? '');

    editController.addListener(() {
      // Update Rx controller with the latest value
      controller.commment.value.text = editController.text;
    });

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.searchbar,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: editController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Edit your comment here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String editedComment = editController.text;
                  Navigator.of(context).pop();
                  if (isReply) {
                    await controller.editComment(
                      post.id!,
                      data.id ?? 0,
                      editedComment,
                      'ansewer',
                    );
                  } else {
                    await controller.editComment(
                      post.id!,
                      data.id ?? 0,
                      editedComment,
                      'ansewer',
                    );
                  }
                  await _refreshData();
                },
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
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNestedReply(
    GetAnswersAnswersCommentsReplies reply,
    Size size,
  ) {
    return FutureBuilder<int?>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final currentUserID = snapshot.data ?? 0;
          bool isCurrentUserReply = reply.userid == currentUserID;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Adjust layout as needed for nested replies
                CircleAvatar(
                  backgroundImage: NetworkImage(reply.userimage ?? ''),
                  radius: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reply.name ?? '',
                        style: TextStyle(
                          fontSize: size.width * 0.035,
                          color: AppColors.blackText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        postTimeFormatter
                            .formatPostTime(reply.createdate ?? ''),
                        style: TextStyle(
                          fontSize: size.width * 0.022,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      4.sbh,
                      Align(
                        alignment: Alignment.topLeft,
                        child: _buildHtmlContent(reply.comment ?? '', size),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => _buildReplyBottomSheet(
                                context,
                                reply.id!,
                                size,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'Reply',
                                style: TextStyle(
                                  fontSize: size.width * 0.028,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              10.sbw,
                              GestureDetector(
                                onTap: () async {
                                  await controller.toggleanswerLike(
                                      reply.id ?? 0, context);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.018,
                                      width: size.height * 0.018,
                                      child: Icon(
                                        controller.answerlikedStatusMap[
                                                    reply.id ?? 0] ??
                                                false
                                            ? Icons.thumb_up_off_alt_sharp
                                            : Icons.thumb_up_off_alt_outlined,
                                        color: controller.answerlikedStatusMap[
                                                    reply.id ?? 0] ??
                                                false
                                            ? AppColors.primaryColor
                                            : null,
                                      ),
                                    ),
                                    15.sbw,
                                    Text(
                                      controller
                                              .answerlikeCountMap[reply.id ?? 0]
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
                              if (isCurrentUserReply)
                                TextButton(
                                  onPressed: () {
                                    _showEditReplytoReplyDialog(reply);
                                  },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: size.width * 0.028,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              if (isCurrentUserReply)
                                TextButton(
                                  onPressed: () => _showDeleteConfirmation(
                                      context, reply.id ?? 0),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: size.width * 0.028,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
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
                        ),
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
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.028,
                                    width: size.height * 0.028,
                                    child: SvgPicture.asset(Assets.svgLike),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    "50k",
                                    style: TextStyle(
                                      fontFamily: "Metropolis",
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgReply),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              "12",
                              style: TextStyle(
                                fontFamily: "Metropolis",
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.045,
                              ),
                            ),
                            const SizedBox(width: 15),
                            SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgView),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              post.pgcnt.toString(),
                              style: TextStyle(
                                fontFamily: "Metropolis",
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.045,
                              ),
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
                            const SizedBox(width: 10),
                            SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgSend),
                            ),
                            const SizedBox(width: 10),
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
                      border: const Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  20.sbh,
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Answer (${post.totalquestionAnswer.toString()})',
                      style: textStyleW700(
                          size.width * 0.038, AppColors.blackText),
                    ),
                  ),
                  10.sbh,
                  Obx(() {
                    if (controller.isLoading.value &&
                        controller.answerList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      itemCount: controller.answerList.length +
                          (controller.isLoading.value ? 1 : 0),
                      controller: _scrollController,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index < controller.answerList.length) {
                          final comment = controller.answerList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildComment(comment, size),
                                if (comment.comments != null &&
                                    comment.comments!.isNotEmpty)
                                  Column(
                                    children: comment.comments!.map((reply) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32, top: 8),
                                            child:
                                                _buildSingleReply(reply, size),
                                          ),
                                          if (reply.replies != null &&
                                              reply.replies!.isNotEmpty)
                                            Column(
                                              children: reply.replies!
                                                  .map((replyToReply) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 48, top: 8),
                                                  child: _buildNestedReply(
                                                      replyToReply, size),
                                                );
                                              }).toList(),
                                            ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  }),
                ],
              ),
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
