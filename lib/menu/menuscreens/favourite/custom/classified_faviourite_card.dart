// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/classified_like_list_content.dart';
import 'package:mlmdiary/classified/classified_view_list_content.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/controller/favourite_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:share_plus/share_plus.dart';

class ClassifiedFavouriteCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postTitle;
  final String postCaption;
  final String postImage;
  final String dateTime;
  final int viewcounts;
  final int bookmarkId;

  final String url;
  final String type;
  final ManageBlogController manageBlogController;
  final ManageNewsController manageNewsController;
  final ClasifiedController clasifiedController;
  final EditPostController editpostController;
  final QuestionAnswerController questionAnswerController;
  final bool likedbyuser;
  final int likecount;

  final CompanyController companyController;

  final FavouriteController controller;
  final int commentcount;
  final String updatedateTime;

  const ClassifiedFavouriteCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
    required this.postCaption,
    required this.postImage,
    required this.dateTime,
    required this.controller,
    required this.viewcounts,
    required this.bookmarkId,
    required this.url,
    required this.type,
    required this.manageBlogController,
    required this.manageNewsController,
    required this.clasifiedController,
    required this.companyController,
    required this.editpostController,
    required this.questionAnswerController,
    required this.likedbyuser,
    required this.likecount,
    required this.commentcount,
    required this.updatedateTime,
  });

  @override
  State<ClassifiedFavouriteCard> createState() => _FavouritrCardState();
}

class _FavouritrCardState extends State<ClassifiedFavouriteCard> {
  late PostTimeFormatter postTimeFormatter;
  late RxBool isLiked;
  late RxInt likeCount;

  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
    initializeLikes();
    isBookmarked = widget.controller.isItemBookmark(
      widget.type,
      widget.bookmarkId,
      widget.manageBlogController,
      widget.manageNewsController,
      widget.clasifiedController,
      widget.companyController,
      widget.editpostController,
      widget.questionAnswerController,
      widget.editpostController,
    );
  }

  void initializeLikes() {
    isLiked = RxBool(widget.likedbyuser);
    likeCount = RxInt(widget.likecount);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;
    widget.controller.toggleLike(
      widget.type,
      widget.bookmarkId,
      context,
      widget.manageBlogController,
      widget.manageNewsController,
      widget.clasifiedController,
      widget.companyController,
      widget.questionAnswerController,
      widget.editpostController,
    );
  }

  void togleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
      widget.controller.toggleBookmark(
        widget.type,
        widget.bookmarkId,
        context,
        widget.manageBlogController,
        widget.manageNewsController,
        widget.clasifiedController,
        widget.companyController,
        widget.editpostController,
        widget.questionAnswerController,
        widget.editpostController,
      );
      widget.controller.fetchBookmark(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.userImage.isNotEmpty &&
                    Uri.tryParse(widget.userImage)?.hasAbsolutePath == true)
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.userImage,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox();
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
                      Text(
                        postTimeFormatter.formatPostTime(
                          DateTime.parse(widget.dateTime).isAtSameMomentAs(
                                  DateTime.parse(widget.updatedateTime))
                              ? widget.dateTime
                              : widget.updatedateTime,
                        ),
                        style: textStyleW400(
                          size.width * 0.035,
                          AppColors.blackText.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          '${widget.type[0].toUpperCase()}${widget.type.substring(1)}',
                          style: textStyleW700(
                            size.width * 0.026,
                            AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.postImage.isNotEmpty &&
                      Uri.tryParse(widget.postImage)?.hasAbsolutePath == true)
                    Container(
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          widget.postImage,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              Assets.imagesLogo,
                              fit: BoxFit.fill,
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Html(
                            data: widget.postTitle,
                            style: {
                              "html": Style(
                                lineHeight: const LineHeight(1),
                                maxLines: 1,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.medium,
                                color: AppColors.blackText,
                              ),
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Html(
                            data: widget.postCaption,
                            style: {
                              "html": Style(
                                lineHeight: const LineHeight(1.2),
                                maxLines: 2,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize.small,
                                color: AppColors.blackText,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        SizedBox(
                          height: size.height * 0.028,
                          width: size.height * 0.028,
                          child: InkWell(
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
                        8.sbw,
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
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => showFullScreenDialog(
                          context,
                          widget.bookmarkId,
                        ),
                        child: SizedBox(
                          height: size.height * 0.028,
                          width: size.height * 0.028,
                          child: SvgPicture.asset(Assets.svgComment),
                        ),
                      ),
                      5.sbw,
                      Text(
                        '${widget.commentcount}',
                        style: TextStyle(
                          fontFamily: "Metropolis",
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.038,
                        ),
                      ),
                    ],
                  ),
                  Row(
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
                                showViewList(context);
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
                  Row(
                    children: [
                      SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: GestureDetector(
                          onTap: togleBookmark,
                          child: SvgPicture.asset(
                            Assets.svgCheckBookmark,
                            height: size.height * 0.032,
                          ),
                        ),
                      ),
                      10.sbw,
                      InkWell(
                        onTap: () {
                          Share.share(widget.url);
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
                    ],
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
        fetchLikeList();
        return const ClassifiedLikedListContent();
      },
    );
  }

  void fetchLikeList() async {
    await widget.clasifiedController
        .fetchLikeListClassified(widget.bookmarkId, context);
  }

  void showViewList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        fetchViewList();
        return ClassifiedViewListContent(
          clasiifiedId: widget.bookmarkId,
        );
      },
    );
  }

  void fetchViewList() async {
    await widget.clasifiedController
        .fetchViewListClassified(widget.bookmarkId, 1, context);
  }
}
