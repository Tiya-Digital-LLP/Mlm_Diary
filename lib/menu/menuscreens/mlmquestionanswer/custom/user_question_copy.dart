import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_answers_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_like_list_content.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_link/text_link.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;

class UserQuestionCopy extends StatefulWidget {
  const UserQuestionCopy({super.key});

  @override
  State<UserQuestionCopy> createState() => _UserQuestionState();
}

class _UserQuestionState extends State<UserQuestionCopy> {
  final QuestionAnswerController controller =
      Get.put(QuestionAnswerController());
  dynamic post;
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  late ScrollController _scrollController;

  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;

  void initializeLikes() {
    isLiked = RxBool(controller.questionList[0].likedByUser ?? false);
    likeCount = RxInt(controller.questionList[0].totallike ?? 0);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await controller.toggleLike(post.id ?? 0, context);
  }

  void initializeBookmarks() {
    isBookmarked = RxBool(controller.questionList[0].bookmarkedByUser ?? false);
    bookmarkCount = RxInt(controller.questionList[0].totalbookmark ?? 0);
  }

  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    await controller.toggleBookMark(post.id ?? 0, context);
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
    initializeLikes();
    initializeBookmarks();
    post = Get.arguments;
    if (post != null && post.id != null) {
      controller.getAnswers(
        1,
        post.id ?? 0,
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAnswers(1, post.id!);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getQuestion(1);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.countViewQuestion(post.id ?? 0, context);
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
            return CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final currentUserID = snapshot.data ?? 0;
            bool isCurrentUserComment = comment.userId == currentUserID;

            if (kDebugMode) {
              print('Current User ID: $currentUserID');
            }
            return Column(
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

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: _buildHtmlContent(
                                      comment.ansTitle.toString(), size),
                                ),
                                8.sbw,
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildReply(
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
                              ],
                            ),
                            16.sbh,
                            if (isCurrentUserComment)
                              Row(
                                children: [
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
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color:
                                                controller.answerlikedStatusMap[
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
                                  TextButton(
                                    onPressed: () {
                                      _showEditComment(comment);
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
                                  TextButton(
                                    onPressed: () =>
                                        LogoutDialog.show(context, () async {
                                      await controller.deleteAnswers(
                                          post.id!, comment.id ?? 0, context);
                                    }),
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
                            // Comments section
                            if (comment.comments != null)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: comment.comments!.length,
                                itemBuilder: (context, index) {
                                  final commentData = comment.comments![index];
                                  return _buildCommentComment(
                                      commentData, size);
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]);
          }
        });
  }

  Widget _buildCommentComment(
      GetAnswersAnswersComments commentData, Size size) {
    return FutureBuilder<int?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final currentUserID = snapshot.data ?? 0;

            bool isCurrentUserComment = commentData.userid == currentUserID;
            if (kDebugMode) {
              print('Current User ID: $currentUserID');
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(commentData.userimage ?? ''),
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              commentData.name ?? '',
                              style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: AppColors.blackText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              postTimeFormatter
                                  .formatPostTime(commentData.createdate ?? ''),
                              style: TextStyle(
                                fontSize: size.width * 0.018,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildHtmlContent(
                                      commentData.comment.toString(), size),
                                ),
                                8.sbw,
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          _buildReplyBottomSheet(
                                        context,
                                        commentData.id!,
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
                              ],
                            ),

                            if (isCurrentUserComment)
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await controller.toggleanswerLike(
                                          commentData.id ?? 0, context);
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.018,
                                          width: size.height * 0.018,
                                          child: Icon(
                                            controller.answerlikedStatusMap[
                                                        commentData.id ?? 0] ??
                                                    false
                                                ? Icons.thumb_up_off_alt_sharp
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color:
                                                controller.answerlikedStatusMap[
                                                            commentData.id ??
                                                                0] ??
                                                        false
                                                    ? AppColors.primaryColor
                                                    : null,
                                          ),
                                        ),
                                        15.sbw,
                                        Text(
                                          controller.answerlikeCountMap[
                                                      commentData.id ?? 0]
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
                                  TextButton(
                                    onPressed: () {
                                      _showEditCommentDialog(commentData);
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
                                  TextButton(
                                    onPressed: () =>
                                        LogoutDialog.show(context, () async {
                                      await controller.deleteComment(post.id!,
                                          commentData.id ?? 0, context);
                                    }),
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

                            const SizedBox(height: 8),
                            // Replies section
                            if (commentData.replies != null)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: commentData.replies!.length,
                                itemBuilder: (context, index) {
                                  final replyData = commentData.replies![index];
                                  return _buildCommentReply(replyData, size);
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]);
          }
        });
  }

  Widget _buildCommentReply(
      GetAnswersAnswersCommentsReplies replytoreplyData, Size size) {
    return FutureBuilder<int?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final currentUserID = snapshot.data ?? 0;

            bool isCurrentUserComment =
                replytoreplyData.userid == currentUserID;
            if (kDebugMode) {
              print('Current User ID: $currentUserID');
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(replytoreplyData.userimage ?? ''),
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              replytoreplyData.name ?? '',
                              style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: AppColors.blackText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              postTimeFormatter.formatPostTime(
                                  replytoreplyData.createdate ?? ''),
                              style: TextStyle(
                                fontSize: size.width * 0.018,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildHtmlContent(
                                      replytoreplyData.comment.toString(),
                                      size),
                                ),
                                8.sbw,
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          _buildReplyBottomSheet(
                                        context,
                                        replytoreplyData.id!,
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
                              ],
                            ),
                            if (isCurrentUserComment)
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await controller.toggleanswerLike(
                                          replytoreplyData.id ?? 0, context);
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.018,
                                          width: size.height * 0.018,
                                          child: Icon(
                                            controller.answerlikedStatusMap[
                                                        replytoreplyData.id ??
                                                            0] ??
                                                    false
                                                ? Icons.thumb_up_off_alt_sharp
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color:
                                                controller.answerlikedStatusMap[
                                                            replytoreplyData
                                                                    .id ??
                                                                0] ??
                                                        false
                                                    ? AppColors.primaryColor
                                                    : null,
                                          ),
                                        ),
                                        15.sbw,
                                        Text(
                                          controller.answerlikeCountMap[
                                                      replytoreplyData.id ?? 0]
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
                                  TextButton(
                                    onPressed: () {
                                      _showEditReplyDialog(replytoreplyData);
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
                                  TextButton(
                                    onPressed: () =>
                                        LogoutDialog.show(context, () async {
                                      await controller.deleteComment(post.id!,
                                          replytoreplyData.id ?? 0, context);
                                    }),
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

                            const SizedBox(height: 8),
                            // Replies section
                            if (replytoreplyData.replies != null)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: replytoreplyData.replies!.length,
                                itemBuilder: (context, index) {
                                  final replyData =
                                      replytoreplyData.replies![index];
                                  return _buildCommentcommentReply(
                                      replyData, size);
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]);
          }
        });
  }

