import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_like_list_content.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';

class ManageQuestionCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postCaption;
  final int viewcounts;
  final String dateTime;
  final int questionId;
  final QuestionAnswerController controller;
  final int bookmarkCount;
  final int likedCount;

  const ManageQuestionCard({
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
  });

  @override
  State<ManageQuestionCard> createState() => _ManageQuestionCardState();
}

class _ManageQuestionCardState extends State<ManageQuestionCard> {
  late PostTimeFormatter postTimeFormatter;
  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
    initializeBookmarks();
    initializeLikes();
  }

  void initializeLikes() {
    isLiked =
        RxBool(widget.controller.likedStatusMap[widget.questionId] ?? false);
    likeCount = RxInt(
        widget.controller.likeCountMap[widget.questionId] ?? widget.likedCount);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await widget.controller.toggleLike(widget.questionId, context);
  }

  void initializeBookmarks() {
    isBookmarked =
        RxBool(widget.controller.bookmarkStatusMap[widget.questionId] ?? false);
    bookmarkCount = RxInt(
        widget.controller.bookmarkCountMap[widget.questionId] ??
            widget.bookmarkCount);
  }

  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    await widget.controller.toggleBookMark(widget.questionId, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CircleAvatar(
                    radius: 25,
                    child: CachedNetworkImage(
                      imageUrl: widget.userImage,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.postCaption,
                    style: textStyleW400(size.width * 0.035,
                        AppColors.blackText.withOpacity(0.8)),
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
                          color: isLiked.value ? AppColors.primaryColor : null,
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
                              showLikeList(context);
                            },
                            child: Text(
                              '${likeCount.value}',
                              style: textStyleW600(
                                  size.width * 0.038, AppColors.blackText),
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
                      '${widget.viewcounts}',
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
                      child: GestureDetector(
                        onTap: () => toggleBookmark(),
                        child: Icon(
                          isBookmarked.value
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: size.height * 0.032,
                        ),
                      ),
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
          10.sbh,
        ],
      ),
    );
  }

  void showLikeList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        fetchLikeList();
        return const QuestionLikeListContent();
      },
    );
  }

  void fetchLikeList() async {
    await widget.controller.fetchLikeListQuestion(widget.questionId, context);
  }
}
