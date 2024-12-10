import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/controller/favourite_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:share_plus/share_plus.dart';

class QuestionFavouriteCard extends StatefulWidget {
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

  final CompanyController companyController;

  final FavouriteController controller;
  final int likedCount;

  const QuestionFavouriteCard({
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
    required this.likedCount,
  });

  @override
  State<QuestionFavouriteCard> createState() => _FavouritrCardState();
}

class _FavouritrCardState extends State<QuestionFavouriteCard> {
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
    likeCount = RxInt(widget.likedCount);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: widget.userImage,
                    height: 60,
                    width: 60,
                    fit: BoxFit.fill,
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
                        widget.userName,
                        style: textStyleW700(
                            size.width * 0.038, AppColors.blackText),
                      ),
                      Text(
                        postTimeFormatter.formatPostTime(widget.dateTime),
                        style: textStyleW400(size.width * 0.028,
                            AppColors.blackText.withOpacity(0.8)),
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
            Align(
              alignment: Alignment.topLeft,
              child: Html(
                data: widget.postTitle,
                style: {
                  "html": Style(
                    maxLines: 1,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.medium,
                    color: AppColors.blackText,
                  ),
                },
              ),
            ),
            10.sbh,
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
                      SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: SvgPicture.asset(Assets.svgView),
                      ),
                      8.sbw,
                      Text(
                        '${widget.viewcounts}',
                        style: TextStyle(
                            fontFamily: "Metropolis",
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.038),
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
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share(widget.url);
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
        return const QuestionLikeListContent();
      },
    );
  }

  void fetchLikeList() async {
    await widget.questionAnswerController
        .fetchLikeListQuestion(widget.bookmarkId, context);
  }
}
