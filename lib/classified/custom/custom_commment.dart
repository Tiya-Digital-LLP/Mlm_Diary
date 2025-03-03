import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/input_widget.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_link/text_link.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;
import 'package:mlmdiary/generated/get_comment_classified_entity.dart';

class CommentDialog extends StatefulWidget {
  final int classifiedId;

  const CommentDialog({super.key, required this.classifiedId});

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  final PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  final ClasifiedController controller = Get.put(ClasifiedController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  static const int maxCharacters = 500;
  late ScrollController _scrollController;
  int? currentUserID;
  bool isLimitExceeded = false;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
      _getUserId();
    });
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _refreshData() async {
    controller.getCommentClassified(1, widget.classifiedId, context);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Constants.userId);
  }

  Future<void> _getUserId() async {
    currentUserID = await getUserId();
    setState(() {});
  }

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

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !controller.isEndOfData.value) {
      int nextPage = (controller.getCommentList.length ~/ 10) + 1;
      controller.getCommentClassified(nextPage, widget.classifiedId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        title: Text(
          'Comments',
          style: textStyleW700(
            size.width * 0.048,
            AppColors.blackText,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                color: AppColors.background,
                backgroundColor: AppColors.primaryColor,
                onRefresh: _refreshData,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                    () {
                      if (controller.isLoading.value &&
                          controller.getCommentList.isEmpty) {
                        return const SizedBox();
                      }
                      if (controller.getCommentList.isEmpty) {
                        return Center(
                          child: Text(
                            'No Any Comment Found',
                            style: textStyleW700(
                                size.width * 0.030, AppColors.blackText),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: controller.getCommentList.length +
                            (controller.isLoading.value ? 1 : 0),
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          if (index < controller.getCommentList.length) {
                            final comment = controller.getCommentList[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildComment(comment, size),
                                  if (comment.commentsReplays != null &&
                                      comment.commentsReplays!.isNotEmpty)
                                    Column(
                                      children:
                                          comment.commentsReplays!.map((reply) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 32, top: 8),
                                              child: _buildSingleReply(
                                                  reply, size),
                                            ),
                                            if (reply.commentsReplays != null &&
                                                reply.commentsReplays!
                                                    .isNotEmpty)
                                              Column(
                                                children: reply.commentsReplays!
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
                FocusScope.of(context).unfocus();

                if (controller.commment.value.text.isEmpty) {
                  showToasterrorborder('Please enter your reply', context);
                  return;
                }

                controller.isLoading.value = true;

                if (controller.editingCommentId.value > 0) {
                  // Editing existing comment
                  await controller.editComment(
                    widget.classifiedId,
                    controller.editingCommentId.value,
                    controller.commment.value.text,
                    'classified',
                    context,
                  );
                } else if (controller.replyCommentId.value > 0) {
                  // Adding a new reply
                  await controller.addReplyComment(
                    widget.classifiedId,
                    controller.replyCommentId.value,
                    context,
                  );
                } else if (controller.replyCommentId.value == 0) {
                  // Adding a new comment
                  await controller.addReplyComment(
                    widget.classifiedId,
                    0,
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
              focusNode: _focusNode,
              hintText: controller.hintText,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment(GetCommentClassifiedData comment, Size size) {
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
                      style: textStyleW700(
                        size.width * 0.038,
                        AppColors.blackText,
                        isMetropolis: true,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      postTimeFormatter
                          .formatPostTime(comment.createdate ?? ''),
                      style: textStyleW400(
                        size.width * 0.022,
                        AppColors.blackText,
                        isMetropolis: true,
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
                            style: textStyleW600(
                              size.width * 0.032,
                              AppColors.primaryColor,
                              isMetropolis: true,
                            ),
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
                              style: textStyleW600(
                                size.width * 0.032,
                                AppColors.greenBorder,
                                isMetropolis: true,
                              ),
                            ),
                          ),
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              await controller.deleteComment(
                                  widget.classifiedId,
                                  comment.id ?? 0,
                                  context);
                              await _refreshData();
                            }),
                            child: Text(
                              'Delete',
                              style: textStyleW600(
                                size.width * 0.032,
                                AppColors.redText,
                                isMetropolis: true,
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

  Widget _buildSingleReply(
    GetCommentClassifiedDataCommentsReplays reply,
    Size size,
  ) {
    return GetBuilder<ClasifiedController>(builder: (controller) {
      currentUserID = currentUserID ?? 0;

      bool isCurrentUserReply = reply.userid == currentUserID;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                Get.toNamed(Routes.userprofilescreen, arguments: {
                  'user_id': reply.userid ?? 0,
                });
                await userProfileController.fetchUserAllPost(
                  1,
                  reply.userid.toString(),
                );
              },
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: reply.userimage ?? Assets.imagesAdminlogo,
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
                    reply.name ?? '',
                    style: textStyleW700(
                      size.width * 0.038,
                      AppColors.blackText,
                      isMetropolis: true,
                    ),
                  ),
                  Text(
                    postTimeFormatter.formatPostTime(reply.createdate ?? ''),
                    style: textStyleW400(
                      size.width * 0.022,
                      AppColors.blackText,
                      isMetropolis: true,
                    ),
                  ),
                  4.sbh,
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildHtmlContent(reply.comment ?? '', size),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => _openKeyboard(
                            isEditing: false,
                            commentId: reply.id,
                            username: reply.name,
                          ),
                          child: Text(
                            'Reply',
                            style: textStyleW600(
                              size.width * 0.032,
                              AppColors.primaryColor,
                              isMetropolis: true,
                            ),
                          ),
                        ),
                        if (isCurrentUserReply)
                          TextButton(
                            onPressed: () {
                              _openKeyboard(
                                isEditing: true,
                                commentId: reply.id,
                                existingText: reply.comment,
                              );
                            },
                            child: Text(
                              'Edit',
                              style: textStyleW600(
                                size.width * 0.032,
                                AppColors.greenBorder,
                                isMetropolis: true,
                              ),
                            ),
                          ),
                        if (isCurrentUserReply)
                          TextButton(
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              await controller.deleteComment(
                                  widget.classifiedId, reply.id ?? 0, context);
                              await _refreshData();
                            }),
                            child: Text(
                              'Delete',
                              style: textStyleW600(
                                size.width * 0.032,
                                AppColors.redText,
                                isMetropolis: true,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNestedReply(
    GetCommentClassifiedDataCommentsReplaysCommentsReplays reply,
    Size size,
  ) {
    return GetBuilder<ClasifiedController>(builder: (controller) {
      currentUserID = currentUserID ?? 0;
      bool isCurrentUserReply = reply.userid == currentUserID;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                Get.toNamed(Routes.userprofilescreen, arguments: {
                  'user_id': reply.userid ?? 0,
                });
                await userProfileController.fetchUserAllPost(
                  1,
                  reply.userid.toString(),
                );
              },
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: reply.userimage ?? Assets.imagesAdminlogo,
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
                    reply.name ?? '',
                    style: textStyleW700(
                      size.width * 0.038,
                      AppColors.blackText,
                      isMetropolis: true,
                    ),
                  ),
                  Text(
                    postTimeFormatter.formatPostTime(reply.createdate ?? ''),
                    style: textStyleW400(
                      size.width * 0.022,
                      AppColors.blackText,
                      isMetropolis: true,
                    ),
                  ),
                  4.sbh,
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildHtmlContent(reply.comment ?? '', size),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => _openKeyboard(
                            isEditing: false,
                            commentId: reply.id,
                            username: reply.name,
                          ),
                          child: Text(
                            'Reply',
                            style: textStyleW600(
                              size.width * 0.032,
                              AppColors.primaryColor,
                              isMetropolis: true,
                            ),
                          ),
                        ),
                        if (isCurrentUserReply)
                          TextButton(
                            onPressed: () {
                              _openKeyboard(
                                isEditing: true,
                                commentId: reply.id,
                                existingText: reply.comment,
                              );
                            },
                            child: Text(
                              'Edit',
                              style: textStyleW600(
                                size.width * 0.032,
                                AppColors.greenBorder,
                                isMetropolis: true,
                              ),
                            ),
                          ),
                        if (isCurrentUserReply)
                          TextButton(
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              await controller.deleteComment(
                                  widget.classifiedId, reply.id ?? 0, context);
                              await _refreshData();
                            }),
                            child: Text(
                              'Delete',
                              style: textStyleW600(
                                size.width * 0.032,
                                AppColors.redText,
                                isMetropolis: true,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
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
        isMetropolis: true,
      ),
      linkStyle: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

void showFullScreenDialog(BuildContext context, int classifiedId) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return CommentDialog(classifiedId: classifiedId);
    },
  );
}
