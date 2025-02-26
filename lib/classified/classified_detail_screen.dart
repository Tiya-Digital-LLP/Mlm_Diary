import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/classified_like_list_content.dart';
import 'package:mlmdiary/classified/classified_view_list_content.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/generated/assets.dart';
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

class ClassidiedDetailsScreen extends StatefulWidget {
  const ClassidiedDetailsScreen({required Key key}) : super(key: key);

  @override
  State<ClassidiedDetailsScreen> createState() =>
      _ClassidiedDetailsScreenState();
}

class _ClassidiedDetailsScreenState extends State<ClassidiedDetailsScreen>
    with SingleTickerProviderStateMixin {
  final ClasifiedController controller = Get.put(ClasifiedController());
  dynamic post;
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  // like
  late RxBool isLiked;
  late RxInt likeCount;
  // bookmark
  late RxBool isBookmarked;
  late RxInt bookmarkCount;

  late PageController pageController;
  int currentPage = 0;
  int totalItems = 0;

  late TabController _tabController;

  void initializeLikes(int index) {
    isLiked = RxBool(controller.classifiedList[index].likedByUser ?? false);
    likeCount = RxInt(controller.classifiedList[index].totallike ?? 0);
  }

  void initializeBookmarks(int index) {
    isBookmarked =
        RxBool(controller.classifiedList[index].bookmarkedByUser ?? false);
    bookmarkCount = RxInt(controller.classifiedList[index].totalbookmark ?? 0);
  }

  void toggleLike() async {
    bool newLikeValue = !isLiked.value;
    isLiked.value = newLikeValue;
    likeCount.value = newLikeValue ? likeCount.value + 1 : likeCount.value - 1;

    await controller.toggleLike(post.id ?? 0, context);
  }

  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    await controller.toggleBookMark(post.id ?? 0, context);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    pageController = PageController(initialPage: currentPage);

    post = Get.arguments;
    if (post != null && post.id != null) {
      controller.getTestClassified(1);
    }
    // Find index of the post in classifiedList
    int postIndex =
        controller.classifiedList.indexWhere((item) => item.id == post.id);

    // Ensure the index is valid before calling the methods
    if (postIndex != -1) {
      initializeLikes(postIndex);
      initializeBookmarks(postIndex);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.countViewClassified(post.id ?? 0, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Classified',
        onTap: () {},
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: controller.classifiedList.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
            post = controller.classifiedList[index];

            // Update isLiked and likeCount for the new post
            initializeLikes(index);
            initializeBookmarks(index);
          });

          if (kDebugMode) {
            print("Page changed to: $index");
            print("Selected post: ${post.id}");
          }

          controller.getTestClassified(1);
        },
        itemBuilder: (context, index) {
          return controller.isLoading.value
              ? SingleChildScrollView(
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
                                      arguments: {
                                        'user_id': post.userId,
                                      },
                                    );
                                    await userProfileController
                                        .fetchUserAllPost(
                                      1,
                                      post.userId.toString(),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              post.userData!.imagePath ?? '',
                                          height: 60.0,
                                          width: 60.0,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  Assets.imagesAdminlogo),
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
                                              DateTime.parse(
                                                          post.createdate ?? '')
                                                      .isAtSameMomentAs(
                                                          DateTime.parse(
                                                              post.datemodified ??
                                                                  ''))
                                                  ? post.createdate ?? ''
                                                  : post.datemodified ?? '',
                                            ),
                                            style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.blackText
                                                  // ignore: deprecated_member_use
                                                  .withOpacity(0.5),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: InkWell(
                                  onTap: () {
                                    _showFullScreenImageDialog(context);
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.26,
                                    width: size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                        imageUrl: post.imageUrl,
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(Assets.imagesLogo),
                                      ),
                                    ),
                                  ),
                                ),
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
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w700,
                                        fontSize: FontSize.medium,
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blackText,
                                      fontSize: size.width * 0.035,
                                    ),
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
                                          'Company',
                                          style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.grey),
                                        ),
                                      ],
                                    ),
                                    3.sbh,
                                    Text(
                                      post.company?.isNotEmpty == true
                                          ? post.company
                                          : 'N/A',
                                      style: textStyleW400(size.width * 0.032,
                                          AppColors.blackText),
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
                                              size.width * 0.035,
                                              AppColors.grey),
                                        ),
                                      ],
                                    ),
                                    3.sbh,
                                    Text(
                                      post.location?.isNotEmpty == true
                                          ? post.location
                                          : 'N/A',
                                      style: textStyleW400(size.width * 0.035,
                                          AppColors.blackText),
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
                                          style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.grey),
                                        ),
                                      ],
                                    ),
                                    3.sbh,
                                    InkWell(
                                      onTap: () {
                                        _launchURL(post.website.toString());
                                      },
                                      child: LinkText(
                                        text: post.website?.isNotEmpty == true
                                            ? post.website
                                            : 'N/A',
                                        style: textStyleW400(
                                          size.width * 0.035,
                                          // ignore: deprecated_member_use
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
                              5.sbh,
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
                                            bottom:
                                                BorderSide(color: Colors.grey)),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ),
                );
        },
      ),
      bottomNavigationBar: Container(
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
                          onTap: () {
                            toggleLike();
                          },
                          child: Icon(
                            isLiked.value
                                ? Icons.thumb_up
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
                    Obx(() {
                      int postId = post.id ?? 0;
                      int totalLikes = (post.totallike ?? 0) +
                          (controller.likeCountMap[postId] ?? 0);

                      return InkWell(
                        onTap: () {
                          showLikeAndViewList(context, 0);
                        },
                        child: Text(
                          totalLikes.toString(),
                          style: textStyleW600(
                              size.width * 0.038, AppColors.blackText),
                        ),
                      );
                    }),
                    const SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => showFullScreenDialog(
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
                                    '${post.pgcnt ?? 0}',
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
                          onTap: () => toggleBookmark(),
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
                            post.fullUrl,
                            'Classified',
                            post.id.toString(),
                          );

                          debugPrint('Generated Dynamic Link: $dynamicLink');
                          await Share.share(dynamicLink);
                        } catch (e) {
                          debugPrint('Error sharing link: $e');
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Error creating or sharing link: $e")),
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
          )),
    );
  }

  void _showFullScreenImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FullScreenImageDialog(imageUrl: post.imageUrl.toString());
      },
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
                ClassifiedLikedListContent(classifiedId: post.id ?? 0),
                ClassifiedViewListContent(clasiifiedId: post.id ?? 0),
              ],
            ),
          ),
        );
      },
    );
  }
}
