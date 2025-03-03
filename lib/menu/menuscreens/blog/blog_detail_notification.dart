// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_liked_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_view_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/custom_blog_comment.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:mlmdiary/widgets/image_preview_user_image.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_link/text_link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class BlogDetailNotification extends StatefulWidget {
  final int blogId;

  const BlogDetailNotification({super.key, required this.blogId});

  @override
  State<BlogDetailNotification> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailNotification>
    with SingleTickerProviderStateMixin {
  final ManageBlogController controller = Get.put(ManageBlogController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();

  late TabController _tabController;

  // like
  late RxBool isLiked;
  late RxInt likeCount;
// bookmark
  late RxBool isBookmarked;
  late RxInt bookmarkCount;

  void toggleLike(int blogId) async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await controller.toggleLike(blogId, context);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    initializeLikes();
    initializeBookmarks();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchBlogDetail(widget.blogId, context);
      controller.countViewBlog(widget.blogId, context);
    });
  }

  void initializeLikes() {
    if (controller.blogList.isNotEmpty) {
      isLiked = RxBool(controller.blogList[0].likedByUser ?? false);
      likeCount = RxInt(controller.blogList[0].totallike ?? 0);
    } else {
      isLiked = RxBool(false);
      likeCount = RxInt(0);
    }
  }

  void initializeBookmarks() {
    if (controller.blogList.isNotEmpty) {
      isBookmarked = RxBool(controller.blogList[0].bookmarkedByUser ?? false);
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
        titleText: 'MLM Blog',
        onTap: () {},
      ),
      body: Obx(() {
        if (controller.blogList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final post = controller.blogDetailList.first;
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
                        if (post.userData!.name != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: InkWell(
                              onTap: () async {
                                Get.toNamed(Routes.userprofilescreen,
                                    arguments: {
                                      'user_id': post.userId ?? 0,
                                    });
                                await userProfileController.fetchUserAllPost(
                                  1,
                                  post.userId.toString(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            post.userData!.name!,
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
                                            AppColors.blackText
                                                .withOpacity(0.5)),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FullScreenImageDialog(
                                        imageUrl: post.imageUrl.toString());
                                  },
                                );
                              },
                              child: SizedBox(
                                height: size.height * 0.26,
                                width: size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: CachedNetworkImage(
                                    imageUrl: post.imageUrl.toString(),
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(Assets.imagesLogo),
                                  ),
                                ),
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
                              child: Html(
                                data: post.title,
                                style: {
                                  "html": Style(
                                    lineHeight: const LineHeight(1),
                                    maxLines: 1,
                                    fontFamily: satoshiFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.large,
                                    color: AppColors.blackText,
                                  ),
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${post.category} | ${post.subcategory}',
                                style: textStyleW600(
                                    size.width * 0.038, AppColors.blackText),
                              ),
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
                                      'Website',
                                      style: textStyleW400(size.width * 0.032,
                                          AppColors.blackText),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(post.website.toString());
                                  },
                                  child: LinkText(
                                    text: post.website?.isNotEmpty == true
                                        ? post.website!
                                        : 'N/A',
                                    style: textStyleW700(
                                      size.width * 0.035,
                                      AppColors.blackText.withOpacity(0.5),
                                    ),
                                    linkStyle: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Html(
                                data: post.description,
                                style: {
                                  "table": Style(
                                    backgroundColor: const Color.fromARGB(
                                        0x50, 0xee, 0xee, 0xee),
                                  ),
                                  "tr": Style(
                                    border: const Border(
                                        bottom: BorderSide(color: Colors.grey)),
                                  ),
                                  "th": Style(
                                    backgroundColor: Colors.grey,
                                  ),
                                  "td": Style(
                                    alignment: Alignment.topLeft,
                                  ),
                                  'h5': Style(
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                },
                                onLinkTap: (String? url,
                                    Map<String, String> attributes,
                                    dom.Element? element) {
                                  if (url != null) {
                                    if (kDebugMode) {
                                      print("Opening $url...");
                                    }
                                    // Use url_launcher to open the URL
                                    _launchURL(url);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.017,
                          ),
                        ],
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
        if (controller.isLoading.value) {
          return Center(
            child: CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            ),
          );
        } else if (controller.blogDetailList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final post = controller.blogDetailList.first;
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
                              color:
                                  isLiked.value ? AppColors.primaryColor : null,
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
                                  size.width * 0.038,
                                  AppColors.blackText,
                                  isMetropolis: true,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => showFullScreenDialogBlog(
                              context,
                              post.id!,
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
                            style: textStyleW600(
                              size.width * 0.038,
                              AppColors.blackText,
                              isMetropolis: true,
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
                    ],
                  ),
                  Row(
                    children: [
                      Obx(
                        () => SizedBox(
                          height: size.height * 0.028,
                          width: size.height * 0.028,
                          child: GestureDetector(
                            onTap: () => () async {
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
                              post.fullUrl!,
                              'Blog',
                              post.id.toString(),
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
          );
        }
      }),
    );
  }

  Future<void> _launchURL(String? url) async {
    if (url != null && url.isNotEmpty) {
      // Ensure the URL includes a scheme (http or https)
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }

      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
      }
    } else {
      debugPrint('Invalid or empty URL');
    }
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
                BlogLikedListContent(blogId: widget.blogId),
                BlogViewListContent(blogId: widget.blogId),
              ],
            ),
          ),
        );
      },
    );
  }
}
