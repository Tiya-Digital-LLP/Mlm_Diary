import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_banner_entity.dart';
import 'package:mlmdiary/home/controller/homescreen_controller.dart';
import 'package:mlmdiary/home/post_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/home/suggestion_user_card.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/remimaining_count_controller./remaining_count.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _search = TextEditingController();
  final isSearchVisible = RxBool(false);
  int backPressedCount = 0;
  final GlobalKey _popupMenuButtonKey = GlobalKey();
  final HomeController controller = Get.put(HomeController());
  final PageController pageController = PageController(initialPage: 0);
  int getSliderIndex = 0;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    controller.fetchBanners();
    controller.fetchNotificationCount(1, 'all');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          if (backPressedCount == 0) {
            Fluttertoast.showToast(
              msg: "Please Double Click to Close App",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            backPressedCount++;
            return false;
          } else {
            return true;
          }
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.background),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: size.height * 0.08,
                          width: size.width * 0.45,
                          child: Image.asset(
                            Assets.imagesLogo,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.42,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SEARCH ICON
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.search);
                                },
                                child: SizedBox(
                                  height: size.height * 0.036,
                                  width: size.height * 0.036,
                                  child: SvgPicture.asset(
                                    Assets.svgSearchNormal,
                                  ),
                                ),
                              ),

                              // BUILDING ICON
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.mlmcompanies);
                                },
                                child: SizedBox(
                                  height: size.height * 0.036,
                                  width: size.height * 0.036,
                                  child: SvgPicture.asset(
                                    Assets.svgBuilding,
                                  ),
                                ),
                              ),

                              // MESSAGE ICON
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.messagescreen);
                                },
                                child: SizedBox(
                                  height: size.height * 0.036,
                                  width: size.height * 0.036,
                                  child: SvgPicture.asset(
                                    Assets.svgMessageIcon,
                                  ),
                                ),
                              ),

                              // NOTIFICATION ICON
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.notification);
                                },
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.036,
                                      width: size.height * 0.036,
                                      child: SvgPicture.asset(
                                        Assets.svgNotificationBing,
                                      ),
                                    ),
                                    Obx(
                                      () => controller.notificationCount > 0
                                          ? Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
                                                ),
                                                constraints:
                                                    const BoxConstraints(
                                                  minWidth: 18,
                                                  minHeight: 18,
                                                ),
                                                child: Text(
                                                  '${controller.notificationCount}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Obx(() => Visibility(
                        visible: isSearchVisible.value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomSearchInput(
                                  controller: _search,
                                  onSubmitted: (value) {
                                    WidgetsBinding
                                        .instance.focusManager.primaryFocus
                                        ?.unfocus();
                                  },
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      WidgetsBinding
                                          .instance.focusManager.primaryFocus;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.22,
                            child: Obx(() {
                              final banners = controller.banners;
                              return sliderHome(banners, context);
                            }),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Text(
                            "People You May Know",
                            style: textStyleW700(
                                size.width * 0.048, AppColors.blackText),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int index = 0;
                                    index < suggestedAUserList.length;
                                    index++)
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: (index == 0)
                                            ? 0
                                            : size.width * 0.03,
                                      ),
                                      SuggestionUserCard(
                                        userImage:
                                            suggestedAUserList[index].userImage,
                                        name: suggestedAUserList[index].name,
                                        post: suggestedAUserList[index].post,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            height: size.height * 0.015,
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: postList.length,
                            itemBuilder: (context, index) {
                              final post = postList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: PostCard(
                                  userImage: post.userImage,
                                  userName: post.userName,
                                  postCaption: post.postCaption,
                                  postImage: post.postImage,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: PopupMenuButton(
                  padding: const EdgeInsets.only(
                    top: 260,
                  ),
                  elevation: 9,
                  color: AppColors.white,
                  key: _popupMenuButtonKey,
                  itemBuilder: (_) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 1,
                      onTap: () {
                        Get.toNamed(Routes.addpost);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgClipboardText),
                          3.sbw,
                          const Text('Add Post'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      onTap: () async {
                        var controller =
                            CustomFloatingActionButtonController(context);

                        String selectedType = 'classified';

                        await controller.handleTap(selectedType);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgGrid3),
                          3.sbw,
                          const Text('Add Classified'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      onTap: () {
                        Get.toNamed(Routes.addquestionanswer);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgMessageQuestion),
                          3.sbw,
                          const Text('Add Question'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 4,
                      onTap: () async {
                        var controller =
                            CustomFloatingActionButtonController(context);

                        String selectedType = 'blog';

                        await controller.handleTap(selectedType);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgDocumentText),
                          3.sbw,
                          const Text('Add Blog'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 5,
                      onTap: () async {
                        var controller =
                            CustomFloatingActionButtonController(context);

                        String selectedType = 'news';

                        await controller.handleTap(selectedType);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgClipboardText),
                          3.sbw,
                          const Text('Add News'),
                        ],
                      ),
                    ),
                  ],
                  icon: SvgPicture.asset(Assets.svgPlusIcon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sliderHome(List<GetBannerData> banners, context) {
    // Define a page controller with desired properties
    PageController pageController = PageController(
      initialPage: 0, // Set the initial page index
      viewportFraction: 1,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.width / 1.9,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Use PageView.builder with the defined page controller
          PageView.builder(
            controller: pageController,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    print('Banner Web Link: ${banner.weblink}');
                  }
                  if (banner.weblink != null && banner.weblink!.isNotEmpty) {
                    if (Platform.isAndroid) {
                      // Android-specific behavior
                      if (kDebugMode) {
                        print('Android specific behavior');
                      }
                      launchURL(banner.weblink ?? '');
                    } else if (Platform.isIOS) {
                      // iOS-specific behavior
                      if (kDebugMode) {
                        print('iOS specific behavior');
                      }
                      launchURL(banner.weblink ?? '');
                    }
                  } else {
                    if (kDebugMode) {
                      print('Banner Web Link is either null or empty');
                    }
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    banner.image ?? '',
                    fit: BoxFit.fill,
                    width: 2500.0,
                  ),
                ),
              );
            },
            onPageChanged: (index) {},
          ),
          Positioned(
            bottom: 10,
            right: 16,
            child: SizedBox(
              height: 8,
              child: ListView.builder(
                itemCount: banners.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.5),
                      color: index == 0
                          ? AppColors.primaryColor
                          : const Color(0xFFD9D9D9),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    // ignore: deprecated_member_use
    if (await canLaunch(uri.toString())) {
      // ignore: deprecated_member_use
      await launch(uri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}
