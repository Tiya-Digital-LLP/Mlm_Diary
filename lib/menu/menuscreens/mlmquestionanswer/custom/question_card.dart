// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_view_list_content.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postCaption;
  final int viewcounts;
  final String dateTime;
  final int questionId;
  final QuestionAnswerController controller;
  final int bookmarkCount;
  final int likedCount;
  final int answerCount;

  final bool likedbyuser;
  final bool bookmarkedbyuser;
  final String url;

  const QuestionCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postCaption,
    required this.viewcounts,
    required this.dateTime,
    required this.questionId,
    required this.controller,
    required this.bookmarkCount,
    required this.likedCount,
    required this.likedbyuser,
    required this.bookmarkedbyuser,
    required this.answerCount,
    required this.url,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with SingleTickerProviderStateMixin {
  late PostTimeFormatter postTimeFormatter;
  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    postTimeFormatter = PostTimeFormatter();
    initializeLikes();

    initializeBookmarks();
  }

  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignupDialog();
      },
    );
  }

  void initializeLikes() {
    isLiked = RxBool(widget.likedbyuser);
    likeCount = RxInt(widget.likedCount);
  }

  void toggleLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(Constants.accessToken);
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    // ignore: use_build_context_synchronously
    await widget.controller.toggleLike(widget.questionId, context);
  }

  void initializeBookmarks() {
    isBookmarked = RxBool(widget.bookmarkedbyuser);
    bookmarkCount = RxInt(widget.bookmarkCount);
  }

  void toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(Constants.accessToken);
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    // ignore: use_build_context_synchronously
    await widget.controller.toggleBookMark(widget.questionId, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.userImage.isNotEmpty &&
                      Uri.tryParse(widget.userImage)?.hasAbsolutePath == true)
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          widget.userImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              Assets.imagesAdminlogo,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  10.sbw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: textStyleW700(
                              size.width * 0.038, AppColors.blackText),
                        ),
                        Row(
                          children: [
                            Text(
                              postTimeFormatter.formatPostTime(widget.dateTime),
                              style: textStyleW400(size.width * 0.028,
                                  AppColors.blackText.withOpacity(0.8)),
                            ),
                            8.sbw,
                            Text(
                              'asked a question',
                              style: textStyleW400(size.width * 0.028,
                                  AppColors.blackText.withOpacity(0.8)),
                            )
                          ],
                        ),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.postCaption,
                      style: textStyleW400(size.width * 0.035,
                          AppColors.blackText.withOpacity(0.8)),
                      maxLines: 2,
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
                      SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: GestureDetector(
                          onTap: toggleLike,
                          child: Icon(
                            isLiked.value
                                ? Icons.thumb_up_off_alt_sharp
                                : Icons.thumb_up_off_alt_outlined,
                            color:
                                isLiked.value ? AppColors.primaryColor : null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      likeCount.value == 0
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                showLikeAndViewList(context, 0);
                              },
                              child: Text(
                                '${likeCount.value}',
                                style: textStyleW600(
                                    size.width * 0.038, AppColors.blackText),
                              ),
                            ),
                      15.sbw,
                      SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: SvgPicture.asset(Assets.svgReply),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        widget.answerCount.toString(),
                        style: TextStyle(
                            fontFamily: "Metropolis",
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.045),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
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
                            widget.viewcounts == 0
                                ? const SizedBox.shrink()
                                : InkWell(
                                    onTap: () {
                                      showLikeAndViewList(context, 1);
                                    },
                                    child: Text(
                                      '${widget.viewcounts}',
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
                      SizedBox(
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
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            final dynamicLink = await createDynamicLink(
                              widget.url,
                              'Question',
                              widget.questionId.toString(),
                            );

                            debugPrint('Generated Dynamic Link: $dynamicLink');
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
                            color: AppColors.blackText,
                          ),
                        ),
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
          ],
        ),
      );
    });
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
                QuestionLikeListContent(questionId: widget.questionId),
                QuestionViewListContent(questionId: widget.questionId),
              ],
            ),
          ),
        );
      },
    );
  }
}
