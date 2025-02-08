import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/custom_post_comment.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/post_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/post_view_list_content.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_link/text_link.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;

class PostDetailNotification extends StatefulWidget {
  final int postId;

  const PostDetailNotification({super.key, required this.postId});

  @override
  State<PostDetailNotification> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailNotification>
    with SingleTickerProviderStateMixin {
  final EditPostController controller = Get.put(EditPostController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  PostTimeFormatter postTimeFormatter = PostTimeFormatter();

  // like
  late RxBool isLiked;
  late RxInt likeCount;
// bookmark
  late RxBool isBookmarked;
  late RxInt bookmarkCount;

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await controller.toggleLike(widget.postId, context);
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    initializeLikes();
    initializeBookmarks();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchPostDetail(
        widget.postId,
        context,
      );
      controller.countViewUserProfile(widget.postId, context);
    });

    // ignore: unrelated_type_equality_checks
    controller.likeCountMap == 0;
    // ignore: unrelated_type_equality_checks
    controller.bookmarkCountMap == 0;
  }

  void initializeLikes() {
    if (controller.getpostList.isNotEmpty) {
      isLiked = RxBool(controller.getpostList[0].likedByUser ?? false);
      likeCount = RxInt(controller.getpostList[0].totallike ?? 0);
    } else {
      isLiked = RxBool(false);
      likeCount = RxInt(0);
    }
  }

  void initializeBookmarks() {
    if (controller.getpostList.isNotEmpty) {
      isBookmarked =
          RxBool(controller.getpostList[0].bookmarkedByUser ?? false);
    } else {
      isBookmarked = RxBool(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Post',
        onTap: () {},
      ),
      body: Obx(() {
        if (controller.postDetailList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final post = controller.postDetailList.first;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                            onTap: () async {
                              Get.toNamed(
                                Routes.userprofilescreen,
                                arguments: post,
                              );
                              await userProfileController.fetchUserAllPost(
                                1,
                                post.id.toString(),
                              );
                            },
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: post.userData!.imagePath ?? '',
                                    height: 60.0,
                                    width: 60.0,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(Assets.imagesAdminlogo),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          post.userData!.name ?? '',
                                          style: textStyleW700(
                                              size.width * 0.043,
                                              AppColors.blackText),
                                        ),
                                        const SizedBox(
                                          width: 07,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      postTimeFormatter.formatPostTime(
                                          post.createdate ?? ''),
                                      style: textStyleW400(
                                        size.width * 0.035,
                                        // ignore: deprecated_member_use
                                        AppColors.blackText.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.012,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Container(
                            height: size.height * 0.28,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: post.attachmentPath ?? '',
                              height: 97,
                              width: 105,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  Image.asset(Assets.imagesLogo),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: _buildHtmlContent(post.comments ?? '', size),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        5.sbh,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.white,
                            border: const Border(
                                bottom: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        5.sbh,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Location',
                                    style: textStyleW400(
                                        size.width * 0.035, AppColors.grey),
                                  ),
                                ],
                              ),
                              3.sbh,
                              Text(
                                '${post.userData!.city},${post.userData!.state},${post.userData!.country}',
                                style: textStyleW400(
                                    size.width * 0.035, AppColors.blackText),
                              ),
                            ],
                          ),
                        ),
                        5.sbh,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.white,
                            border: const Border(
                                bottom: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        5.sbh,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Phone',
                                        style: textStyleW400(
                                            size.width * 0.035, AppColors.grey),
                                      ),
                                    ],
                                  ),
                                  3.sbh,
                                  Text(
                                    '${post.userData!.countrycode1} - ${post.userData!.mobile}',
                                    style: textStyleW400(size.width * 0.032,
                                        AppColors.blackText),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Email',
                                          style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.grey),
                                        ),
                                      ],
                                    ),
                                    3.sbh,
                                    Text(
                                      '${post.userData!.email}',
                                      style: textStyleW400(size.width * 0.032,
                                          AppColors.blackText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        5.sbh,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.white,
                            border: const Border(
                                bottom: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        5.sbh,
                        SizedBox(
                          height: size.height * 0.017,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        if (controller.postDetailList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final post = controller.postDetailList.first;
          return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(
                          () => SizedBox(
                            height: size.height * 0.028,
                            width: size.height * 0.028,
                            child: GestureDetector(
                              onTap: () async {
                                bool newLikedValue = !isLiked.value;
                                isLiked.value = newLikedValue;
                                likeCount.value = newLikedValue
                                    ? likeCount.value + 1
                                    : likeCount.value - 1;

                                await controller.toggleLike(
                                    post.id ?? 0, context);
                              },
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
                                  showLikeAndViewList(context, 0);
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
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => showFullScreenDialogPost(
                                context,
                                widget.postId,
                              ),
                              child: SizedBox(
                                height: size.height * 0.028,
                                width: size.height * 0.028,
                                child: SvgPicture.asset(Assets.svgComment),
                              ),
                            ),
                            5.sbw,
                            Text(
                              '${post.totalcomment}',
                              style: TextStyle(
                                fontFamily: "Metropolis",
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.038,
                              ),
                            ),
                          ],
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
                              onTap: () async {
                                bool newBookmarkedValue = !isBookmarked.value;
                                isBookmarked.value = newBookmarkedValue;
                                bookmarkCount.value = newBookmarkedValue
                                    ? bookmarkCount.value + 1
                                    : bookmarkCount.value - 1;

                                await controller.toggleBookMark(
                                    post.id ?? 0, context);
                              },
                              child: SvgPicture.asset(
                                isBookmarked.value
                                    ? Assets.svgCheckBookmark
                                    : Assets.svgSavePost,
                                height: size.height * 0.032,
                              ),
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
                                'https://www.mlmdiary.com/',
                                'Post',
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
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        }
      }),
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
                PostLikeListContent(postId: widget.postId),
                PostViewListContent(postId: widget.postId),
              ],
            ),
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
        size.width * 0.035,
        // ignore: deprecated_member_use
        AppColors.blackText.withOpacity(0.5),
      ),
      linkStyle: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
