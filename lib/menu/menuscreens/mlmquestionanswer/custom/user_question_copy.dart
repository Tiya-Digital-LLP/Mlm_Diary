import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/custom/input_widget.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_answers_entity.dart';
import 'package:mlmdiary/generated/get_question_list_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_view_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_link/text_link.dart';

class UserQuestionCopy extends StatefulWidget {
  const UserQuestionCopy({super.key});

  @override
  State<UserQuestionCopy> createState() => _UserQuestionState();
}

class _UserQuestionState extends State<UserQuestionCopy>
    with SingleTickerProviderStateMixin {
  final QuestionAnswerController controller =
      Get.put(QuestionAnswerController());
  dynamic post;
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  late ScrollController _scrollController;
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;
  static const int maxCharacters = 500;

  final FocusNode _focusNode = FocusNode();

  final PageController _pageController = PageController();
  int currentPage = 0;

  bool isLimitExceeded = false;
  int? currentUserID;
  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    await controller.toggleBookMark(post.id ?? 0, context);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await controller.toggleLike(post.id ?? 0, context);
  }

  late TabController _tabController;

  void _openKeyboard(
      {bool isEditing = false,
      int? commentId,
      String? existingText,
      String? username}) {
    controller.commment.value.text = existingText ?? '';

    if (isEditing) {
      controller.editingCommentId.value = commentId ?? 0;
      controller.replyCommentId.value = 0;
    } else {
      controller.replyCommentId.value = commentId ?? 0;
      controller.editingCommentId.value = 0;
    }

    controller.hintText.value =
        username != null ? '@$username' : 'Write your answer here';

    FocusScope.of(context).requestFocus(_focusNode);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Constants.userId);
  }

  Future<void> _getUserId() async {
    currentUserID = await getUserId();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getUserId();
    _refreshData();

    final arguments = Get.arguments as Map<String, dynamic>?;
    initializeLikes();
    initializeBookmarks();
    if (arguments != null) {
      post = GetQuestionListQuestions.fromJson(arguments);
      if (post != null) {
        final int postId = post!.id ?? 0;
        if (postId != 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.getAnswers(1, post.id!);
            controller.getQuestion(1);

            controller.countViewQuestion(post.id ?? 0, context);
          });
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.getAnswers(1, post.id!);
          controller.getQuestion(1);

          controller.countViewQuestion(post.id ?? 0, context);
        });
      }
    }

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void initializeLikes() {
    if (controller.questionList.isNotEmpty) {
      isLiked = RxBool(controller.questionList[0].likedByUser ?? false);
      likeCount = RxInt(controller.questionList[0].totallike ?? 0);
    } else {
      isLiked = RxBool(false);
      likeCount = RxInt(0);
    }
  }

  void initializeBookmarks() {
    if (controller.questionList.isNotEmpty) {
      isBookmarked =
          RxBool(controller.questionList[0].bookmarkedByUser ?? false);
    } else {
      isBookmarked = RxBool(false);
    }
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

  Widget _buildComment(GetAnswersAnswers comment, Size size) {
    currentUserID = currentUserID ?? 0;

    bool isCurrentNewsUserComment = comment.userId == currentUserID;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  Get.toNamed(Routes.userprofilescreen, arguments: {
                    'user_id': comment.userId ?? 0,
                  });
                  await userProfileController.fetchUserAllPost(
                    1,
                    comment.userId.toString(),
                  );
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: comment.userimage ?? Assets.imagesAdminlogo,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.imagesAdminlogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                    _buildHtmlContent(comment.ansTitle ?? '', size),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _openKeyboard(
                            isEditing: false,
                            commentId: comment.id,
                            username: comment.name,
                          ),
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
                                controller.answerlikeCountMap[comment.id ?? 0]
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
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () {
                              _openKeyboard(
                                isEditing: true,
                                commentId: comment.id,
                                existingText: comment.ansTitle,
                              );
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
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              await controller.deleteComment(
                                  post.id ?? 0, comment.id ?? 0, context);
                              await _refreshData();
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHtmlContent(String htmlContent, Size size) {
    final parsedHtml = htmlParser.parse(htmlContent);
    final text = parsedHtml.body?.text ?? '';

    return LinkText(
      text: text,
      style: textStyleW400(
        size.width * 0.028,
        // ignore: deprecated_member_use
        AppColors.blackText.withOpacity(0.8),
      ),
      linkStyle: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _buildSingleReply(
    GetAnswersAnswersComments comment,
    Size size,
  ) {
    currentUserID = currentUserID ?? 0;

    bool isCurrentNewsUserComment = comment.userid == currentUserID;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  Get.toNamed(Routes.userprofilescreen, arguments: {
                    'user_id': comment.userid ?? 0,
                  });
                  await userProfileController.fetchUserAllPost(
                    1,
                    comment.userid.toString(),
                  );
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: comment.userimage ?? Assets.imagesAdminlogo,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.imagesAdminlogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                    _buildHtmlContent(comment.comment ?? '', size),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _openKeyboard(
                            isEditing: false,
                            commentId: comment.id,
                            username: comment.name,
                          ),
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
                                controller.answerlikeCountMap[comment.id ?? 0]
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
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () {
                              _openKeyboard(
                                isEditing: true,
                                commentId: comment.id,
                                existingText: comment.comment,
                              );
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
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              await controller.deleteComment(
                                  post.id ?? 0, comment.id ?? 0, context);
                              await _refreshData();
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNestedReply(
    GetAnswersAnswersCommentsReplies comment,
    Size size,
  ) {
    currentUserID = currentUserID ?? 0;

    bool isCurrentNewsUserComment = comment.userid == currentUserID;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  Get.toNamed(Routes.userprofilescreen, arguments: {
                    'user_id': comment.userid ?? 0,
                  });
                  await userProfileController.fetchUserAllPost(
                    1,
                    comment.userid.toString(),
                  );
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: comment.userimage ?? Assets.imagesAdminlogo,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.imagesAdminlogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                    _buildHtmlContent(comment.comment ?? '', size),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _openKeyboard(
                            isEditing: false,
                            commentId: comment.id,
                            username: comment.name,
                          ),
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
                                controller.answerlikeCountMap[comment.id ?? 0]
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
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () {
                              _openKeyboard(
                                isEditing: true,
                                commentId: comment.id,
                                existingText: comment.comment,
                              );
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
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              await controller.deleteComment(
                                  post.id ?? 0, comment.id ?? 0, context);
                              await _refreshData();
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Question',
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: controller.questionList.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });

          if (kDebugMode) {
            print("Page changed to: $index");
          }
          if (index >= 0 && index < controller.questionList.length) {
            post = controller.questionList[index];
            if (kDebugMode) {
              print("Selected post: ${post.id}");
            }
            controller.getQuestion(post.id ?? 0);
            controller.getAnswers(1, post.id!);
            controller.countViewQuestion(post.id ?? 0, context);
          }
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    Get.toNamed(
                      Routes.userprofilescreen,
                      arguments: {
                        'user_id': post.userId,
                      },
                    );
                    await userProfileController.fetchUserAllPost(
                      1,
                      post.userId.toString(),
                    );
                  },
                  child: Padding(
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
                                  // Text(
                                  //   postTimeFormatter
                                  //       .formatPostTime(post.creatdate ?? ''),
                                  //   style: textStyleW400(size.width * 0.028,
                                  //       AppColors.blackText.withOpacity(0.8)),
                                  // ),
                                  8.sbw,
                                  Text(
                                    'asked a question',
                                    style: textStyleW400(
                                        size.width * 0.032,
                                        // ignore: deprecated_member_use
                                        AppColors.blackText
                                            // ignore: deprecated_member_use
                                            .withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                          Row(
                            children: [
                              Obx(
                                () => SizedBox(
                                  height: size.height * 0.028,
                                  width: size.height * 0.028,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.toggleLike(post.id, context);
                                    },
                                    child: Icon(
                                      controller.likedStatusMap[post.id] == true
                                          ? Icons.thumb_up
                                          : Icons.thumb_up_off_alt_outlined,
                                      color:
                                          controller.likedStatusMap[post.id] ==
                                                  true
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
                              Obx(() {
                                int totalLikes = post.totallike +
                                    (controller.likeCountMap[post.id] ?? 0);

                                return InkWell(
                                  onTap: () {
                                    showLikeAndViewList(context, 0);
                                  },
                                  child: Text(
                                    totalLikes.toString(),
                                    style: textStyleW600(size.width * 0.038,
                                        AppColors.blackText),
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(width: 15),
                          SizedBox(
                            height: size.height * 0.028,
                            width: size.height * 0.028,
                            child: SvgPicture.asset(Assets.svgReply),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            post.totalquestionAnswer.toString(),
                            style: TextStyle(
                              fontFamily: "Metropolis",
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              showLikeAndViewList(context, 1);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: size.height * 0.028,
                                  width: size.height * 0.028,
                                  child: SvgPicture.asset(Assets.svgView),
                                ),
                                6.sbw,
                                post.pgcnt == 0
                                    ? const SizedBox.shrink()
                                    : InkWell(
                                        onTap: () {
                                          showLikeAndViewList(context, 1);
                                        },
                                        child: Text(
                                          '${post.pgcnt}',
                                          style: TextStyle(
                                            fontFamily: "Metropolis",
                                            fontWeight: FontWeight.w600,
                                            fontSize: size.width * 0.038,
                                          ),
                                        ),
                                      ),
                              ],
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
                          InkWell(
                            onTap: () async {
                              try {
                                final dynamicLink = await createDynamicLink(
                                  post.fullUrl,
                                  'Question',
                                  post.id.toString(),
                                );

                                debugPrint(
                                    'Generated Dynamic Link: $dynamicLink');
                                await Share.share(dynamicLink);
                              } catch (e) {
                                debugPrint('Error sharing link: $e');
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Error creating or sharing link: $e")),
                                );
                              }
                            },
                            child: SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(
                                Assets.svgSend,
                                // ignore: deprecated_member_use
                                color: AppColors.blackText,
                              ),
                            ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Answer(${post.totalquestionAnswer})',
                      style: textStyleW700(
                          size.width * 0.038, AppColors.blackText),
                    ),
                  ),
                ),
                10.sbh,
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(
                        () {
                          if (controller.isLoading.value &&
                              controller.answerList.isEmpty) {
                            return const SizedBox();
                          }
                          if (controller.answerList.isEmpty) {
                            return Center(
                              child: Text(
                                'No Answers Found',
                                style: textStyleW700(
                                    size.width * 0.030, AppColors.blackText),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: controller.answerList.length +
                                (controller.isLoading.value ? 1 : 0),
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              if (index < controller.answerList.length) {
                                final comment = controller.answerList[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildComment(comment, size),
                                      if (comment.comments != null &&
                                          comment.comments!.isNotEmpty)
                                        Column(
                                          children:
                                              comment.comments!.map((reply) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 32, top: 8),
                                                  child: _buildSingleReply(
                                                      reply, size),
                                                ),
                                                if (reply.replies != null &&
                                                    reply.replies!.isNotEmpty)
                                                  Column(
                                                    children: reply.replies!
                                                        .map((replyToReply) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 48,
                                                                top: 8),
                                                        child:
                                                            _buildNestedReply(
                                                                replyToReply,
                                                                size),
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
                                return Center(
                                    child: CustomLottieAnimation(
                                  child: Lottie.asset(
                                    Assets.lottieLottie,
                                  ),
                                ));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                CommentInputWidget(
                  maxCharacters: maxCharacters,
                  textController: controller.commment.value,
                  onSend: () async {
                    if (controller.commment.value.text.isEmpty) {
                      showToasterrorborder('Please enter your reply', context);
                      return;
                    }

                    controller.isLoading.value = true;

                    if (controller.editingCommentId.value > 0) {
                      // Editing existing comment
                      await controller.editComment(
                        post.id ?? 0,
                        controller.editingCommentId.value,
                        controller.commment.value.text,
                        'answer',
                        context,
                      );
                    } else if (controller.replyCommentId.value > 0) {
                      // Adding a new reply
                      await controller.addReplyAnswerComment(
                        post.id ?? 0,
                        controller.replyCommentId.value,
                        context,
                      );
                    } else if (controller.replyCommentId.value == 0) {
                      // Adding a new comment
                      await controller.addAnswers(
                        post.id ?? 0,
                        context,
                      );
                    }
                    controller.isLoading.value = false;
                    controller.commment.value.clear();
                    controller.editingCommentId.value = 0; // Reset editing mode
                    controller.replyCommentId.value = 0; // Reset reply mode
                    isLimitExceeded = false;

                    await _refreshData();
                  },
                  isLoading: controller.isLoading,
                  hintText: controller.hintText,
                  focusNode: _focusNode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showLikeAndViewList(BuildContext context, int index) {
    _tabController.index = index;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: TabBar(
                indicatorColor: Colors.transparent,
                dividerColor: AppColors.grey,
                labelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                controller: _tabController,
                tabs: const [
                  Tab(text: "Likes"),
                  Tab(text: "Views"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                QuestionLikeListContent(questionId: post.id ?? 0),
                QuestionViewListContent(questionId: post.id ?? 0),
              ],
            ),
          ),
        );
      },
    );
  }
}