  Widget _buildCommentcommentReply(
      GetAnswersAnswersCommentsRepliesReplies replytoreplyData, Size size) {
    return FutureBuilder<int?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final currentUserID = snapshot.data ?? 0;
            bool isCurrentUserComment =
                replytoreplyData.userid == currentUserID;
            if (kDebugMode) {
              print('Current User ID: $currentUserID');
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(replytoreplyData.userimage ?? ''),
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              replytoreplyData.name ?? '',
                              style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: AppColors.blackText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              postTimeFormatter.formatPostTime(
                                  replytoreplyData.createdate ?? ''),
                              style: TextStyle(
                                fontSize: size.width * 0.018,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildHtmlContent(
                                      replytoreplyData.comment.toString(),
                                      size),
                                ),
                                8.sbw,
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          _buildReplyBottomSheet(
                                        context,
                                        replytoreplyData.id!,
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
                              ],
                            ),
                            if (isCurrentUserComment)
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await controller.toggleanswerLike(
                                          replytoreplyData.id ?? 0, context);
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.018,
                                          width: size.height * 0.018,
                                          child: Icon(
                                            controller.answerlikedStatusMap[
                                                        replytoreplyData.id ??
                                                            0] ??
                                                    false
                                                ? Icons.thumb_up_off_alt_sharp
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color:
                                                controller.answerlikedStatusMap[
                                                            replytoreplyData
                                                                    .id ??
                                                                0] ??
                                                        false
                                                    ? AppColors.primaryColor
                                                    : null,
                                          ),
                                        ),
                                        15.sbw,
                                        Text(
                                          controller.answerlikeCountMap[
                                                      replytoreplyData.id ?? 0]
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
                                  TextButton(
                                    onPressed: () {
                                      _showEditReplytoReplyDialog(
                                          replytoreplyData);
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
                                  TextButton(
                                    onPressed: () =>
                                        LogoutDialog.show(context, () async {
                                      await controller.deleteComment(post.id!,
                                          replytoreplyData.id ?? 0, context);
                                    }),
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
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]);
          }
        });
  }

  void _showEditComment(GetAnswersAnswers answers) {
    _showEditAnswerDialog(answers, false);
  }

  void _showEditCommentDialog(GetAnswersAnswersComments comment) {
    _showEditDialog(comment, false);
  }

  void _showEditReplyDialog(GetAnswersAnswersCommentsReplies reply) {
    _showEditDialog(reply, true);
  }

  void _showEditReplytoReplyDialog(
      GetAnswersAnswersCommentsRepliesReplies reply) {
    _showEditDialog(reply, true);
  }

  Widget _buildReplyBottomSheet(
    BuildContext context,
    int commentId,
    Size size,
  ) {
    return Container(
      height: 200,
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
                                post.id!, commentId, context);
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

  Widget _buildReply(
    BuildContext context,
    int commentId,
    Size size,
  ) {
    return Container(
      height: 200,
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

                            await controller.addReplyAnswer(
                              commentId,
                              context,
                            );
                            if (kDebugMode) {
                              print('answerid: $commentId');
                            }
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
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.searchbar,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
              ),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  String editedComment = editController.text;
                  Navigator.of(context).pop();
                  if (isReply) {
                    await controller.editComment(post.id!, data.id ?? 0,
                        editedComment, 'answer', context);
                  } else {
                    await controller.editComment(post.id!, data.id ?? 0,
                        editedComment, 'answer', context);
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

  void _showEditAnswerDialog(dynamic data, bool isReply) {
    final TextEditingController editController =
        TextEditingController(text: data.ansTitle ?? '');

    editController.addListener(() {
      // Update Rx controller with the latest value
      controller.commment.value.text = editController.text;
    });

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.searchbar,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
              ),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  String editedComment = editController.text;
                  Navigator.of(context).pop();
                  if (isReply) {
                    await controller.editAnswer(
                        post.id!, data.id ?? 0, editedComment, context);
                  } else {
                    await controller.editAnswer(
                        post.id!, data.id ?? 0, editedComment, context);
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
                        if (post.userData!.imagePath.isNotEmpty &&
                            Uri.tryParse(post.userData!.imagePath)
                                    ?.hasAbsolutePath ==
                                true)
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: post.userData!.imagePath ?? '',
                              height: 60.0,
                              width: 60.0,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CustomLottieAnimation(
                                child: Lottie.asset(
                                  Assets.lottieLottie,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
                                  // Text(
                                  //   postTimeFormatter
                                  //       .formatPostTime(post.creatdate ?? ''),
                                  //   style: textStyleW400(size.width * 0.028,
                                  //       AppColors.blackText.withOpacity(0.8)),
                                  // ),
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
                                  Obx(
                                    () => SizedBox(
                                      height: size.height * 0.028,
                                      width: size.height * 0.028,
                                      child: GestureDetector(
                                        onTap: toggleLike,
                                        child: Icon(
                                          // Observe like status
                                          isLiked.value
                                              ? Icons.thumb_up_off_alt_sharp
                                              : Icons.thumb_up_off_alt_outlined,
                                          color: isLiked.value
                                              ? AppColors.primaryColor
                                              : null,
                                          size: size.height * 0.032,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  // ignore: unrelated_type_equality_checks
                                  likeCount.value == 0
                                      ? const SizedBox.shrink()
                                      : InkWell(
                                          onTap: () {
                                            showLikeList(context);
                                          },
                                          child: Text(
                                            '${likeCount.value}',
                                            style: textStyleW600(
                                                size.width * 0.038,
                                                AppColors.blackText),
                                          ),
                                        ),
                                  const SizedBox(
                                    width: 15,
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
                            Obx(
                              () => SizedBox(
                                height: size.height * 0.028,
                                width: size.height * 0.028,
                                child: GestureDetector(
                                  onTap: () => toggleBookmark(),
                                  child: SvgPicture.asset(
                                    isBookmarked.value
                                        ? Assets.svgCheckBookmark
                                        : Assets.svgSavePost,
                                    height: size.height * 0.032,
                                  ),
                                ),
                              ),
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
                      'Answer',
                      style: textStyleW700(
                          size.width * 0.038, AppColors.blackText),
                    ),
                  ),
                  10.sbh,
                  Obx(() {
                    if (controller.isLoading.value &&
                        controller.answerList.isEmpty) {
                      return Center(
                          child: CustomLottieAnimation(
                        child: Lottie.asset(
                          Assets.lottieLottie,
                        ),
                      ));
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
                              ],
                            ),
                          );
                        } else {
                          return Center(
                              child: CustomLottieAnimation(
                            child: Lottie.asset(
                              Assets.lottieLottie,
                            ),
                          ));
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
                                        controller.addAnswers(
                                            post.id ?? 0, context);
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

  void showLikeList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Fetch like list after bottom sheet is shown
        fetchLikeList();
        return const QuestionLikeListContent();
      },
    );
  }

  void fetchLikeList() async {
    await controller.fetchLikeListQuestion(post.id ?? 0, context);
  }
}
