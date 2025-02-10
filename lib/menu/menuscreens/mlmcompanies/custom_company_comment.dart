import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_company_comment_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
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

class CommentDialogPost extends StatefulWidget {
  final int companyId;

  const CommentDialogPost({super.key, required this.companyId});

  @override
  State<CommentDialogPost> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialogPost> {
  final PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  final CompanyController controller = Get.put(CompanyController());
  late ScrollController _scrollController;
  int? currentUserID;
  bool isLimitExceeded = false;
  static const int maxCharacters = 500;

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
    controller.getCommentCompany(1, widget.companyId, context);
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !controller.isEndOfData.value) {
      int nextPage = (controller.getCommentList.length ~/ 10) + 1;
      controller.getCommentCompany(nextPage, widget.companyId, context);
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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
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
                    style:
                        textStyleW700(size.width * 0.030, AppColors.blackText),
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
                              children: comment.commentsReplays!.map((reply) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 32, top: 8),
                                      child: _buildSingleReply(reply, size),
                                    ),
                                    if (reply.commentsReplays != null &&
                                        reply.commentsReplays!.isNotEmpty)
                                      Column(
                                        children: reply.commentsReplays!
                                            .map((replyToReply) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
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
      bottomSheet: Container(
        height: 160,
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Obx(
                  () => Text(
                    '${maxCharacters - controller.commment.value.text.length} characters left',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.searchbar,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isLimitExceeded
                                ? Colors.red
                                : Colors.transparent,
                            width: 2.0,
                          ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Obx(
                                    () => TextField(
                                      controller: controller.commment.value,
                                      maxLines: 5,
                                      maxLength: maxCharacters,
                                      decoration: const InputDecoration(
                                        hintText: 'Write your answer here',
                                        border: InputBorder.none,
                                        counterText:
                                            '', // Hide the built-in counter
                                      ),
                                      onChanged: (text) {
                                        controller.commment.refresh();
                                        if (maxCharacters - text.length == 0) {
                                          if (!isLimitExceeded) {
                                            showToasterrorborder(
                                                "Character limit exceed",
                                                context);
                                          }
                                          setState(() {
                                            isLimitExceeded = true;
                                          });
                                        } else {
                                          setState(() {
                                            isLimitExceeded = false;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (controller
                                        .commment.value.text.isEmpty) {
                                      showToasterrorborder(
                                        "Please enter your reply",
                                        context,
                                      );
                                      return;
                                    }

                                    await controller.addReplyCompanyComment(
                                        widget.companyId, 0, context);
                                    controller.commment.value.clear();
                                    setState(() {
                                      isLimitExceeded = false;
                                    });
                                  },
                                  child: Obx(() => Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor,
                                          boxShadow: [
                                            customBoxShadow(),
                                          ],
                                        ),
                                        child: controller.isLoading.value
                                            ? const CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.white,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.send_rounded,
                                                color: Colors.white,
                                                size: 22,
                                              ),
                                      )),
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
      ),
    );
  }

  Widget _buildComment(GetCompanyCommentData comment, Size size) {
    currentUserID = currentUserID ?? 0;

    bool isCurrentNewsUserComment = comment.userid == currentUserID;
    if (kDebugMode) {
      print('Current Company User ID: $currentUserID');
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
                    _buildHtmlContent(comment.comment ?? '', size),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => _buildReplyBottomSheet(
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
                        if (isCurrentNewsUserComment)
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
                        if (isCurrentNewsUserComment)
                          TextButton(
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              await controller.deleteComment(
                                  widget.companyId, comment.id ?? 0, context);
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

  void _showEditDialog(dynamic data, bool isReply) {
    Rx<TextEditingController> editController =
        TextEditingController(text: data.comment ?? '').obs;

    editController.value.addListener(() {
      // Update Rx controller with the latest value
      controller.commment.value.text = editController.value.text;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.2,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.searchbar,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isLimitExceeded ? Colors.red : Colors.transparent,
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () => Text(
                      '${maxCharacters - editController.value.text.length} characters left',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Obx(
                            () => TextField(
                              controller: editController.value,
                              maxLines: 5,
                              maxLength: maxCharacters,
                              decoration: const InputDecoration(
                                hintText: 'Edit your comment here',
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                editController.refresh();
                                if (maxCharacters - text.length == 0) {
                                  if (!isLimitExceeded) {
                                    showToasterrorborder(
                                        "Character limit exceed", context);
                                  }
                                  setState(() {
                                    isLimitExceeded = true;
                                  });
                                } else {
                                  setState(() {
                                    isLimitExceeded = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String editedComment = editController.value.text;
                          Navigator.of(context).pop();
                          if (isReply) {
                            await controller.editComment(
                                widget.companyId,
                                data.id ?? 0,
                                editedComment,
                                'company',
                                context);
                          } else {
                            await controller.editComment(
                                widget.companyId,
                                data.id ?? 0,
                                editedComment,
                                'company',
                                context);
                          }
                          await _refreshData();
                        },
                        child: Obx(() => Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                                boxShadow: [
                                  customBoxShadow(),
                                ],
                              ),
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Example usage:
  void _showEditCommentDialog(GetCompanyCommentData comment) {
    _showEditDialog(comment, false);
  }

  void _showEditReplyDialog(GetCompanyCommentDataCommentsReplays reply) {
    _showEditDialog(reply, true);
  }

  void _showEditReplytoReplyDialog(
      GetCompanyCommentDataCommentsReplaysCommentsReplays reply) {
    _showEditDialog(reply, true);
  }

  Widget _buildSingleReply(
    GetCompanyCommentDataCommentsReplays reply,
    Size size,
  ) {
    return GetBuilder<CompanyController>(builder: (controller) {
      currentUserID = currentUserID ?? 0;

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
                    postTimeFormatter.formatPostTime(reply.createdate ?? ''),
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
                              onPressed: () =>
                                  LogoutDialog.show(context, () async {
                                await controller.deleteComment(
                                    widget.companyId, reply.id ?? 0, context);
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
    GetCompanyCommentDataCommentsReplaysCommentsReplays reply,
    Size size,
  ) {
    return GetBuilder<CompanyController>(builder: (controller) {
      currentUserID = currentUserID ?? 0; // Use the stored user ID

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
                    postTimeFormatter.formatPostTime(reply.createdate ?? ''),
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
                              onPressed: () =>
                                  LogoutDialog.show(context, () async {
                                await controller.deleteComment(
                                    widget.companyId, reply.id ?? 0, context);
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

  Widget _buildReplyBottomSheet(
    BuildContext context,
    int commentId,
    Size size,
  ) {
    return FractionallySizedBox(
      heightFactor: 0.3,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.searchbar,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isLimitExceeded ? Colors.red : Colors.transparent,
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Obx(
                () => Text(
                  '${maxCharacters - controller.commment.value.text.length} characters left',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Obx(
                                  () => TextField(
                                    controller: controller.commment.value,
                                    maxLines: 5,
                                    maxLength: maxCharacters,
                                    decoration: const InputDecoration(
                                      hintText: 'Write your answer here',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (text) {
                                      controller.commment.refresh();
                                      if (maxCharacters - text.length == 0) {
                                        if (!isLimitExceeded) {
                                          showToasterrorborder(
                                              "Character limit exceed",
                                              context);
                                        }
                                        setState(() {
                                          isLimitExceeded = true;
                                        });
                                      } else {
                                        setState(() {
                                          isLimitExceeded = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  if (controller.commment.value.text.isEmpty) {
                                    showToasterrorborder(
                                      "Please enter your reply",
                                      context,
                                    );
                                    return;
                                  }

                                  await controller.addReplyCompanyComment(
                                      widget.companyId, commentId, context);
                                  controller.commment.value.clear();
                                  Get.back();
                                },
                                child: Obx(() => Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor,
                                        boxShadow: [
                                          customBoxShadow(),
                                        ],
                                      ),
                                      child: controller.isLoading.value
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.send_rounded,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                    )),
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
}

void showFullScreenDialogCompany(BuildContext context, int postId) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return CommentDialogPost(companyId: postId);
    },
  );
}
