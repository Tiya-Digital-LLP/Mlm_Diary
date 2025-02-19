// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/company_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/company_view_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/custom_company_comment.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_link/text_link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class MlmCompaniesDetails extends StatefulWidget {
  const MlmCompaniesDetails({super.key});

  @override
  State<MlmCompaniesDetails> createState() => _MlmCompaniesDetailsState();
}

class _MlmCompaniesDetailsState extends State<MlmCompaniesDetails>
    with SingleTickerProviderStateMixin {
  final CompanyController controller = Get.put(CompanyController());
  dynamic post;
  final PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  // like
  late RxBool isLiked;
  late RxInt likeCount;
// bookmark
  late RxBool isBookmarked;

  late PageController pageController;
  int currentPage = 0;
  int totalItems = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    pageController = PageController(initialPage: currentPage);

    post = Get.arguments;
    if (post != null && post.id != null) {
      controller.getAdminCompany(1);
    }
    // Find index of the post in classifiedList
    int postIndex =
        controller.companyAdminList.indexWhere((item) => item.id == post.id);

    // Ensure the index is valid before calling the methods
    if (postIndex != -1) {
      initializeLikes(postIndex);
      initializeBookmarks(postIndex);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.countViewCompany(post.id ?? 0, context);
    });
  }

  void initializeLikes(int index) {
    isLiked = RxBool(controller.companyAdminList[index].likedByUser ?? false);
    likeCount = RxInt(controller.companyAdminList[index].totallike ?? 0);
  }

  void initializeBookmarks(int index) {
    isBookmarked =
        RxBool(controller.companyAdminList[index].bookmarkedByUser ?? false);
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

    await controller.toggleBookMark(post.id ?? 0, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Companies',
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: controller.companyAdminList.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
            post = controller.companyAdminList[index];

            // Update isLiked and likeCount for the new post
            initializeLikes(index);
            initializeBookmarks(index);
          });

          if (kDebugMode) {
            print("Page changed to: $index");
            print("Selected post: ${post.id}");
          }

          if (kDebugMode) {
            print("Page changed to: $index");
          }

          controller.getAdminCompany(1);
        },
        itemBuilder: (context, index) {
          return controller.isLoading.value
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
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
                                        horizontal: 16, vertical: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: post.imageUrl ?? '',
                                              height: 60.0,
                                              width: 60.0,
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      Assets.imagesAdminlogo),
                                            ),
                                          ),
                                        ]),
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
                                        post.title ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.blackText,
                                          fontSize: size.width * 0.040,
                                        ),
                                      ),
                                    ),
                                  ),
                                  5.sbh,
                                  Padding(
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
                                              'Location',
                                              style: textStyleW400(
                                                  size.width * 0.035,
                                                  AppColors.grey),
                                            ),
                                            const SizedBox(
                                              width: 07,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          post.location ?? 'N/A',
                                          style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.blackText),
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.sbh,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.white,
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  ),
                                  10.sbh,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                                    'Phone',
                                                    style: textStyleW400(
                                                        size.width * 0.035,
                                                        AppColors.grey),
                                                  ),
                                                  const SizedBox(
                                                    width: 07,
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final String? mobileNumber =
                                                      post.phone;

                                                  if (mobileNumber == null ||
                                                      mobileNumber.isEmpty) {
                                                    showToasterrorborder(
                                                        'No Any Url Found',
                                                        context);
                                                    if (kDebugMode) {
                                                      print(
                                                          'Tap without number');
                                                    }
                                                  } else {
                                                    final Uri phoneUri = Uri(
                                                      scheme: 'tel',
                                                      path: mobileNumber,
                                                    );
                                                    launchUrl(phoneUri);
                                                    if (kDebugMode) {
                                                      print(
                                                          'Tap with number: $mobileNumber');
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  '${post.phone ?? 'N/A'}',
                                                  style: textStyleW400(
                                                      size.width * 0.032,
                                                      AppColors.blackText),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
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
                                                const SizedBox(
                                                  width: 07,
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                final String? email =
                                                    post.email;

                                                if (email != null &&
                                                    email.isNotEmpty) {
                                                  final Uri emailUri = Uri(
                                                    scheme: 'mailto',
                                                    path: email,
                                                  );
                                                  launchUrl(emailUri);
                                                  if (kDebugMode) {
                                                    print(
                                                        'Tap with email: $email');
                                                  }
                                                } else {
                                                  showToasterrorborder(
                                                      'No Email Found',
                                                      context);
                                                  if (kDebugMode) {
                                                    print('Tap without email');
                                                  }
                                                }
                                              },
                                              child: Text(
                                                post.email?.isNotEmpty == true
                                                    ? post.email!
                                                    : 'N/A',
                                                style: textStyleW400(
                                                    size.width * 0.032,
                                                    AppColors.blackText),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.sbh,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.white,
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  ),
                                  10.sbh,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Website',
                                                    style: textStyleW400(
                                                        size.width * 0.035,
                                                        AppColors.grey),
                                                  ),
                                                  const SizedBox(
                                                    width: 07,
                                                  ),
                                                ],
                                              ),
                                              LinkText(
                                                text:
                                                    post.website?.isNotEmpty ==
                                                            true
                                                        ? post.website
                                                        : 'N/A',
                                                style: textStyleW400(
                                                  size.width * 0.035,
                                                  AppColors.blackText
                                                      .withOpacity(0.5),
                                                ),
                                                linkStyle: const TextStyle(
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      if (post.fblink != null) {
                                                        _launchURL(post.fblink
                                                            .toString());
                                                        if (kDebugMode) {
                                                          print(
                                                              'URL: ${post.fblink}');
                                                        }
                                                      } else {
                                                        showToasterrorborder(
                                                            "No Any Url Fond",
                                                            context);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        Assets
                                                            .svgLogosFacebook)),
                                                12.sbw,
                                                InkWell(
                                                    onTap: () {
                                                      if (post.inlink != null) {
                                                        _launchURL(post.inlink
                                                            .toString());
                                                        if (kDebugMode) {
                                                          print(
                                                              'URL: ${post.inlink}');
                                                        }
                                                      } else {
                                                        showToasterrorborder(
                                                            "No Any Url Fond",
                                                            context);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        Assets.svgInstagram)),
                                                12.sbw,
                                                InkWell(
                                                  onTap: () {
                                                    if (post.liklink != null) {
                                                      _launchURL(post.liklink
                                                          .toString());
                                                      if (kDebugMode) {
                                                        print(
                                                            'URL: ${post.liklink}');
                                                      }
                                                    } else {
                                                      showToasterrorborder(
                                                          "No Any Url Fond",
                                                          context);
                                                    }
                                                  },
                                                  child: SvgPicture.asset(Assets
                                                      .svgLogosLinkedinIcon),
                                                ),
                                                12.sbw,
                                                InkWell(
                                                    onTap: () {
                                                      if (post.youlink !=
                                                          null) {
                                                        _launchURL(post.youlink
                                                            .toString());
                                                        if (kDebugMode) {
                                                          print(
                                                              'URL: ${post.youlink}');
                                                        }
                                                      } else {
                                                        showToasterrorborder(
                                                            "No Any Url Fond",
                                                            context);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        Assets.svgYoutube)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.sbh,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.white,
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  ),
                                  10.sbh,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          postTimeFormatter.formatPostTime(
                                              post.createdate ?? ''),
                                          style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.blackText
                                                  .withOpacity(0.8)),
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'About Your Business',
                                          style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.grey),
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
                                                  backgroundColor:
                                                      const Color.fromARGB(0x50,
                                                          0xee, 0xee, 0xee),
                                                ),
                                                "tr": Style(
                                                  border: const Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey)),
                                                ),
                                                "th": Style(
                                                  backgroundColor: Colors.grey,
                                                ),
                                                "td": Style(
                                                  alignment: Alignment.topLeft,
                                                ),
                                                'h5': Style(
                                                  maxLines: 2,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              },
                                              onLinkTap: (String? url,
                                                  Map<String, String>
                                                      attributes,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                          color: isLiked.value ? AppColors.primaryColor : null,
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
                        onTap: () => showFullScreenDialogCompany(
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
                          post.fullUrl!,
                          'Company',
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
      ),
    );
  }

  // Define the _launchUrl method
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url); // Old launch method for non-web
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
                CompanyLikeListContent(companyId: post.id ?? 0),
                CompanyViewListContent(companyId: post.id ?? 0),
              ],
            ),
          ),
        );
      },
    );
  }
}
