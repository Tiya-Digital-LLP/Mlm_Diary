import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mlmdiary/classified/classified_like_list_content.dart';
import 'package:mlmdiary/classified/classified_view_list_content.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/controller/homescreen_controller.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_liked_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/post_like_list_content.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassifiedHomeCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postTitle;
  final String postCaption;
  final String postImage;
  final String dateTime;
  final String updatedateTime;

  final int viewcounts;
  final int bookmarkId;
  final int classifiedId;

  final String url;
  final String type;
  final ManageBlogController manageBlogController;
  final ManageNewsController manageNewsController;
  final ClasifiedController clasifiedController;
  final EditPostController editpostController;
  final QuestionAnswerController questionAnswerController;
  final bool likedbyuser;
  final int likecount;
  final int commentcount;
  final bool bookmarkedbyuser;

  final CompanyController companyController;

  final HomeController controller;
  final bool isPopular;

  const ClassifiedHomeCard({
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
    required this.classifiedId,
    required this.commentcount,
    required this.bookmarkedbyuser,
    required this.isPopular,
    required this.updatedateTime,
  });

  @override
  State<ClassifiedHomeCard> createState() => _FavouritrCardState();
}

class _FavouritrCardState extends State<ClassifiedHomeCard> {
  late PostTimeFormatter postTimeFormatter;
  late RxBool isLiked;
  late RxInt likeCount;

  late RxBool isBookmarked;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
    initializeLikes();
    initializeBookmarks();
  }

  void initializeBookmarks() {
    isBookmarked = RxBool(widget.bookmarkedbyuser);
  }

  void initializeLikes() {
    isLiked = RxBool(widget.likedbyuser);
    likeCount = RxInt(widget.likecount);
  }

  void toggleLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(Constants.accessToken);
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;
    widget.controller.toggleLike(
      widget.type,
      widget.bookmarkId,
      // ignore: use_build_context_synchronously
      context,
      widget.manageBlogController,
      widget.manageNewsController,
      widget.clasifiedController,
      widget.companyController,
      widget.questionAnswerController,
      widget.editpostController,
    );
  }

  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignupDialog();
      },
    );
  }

  void toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(Constants.accessToken);
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;

    widget.controller.toggleBookmark(
      widget.type,
      widget.bookmarkId,
      // ignore: use_build_context_synchronously
      context,
      widget.manageBlogController,
      widget.manageNewsController,
      widget.clasifiedController,
      widget.companyController,
      widget.editpostController,
      widget.questionAnswerController,
      widget.editpostController,
    );
  }

  Widget getLikeListContent(String type) {
    switch (type) {
      case 'classified':
        return const ClassifiedLikedListContent();
      case 'news':
        return const NewsLikeListContent();
      case 'post':
        return const PostLikeListContent();
      case 'question':
        return const QuestionLikeListContent();
      case 'blog':
        return const BlogLikedListContent();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
        border: Border.all(
          color: widget.isPopular ? Colors.yellow : Colors.transparent,
          width: 3.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: widget.userImage,
                    height: 60,
                    width: 60,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        Image.asset(Assets.imagesAdminlogo),
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
                          // ignore: deprecated_member_use
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
                        color: widget.isPopular
                            ? Colors.yellow
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: widget.isPopular
                              ? Colors.yellow
                              : AppColors.primaryColor,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${widget.type[0].toUpperCase()}${widget.type.substring(1)}',
                        style: TextStyle(
                          color:
                              widget.isPopular ? Colors.black : AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: Assets.fontsSatoshiRegular,
                        ),
                      )),
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
            if (widget.postImage.isNotEmpty &&
                Uri.tryParse(widget.postImage)?.hasAbsolutePath == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: SizedBox(
                  height: size.height * 0.26,
                  width: size.width,
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
                      GestureDetector(
                        onTap: () => showFullScreenDialog(
                          context,
                          widget.classifiedId,
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
                      Obx(
                        () => SizedBox(
                          height: size.height * 0.028,
                          width: size.height * 0.028,
                          child: GestureDetector(
                            onTap: toggleBookmark,
                            child: SvgPicture.asset(
                              isBookmarked.value
                                  ? Assets.svgCheckBookmark
                                  : Assets.svgSavePost,
                              height: size.height * 0.032,
                            ),
                          ),
                        ),
                      ),
                      10.sbw,
                      InkWell(
                        onTap: () async {
                          try {
                            final dynamicLink = await createDynamicLink(
                              widget.url,
                              'Classified',
                              widget.classifiedId.toString(),
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
        return const ClassifiedViewListContent();
      },
    );
  }

  void fetchViewList() async {
    await widget.clasifiedController
        .fetchViewListClassified(widget.classifiedId, context);
  }
}
