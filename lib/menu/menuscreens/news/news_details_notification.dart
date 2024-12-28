import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_news_list_entity.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/custom_news_comment.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/image_preview_user_image.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:text_link/text_link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class NewsDetailsNotification extends StatefulWidget {
  const NewsDetailsNotification({
    required Key key,
  }) : super(key: key);

  @override
  State<NewsDetailsNotification> createState() => _MyNewsDetailScreenState();
}

class _MyNewsDetailScreenState extends State<NewsDetailsNotification> {
  final ManageNewsController controller = Get.put(ManageNewsController());
  dynamic post;
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
// like
  late RxBool isLiked;
  late RxInt likeCount;
// bookmark
  late RxBool isBookmarked;
  late RxInt bookmarkCount;

  @override
  void initState() {
    super.initState();

    final arguments = Get.arguments as Map<String, dynamic>?;
    initializeLikes();
    initializeBookmarks();
    if (arguments != null) {
      post = GetNewsListData.fromJson(arguments);
      if (post != null) {
        final int postId = post!.id ?? 0;
        if (postId != 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.getNews(
              postId,
            );
            controller.countViewNews(postId, context);
          });
        }
      }
    }
  }

  void initializeLikes() {
    if (controller.newsList.isNotEmpty) {
      isLiked = RxBool(controller.newsList[0].likedByUser ?? false);
      likeCount = RxInt(controller.newsList[0].totallike ?? 0);
    } else {
      isLiked = RxBool(false);
      likeCount = RxInt(0);
    }
  }

  void initializeBookmarks() {
    if (controller.newsList.isNotEmpty) {
      isBookmarked = RxBool(controller.newsList[0].bookmarkedByUser ?? false);
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
        titleText: 'MLM News',
        onTap: () {},
      ),
      body: Obx(() {
        if (controller.newsList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final data = controller.newsList.first;
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
                              Get.toNamed(Routes.userprofilescreen, arguments: {
                                'user_id': post.userId ?? 0,
                              });
                              await userProfileController.fetchUserAllPost(
                                1,
                                post.userId.toString(),
                              );
                            },
                            child: Row(
                              children: [
                                if (data.userData!.imagePath!.isNotEmpty &&
                                    Uri.tryParse(data.imageUrl!)
                                            ?.hasAbsolutePath ==
                                        true)
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: data.userData!.imagePath ?? '',
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
                                          data.userData!.name ?? '',
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
                                          data.createdate ?? ''),
                                      style: textStyleW400(
                                          size.width * 0.035,
                                          // ignore: deprecated_member_use
                                          AppColors.blackText.withOpacity(0.5)),
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
                        if (data.imageUrl!.isNotEmpty &&
                            Uri.tryParse(data.imageUrl!)?.hasAbsolutePath ==
                                true)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FullScreenImageDialog(
                                        imageUrl: data.imageUrl.toString());
                                  },
                                );
                              },
                              child: SizedBox(
                                height: size.height * 0.26,
                                width: size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    data.imageUrl.toString(),
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
                              data: data.title,
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
                              '${data.category} | ${data.subcategory}',
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
                                      const SizedBox(
                                        width: 07,
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final String? countryCode =
                                          data.userData!.countrycode1;
                                      final String? mobileNumber =
                                          data.userData!.mobile;

                                      if (mobileNumber == null ||
                                          mobileNumber.isEmpty) {
                                        showToasterrorborder(
                                            'No Any Url Found', context);
                                        if (kDebugMode) {
                                          print('Tap without number');
                                        }
                                      } else {
                                        final Uri phoneUri = Uri(
                                          scheme: 'tel',
                                          path:
                                              '$countryCode$mobileNumber', // Combine country code and mobile
                                        );
                                        launchUrl(phoneUri);
                                        if (kDebugMode) {
                                          print(
                                              'Tap with number: $countryCode$mobileNumber');
                                        }
                                      }
                                    },
                                    child: Text(
                                      '${data.userData!.countrycode1 ?? 'N/A'} - ${data.userData!.mobile ?? 'N/A'}',
                                      style: textStyleW400(size.width * 0.032,
                                          AppColors.blackText),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                        'Email',
                                        style: textStyleW400(
                                            size.width * 0.035, AppColors.grey),
                                      ),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final String? email =
                                          data.userData!.email;

                                      if (email != null && email.isNotEmpty) {
                                        final Uri emailUri = Uri(
                                          scheme: 'mailto',
                                          path: email,
                                        );
                                        launchUrl(emailUri);
                                        if (kDebugMode) {
                                          print('Tap with email: $email');
                                        }
                                      } else {
                                        showToasterrorborder(
                                            'No Email Found', context);
                                        if (kDebugMode) {
                                          print('Tap without email');
                                        }
                                      }
                                    },
                                    child: Text(
                                      data.userData!.email?.isNotEmpty == true
                                          ? data.userData!.email!
                                          : 'N/A',
                                      style: textStyleW400(size.width * 0.035,
                                          AppColors.blackText),
                                    ),
                                  ),
                                ],
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
                                  const SizedBox(
                                    width: 07,
                                  ),
                                ],
                              ),
                              LinkText(
                                text: data.website?.isNotEmpty == true
                                    ? data.website!
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
                              data: data.description,
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
                                  _launchUrl(url);
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
        } else if (controller.newsList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final data = controller.newsList.first;
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
                                    data.id ?? 0, context);
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
                              onTap: () => showFullScreenDialogNews(
                                context,
                                data.id!,
                              ),
                              child: SizedBox(
                                height: size.height * 0.028,
                                width: size.height * 0.028,
                                child: SvgPicture.asset(Assets.svgComment),
                              ),
                            ),
                            5.sbw,
                            Text(
                              '${data.totalcomment}',
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
                          data.pgcnt.toString(),
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
                              onTap: () async {
                                bool newBookmarkedValue = !isBookmarked.value;
                                isBookmarked.value = newBookmarkedValue;
                                bookmarkCount.value = newBookmarkedValue
                                    ? bookmarkCount.value + 1
                                    : bookmarkCount.value - 1;

                                await controller.toggleBookMark(
                                    data.id ?? 0, context);
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
              ));
        }
      }),
    );
  }

  // Define the _launchUrl method
  Future<void> _launchUrl(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url); // Old launch method for non-web
    } else {
      throw 'Could not launch $url';
    }
  }

  void showLikeList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Fetch like list after bottom sheet is shown
        fetchLikeList();
        return const NewsLikeListContent();
      },
    );
  }

  void fetchLikeList() async {
    await controller.fetchLikeListNews(post.id ?? 0, context);
  }
}
