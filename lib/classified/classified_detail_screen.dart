import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/classified_like_list_content.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom_commment.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_link/text_link.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;

class ClassidiedDetailsScreen extends StatefulWidget {
  const ClassidiedDetailsScreen({required Key key}) : super(key: key);

  @override
  State<ClassidiedDetailsScreen> createState() =>
      _ClassidiedDetailsScreenState();
}

class _ClassidiedDetailsScreenState extends State<ClassidiedDetailsScreen> {
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

  void initializeLikes() {
    isLiked = RxBool(controller.classifiedList[0].likedByUser ?? false);
    likeCount = RxInt(controller.classifiedList[0].totallike ?? 0);
  }

  void initializeBookmarks() {
    isBookmarked =
        RxBool(controller.classifiedList[0].bookmarkedByUser ?? false);
    bookmarkCount = RxInt(controller.classifiedList[0].totalbookmark ?? 0);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

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
    post = Get.arguments;
    if (post != null && post.id != null) {
      controller.getClassified(1);
    }
    controller.fetchClassifiedDetail(post.id ?? 0, context);

    initializeLikes();
    initializeBookmarks();

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
      body: controller.isLoading.value
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
                                await userProfileController.fetchUserAllPost(
                                  1,
                                  post.id ?? 0,
                                );
                                Get.toNamed(
                                  Routes.userprofilescreencopy,
                                  arguments: post,
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
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
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
                                            post.createdate ?? ''),
                                        style: textStyleW400(
                                          size.width * 0.035,
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
                                imageUrl: post.imageUrl ?? '',
                                height: 97,
                                width: 105,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Center(
                                    child: Center(
                                        child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
                              child: _buildHtmlContent(
                                  post.description ?? '', size),
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
                                          size.width * 0.035, AppColors.grey),
                                    ),
                                  ],
                                ),
                                3.sbh,
                                Text(
                                  post.company ?? 'N/A',
                                  style: textStyleW400(
                                      size.width * 0.032, AppColors.blackText),
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
                                          size.width * 0.035, AppColors.grey),
                                    ),
                                  ],
                                ),
                                3.sbh,
                                Text(
                                  post.location,
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
                                              size.width * 0.035,
                                              AppColors.grey),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          size.width * 0.035, AppColors.grey),
                                    ),
                                  ],
                                ),
                                3.sbh,
                                LinkText(
                                  text: post.website ?? '',
                                  style: textStyleW400(
                                    size.width * 0.035,
                                    AppColors.blackText.withOpacity(0.5),
                                  ),
                                  linkStyle: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
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
                          onTap: toggleLike,
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
                    SizedBox(
                      height: size.height * 0.028,
                      width: size.height * 0.028,
                      child: SvgPicture.asset(Assets.svgView),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      post.pgcnt.toString(),
                      style: textStyleW600(
                          size.width * 0.040, AppColors.blackText),
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
                      onTap: () {
                        Share.share(post.fullUrl ?? '');
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

  void showLikeList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Fetch like list after bottom sheet is shown
        fetchLikeList();
        return const ClassifiedLikedListContent();
      },
    );
  }

  void fetchLikeList() async {
    await controller.fetchLikeListClassified(post.id ?? 0, context);
  }

  Widget _buildHtmlContent(String htmlContent, Size size) {
    final parsedHtml = htmlParser.parse(htmlContent);
    final text = parsedHtml.body?.text ?? '';

    return LinkText(
      text: text,
      style: textStyleW400(
        size.width * 0.035,
        AppColors.blackText.withOpacity(0.5),
      ),
      linkStyle: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
