import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_liked_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_view_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/custom_blog_comment.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:share_plus/share_plus.dart';

class BlogUserCard extends StatefulWidget {
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
  final int commentcount;
  final UserProfileController userProfileController;
  final int likedCount;
  final bool bookmarkedbyuser;
  final String updatedateTime;

  const BlogUserCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
    required this.postCaption,
    required this.postImage,
    required this.dateTime,
    required this.viewcounts,
    required this.bookmarkId,
    required this.url,
    required this.type,
    required this.manageBlogController,
    required this.manageNewsController,
    required this.clasifiedController,
    required this.editpostController,
    required this.questionAnswerController,
    required this.likedbyuser,
    required this.commentcount,
    required this.likedCount,
    required this.bookmarkedbyuser,
    required this.userProfileController,
    required this.updatedateTime,
  });

  @override
  State<BlogUserCard> createState() => _FavouritrCardState();
}

class _FavouritrCardState extends State<BlogUserCard>
    with SingleTickerProviderStateMixin {
  late PostTimeFormatter postTimeFormatter;
  late RxBool isLiked;
  late RxInt likeCount;
  late RxBool isBookmarked;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    postTimeFormatter = PostTimeFormatter();
    initializeLikes();
    initializeBookmarks();
  }

  void initializeLikes() {
    isLiked = RxBool(widget.likedbyuser);
    likeCount = RxInt(widget.likedCount);
  }

  void initializeBookmarks() {
    isBookmarked = RxBool(widget.bookmarkedbyuser);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;
    widget.userProfileController.toggleLike(
      widget.type,
      widget.bookmarkId,
      context,
      widget.manageBlogController,
      widget.manageNewsController,
      widget.clasifiedController,
      widget.questionAnswerController,
      widget.editpostController,
    );
  }

  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;

    widget.userProfileController.toggleBookmark(
      widget.type,
      widget.bookmarkId,
      context,
      widget.manageBlogController,
      widget.manageNewsController,
      widget.clasifiedController,
      widget.editpostController,
      widget.questionAnswerController,
      widget.editpostController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: widget.userImage.isNotEmpty &&
                            Uri.tryParse(widget.userImage)?.hasAbsolutePath ==
                                true
                        ? NetworkImage(
                            widget.userImage,
                          )
                        : null,
                    child: widget.userImage.isEmpty
                        ? Image.asset(Assets.imagesAdminlogo)
                        : null,
                  ),
                  10.sbw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName.isNotEmpty
                              ? widget.userName.toString()
                              : 'N/A',
                          style: textStyleW700(
                            size.width * 0.038,
                            AppColors.blackText,
                          ),
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      child: Center(
                        child: Text(
                          widget.type,
                          style: textStyleW600(
                            size.width * 0.035,
                            AppColors.white,
                          ),
                        ),
                      ),
                    ),
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
                      fontFamily: satoshiFontFamily,
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
                      fontFamily: satoshiFontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.small,
                      color: AppColors.blackText,
                    ),
                  },
                ),
              ),
              Container(
                height: size.height * 0.28,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.postImage,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Image.asset(Assets.imagesLogo),
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
                                color: isLiked.value
                                    ? AppColors.primaryColor
                                    : null,
                              ),
                            ),
                          ),
                          8.sbw,
                          likeCount.value == 0
                              ? const SizedBox.shrink()
                              : InkWell(
                                  onTap: () {
                                    showLikeAndViewList(context, 0);
                                  },
                                  child: Text(
                                    '${likeCount.value}',
                                    style: textStyleW600(
                                      size.width * 0.038,
                                      AppColors.blackText,
                                      isMetropolis: true,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => showFullScreenDialogBlog(
                              context, widget.bookmarkId),
                          child: SizedBox(
                            height: size.height * 0.028,
                            width: size.height * 0.028,
                            child: SvgPicture.asset(Assets.svgComment),
                          ),
                        ),
                        5.sbw,
                        Text(
                          '${widget.commentcount}',
                          style: textStyleW600(
                            size.width * 0.038,
                            AppColors.blackText,
                            isMetropolis: true,
                          ),
                        ),
                      ],
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
                                    style: textStyleW600(
                                      size.width * 0.038,
                                      AppColors.blackText,
                                      isMetropolis: true,
                                    ),
                                  ),
                                ),
                        ],
                      ),
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
                                'Blog',
                                widget.bookmarkId.toString(),
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
                      ],
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

  void showLikeAndViewList(BuildContext context, int index) {
    final Size size = MediaQuery.of(context).size;

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
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.grey,
                labelStyle:
                    textStyleW700(size.width * 0.041, AppColors.primaryColor),
                unselectedLabelStyle:
                    textStyleW400(size.width * 0.041, AppColors.blackText),
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
                BlogLikedListContent(blogId: widget.bookmarkId),
                BlogViewListContent(blogId: widget.bookmarkId),
              ],
            ),
          ),
        );
      },
    );
  }
}
