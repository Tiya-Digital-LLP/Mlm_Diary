import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_banner_entity.dart';
import 'package:mlmdiary/home/home/controller/homescreen_controller.dart';
import 'package:mlmdiary/home/home/custom/blog_home_card.dart';
import 'package:mlmdiary/home/home/custom/classified_home_card.dart';
import 'package:mlmdiary/home/home/custom/company_home_card.dart';
import 'package:mlmdiary/home/home/custom/database_home_card.dart';
import 'package:mlmdiary/home/home/custom/news_home_card.dart';
import 'package:mlmdiary/home/home/custom/post_home_card.dart';
import 'package:mlmdiary/home/home/custom/question_home_card.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/home/home/custom/video_home_card.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/controller/favourite_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/video/controller/video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/home/suggestion_user_card.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/remimaining_count_controller./remaining_count.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final isSearchVisible = RxBool(false);
  int backPressedCount = 0;
  final GlobalKey _popupMenuButtonKey = GlobalKey();
  final HomeController controller = Get.put(HomeController());
  final FavouriteController favouriteController =
      Get.put(FavouriteController());

  final ManageBlogController manageBlogController =
      Get.put(ManageBlogController());
  final ManageNewsController manageNewsController =
      Get.put(ManageNewsController());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());
  final VideoController videoController = Get.put(VideoController());
  final EditPostController editPostController = Get.put(EditPostController());
  final CompanyController companyController = Get.put(CompanyController());
  final QuestionAnswerController questionAnswerController =
      Get.put(QuestionAnswerController());
  final DatabaseController databaseController = Get.put(DatabaseController());
  final PageController pageController = PageController(initialPage: 0);
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  int getSliderIndex = 0;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    try {
      controller.isEndOfData.value = false;
      controller.homeList.clear();
      await controller.getHome(
        1,
      );
      controller.fetchBanners();
      controller.fetchPopUpBanners();
      controller.fetchNotificationCount(1, 'all');
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Home data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          title: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: size.height * 0.08,
              width: size.width * 0.45,
              child: Image.asset(
                Assets.imagesLogo,
                fit: BoxFit.fill,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // SEARCH ICON
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? apiToken = prefs.getString(Constants.accessToken);

                      if (apiToken == null) {
                        // ignore: use_build_context_synchronously
                        showSignupDialog(context);
                        return;
                      }
                      Get.toNamed(Routes.search);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        Assets.svgSearchNormal,
                        height: size.height * 0.036,
                        width: size.height * 0.036,
                      ),
                    ),
                  ),
                  // BUILDING ICON
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? apiToken = prefs.getString(Constants.accessToken);

                      if (apiToken == null) {
                        // ignore: use_build_context_synchronously
                        showSignupDialog(context);
                        return;
                      }
                      Get.toNamed(Routes.mlmcompanies);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        Assets.svgBuilding,
                        height: size.height * 0.036,
                        width: size.height * 0.036,
                      ),
                    ),
                  ),
                  // MESSAGE ICON
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? apiToken = prefs.getString(Constants.accessToken);

                      if (apiToken == null) {
                        // ignore: use_build_context_synchronously
                        showSignupDialog(context);
                        return;
                      }
                      Get.toNamed(Routes.messagescreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        Assets.svgMessageIcon,
                        height: size.height * 0.036,
                        width: size.height * 0.036,
                      ),
                    ),
                  ),
                  // NOTIFICATION ICON
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? apiToken = prefs.getString(Constants.accessToken);

                      if (apiToken == null) {
                        // ignore: use_build_context_synchronously
                        showSignupDialog(context);
                        return;
                      }
                      Get.toNamed(Routes.notification);
                    },
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          Assets.svgNotificationBing,
                          height: size.height * 0.036,
                          width: size.height * 0.036,
                        ),
                        Obx(() => controller.notificationCount > 0
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  constraints: const BoxConstraints(
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
                            : const SizedBox.shrink()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          if (backPressedCount == 0) {
            backPressedCount++;
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 125.0,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "MLM Diary",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Are you sure you want to exit the App?",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                          8.sbw,
                          TextButton(
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: Text(
                              "Okay",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
            return false;
          } else {
            return true;
          }
        },
        child: RefreshIndicator(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.white,
          onRefresh: _refreshData,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.background),
            child: Stack(
              children: [
                CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        width: size.width,
                        height: size.height * 0.22,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Obx(() {
                            final banners = controller.banners;
                            return sliderHome(banners, context);
                          }),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
                            child: Text(
                              "People You May Know",
                              style: textStyleW700(
                                  size.width * 0.048, AppColors.blackText),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(
                              () => Row(
                                children: [
                                  for (int index = 0;
                                      index <
                                          controller.mutualFriendList.length;
                                      index++)
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: (index == 0)
                                                ? 0
                                                : size.width * 0.03),
                                        Builder(builder: (context) {
                                          return InkWell(
                                            onTap: () async {
                                              Get.toNamed(
                                                  Routes.userprofilescreen,
                                                  arguments: {
                                                    'user_id': controller
                                                        .mutualFriendList[index]
                                                        .id,
                                                  });

                                              await userProfileController
                                                  .fetchUserAllPost(
                                                1,
                                                controller
                                                    .mutualFriendList[index].id
                                                    .toString(),
                                              );
                                            },
                                            child: SuggetionUserCard(
                                              postId: controller
                                                      .mutualFriendList[index]
                                                      .id ??
                                                  0,
                                              editpostcontroller:
                                                  editPostController,
                                              userImage: controller
                                                      .mutualFriendList[index]
                                                      .imageUrl ??
                                                  '',
                                              name: controller
                                                      .mutualFriendList[index]
                                                      .title ??
                                                  '',
                                              post: controller
                                                      .mutualFriendList[index]
                                                      .company ??
                                                  '',
                                              isfollowing: controller
                                                      .mutualFriendList[index]
                                                      .isFollowing ??
                                                  false,
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  10.sbw,
                                  InkWell(
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String? apiToken = prefs
                                          .getString(Constants.accessToken);

                                      if (apiToken == null) {
                                        // ignore: use_build_context_synchronously
                                        showSignupDialog(context);
                                        return;
                                      }
                                      Get.toNamed(Routes.databasescreen);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'view all',
                                          style: textStyleW700(
                                              size.width * 0.036,
                                              AppColors.blackText),
                                        ),
                                        const Icon(
                                          Icons.arrow_right,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                  20.sbw,
                                ],
                              ),
                            ),
                          ),
                          15.sbh,
                        ],
                      ),
                    ),
                    Obx(() {
                      if (controller.isLoading.value &&
                          controller.homeList.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: CustomLottieAnimation(
                              child: Lottie.asset(
                                Assets.lottieLottie,
                              ),
                            ),
                          ),
                        );
                      }
                      if (controller.homeList.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              'Data not found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == controller.homeList.length) {
                              return Center(
                                child: CustomLottieAnimation(
                                  child: Lottie.asset(
                                    Assets.lottieLottie,
                                  ),
                                ),
                              );
                            }
                            final post = controller.homeList[index];
                            String location =
                                '${post.city ?? ''}, ${post.state ?? ''}, ${post.country ?? ''}';
                            Widget cardWidget;
                            switch (post.type) {
                              case 'classified':
                                cardWidget = ClassifiedHomeCard(
                                  userImage: post.userData?.imagePath ?? '',
                                  userName: post.userData?.name ?? '',
                                  postTitle: post.title ?? '',
                                  postCaption: post.description ?? '',
                                  postImage: post.imageUrl ?? '',
                                  dateTime: post.createdate ?? '',
                                  viewcounts: post.pgcnt ?? 0,
                                  controller: controller,
                                  bookmarkId: post.id ?? 0,
                                  url: post.urlcomponent ?? '',
                                  type: post.type ?? '',
                                  manageBlogController: manageBlogController,
                                  manageNewsController: manageNewsController,
                                  clasifiedController: clasifiedController,
                                  companyController: companyController,
                                  editpostController: editPostController,
                                  questionAnswerController:
                                      questionAnswerController,
                                  likedbyuser: post.likedByUser ?? false,
                                  bookmarkedbyuser:
                                      post.bookmarkByUser ?? false,
                                  likecount: post.totallike ?? 0,
                                  classifiedId: post.id ?? 0,
                                  commentcount: post.totalcomment ?? 0,
                                  isPopular: post.popular == 'Y',
                                );
                                break;
                              case 'company':
                                cardWidget = CompanyHomeCard(
                                  userImage: post.userData?.imagePath ?? '',
                                  userName: post.userData?.name ?? '',
                                  postTitle: post.title ?? '',
                                  postCaption: post.description ?? '',
                                  postImage: post.imageUrl ?? '',
                                  dateTime: post.createdate ?? '',
                                  viewcounts: post.pgcnt ?? 0,
                                  controller: controller,
                                  bookmarkId: post.id ?? 0,
                                  url: post.urlcomponent ?? '',
                                  type: post.type ?? '',
                                  manageBlogController: manageBlogController,
                                  manageNewsController: manageNewsController,
                                  clasifiedController: clasifiedController,
                                  companyController: companyController,
                                  editpostController: editPostController,
                                  questionAnswerController:
                                      questionAnswerController,
                                  likedbyuser: post.likedByUser ?? false,
                                  likedCount: post.totallike ?? 0,
                                  companyId: post.id ?? 0,
                                  commentcount: post.totalcomment ?? 0,
                                  bookmarkedbyuser:
                                      post.bookmarkByUser ?? false,
                                );
                                break;
                              case 'blog':
                                cardWidget = BlogHomeCard(
                                  userImage: post.userData?.imagePath ?? '',
                                  userName: post.userData?.name ?? '',
                                  postTitle: post.title ?? '',
                                  postCaption: post.description ?? '',
                                  postImage: post.imageUrl ?? '',
                                  dateTime: post.createdate ?? '',
                                  viewcounts: post.pgcnt ?? 0,
                                  controller: controller,
                                  bookmarkId: post.id ?? 0,
                                  url: post.urlcomponent ?? '',
                                  type: post.type ?? '',
                                  manageBlogController: manageBlogController,
                                  manageNewsController: manageNewsController,
                                  clasifiedController: clasifiedController,
                                  companyController: companyController,
                                  editpostController: editPostController,
                                  questionAnswerController:
                                      questionAnswerController,
                                  likedbyuser: post.likedByUser ?? false,
                                  likedCount: post.totallike ?? 0,
                                  commentcount: post.totalcomment ?? 0,
                                  bookmarkedbyuser:
                                      post.bookmarkByUser ?? false,
                                );
                                break;
                              case 'news':
                                cardWidget = NewsHomeCard(
                                  userImage: post.userData?.imagePath ?? '',
                                  userName: post.userData?.name ?? '',
                                  postTitle: post.title ?? '',
                                  postCaption: post.description ?? '',
                                  postImage: post.imageUrl ?? '',
                                  dateTime: post.createdate ?? '',
                                  viewcounts: post.pgcnt ?? 0,
                                  controller: controller,
                                  bookmarkId: post.id ?? 0,
                                  url: post.urlcomponent ?? '',
                                  type: post.type ?? '',
                                  manageBlogController: manageBlogController,
                                  manageNewsController: manageNewsController,
                                  clasifiedController: clasifiedController,
                                  companyController: companyController,
                                  editpostController: editPostController,
                                  questionAnswerController:
                                      questionAnswerController,
                                  likedbyuser: post.likedByUser ?? false,
                                  commentcount: post.totalcomment ?? 0,
                                  likedCount: post.totallike ?? 0,
                                  bookmarkedbyuser:
                                      post.bookmarkByUser ?? false,
                                );
                                break;
                              case 'video':
                                cardWidget = VideoHomeCard(
                                  postTitle: post.title ?? '',
                                  postVideo: post.image ?? '',
                                  videoController: videoController,
                                  controller: favouriteController,
                                );
                                break;
                              case 'database':
                                cardWidget = DatabaseHomeCard(
                                  userImage: post.userData?.imagePath ?? '',
                                  userName: post.title ?? '',
                                  postTitle: post.title ?? '',
                                  postLocation: location,
                                  immlm: post.immlm ?? '',
                                  plan: post.plan ?? '',
                                  postImage: post.imageUrl ?? '',
                                  dateTime: post.createdate ?? '',
                                  controller: controller,
                                  bookmarkId: post.id ?? 0,
                                  type: post.type ?? '',
                                  manageBlogController: manageBlogController,
                                  manageNewsController: manageNewsController,
                                  clasifiedController: clasifiedController,
                                  companyController: companyController,
                                  editpostController: editPostController,
                                  questionAnswerController:
                                      questionAnswerController,
                                );
                                break;
                              case 'question':
                                cardWidget = QuestionHomeCard(
                                  userImage: post.userData?.imagePath ?? '',
                                  userName: post.userData?.name ?? '',
                                  postTitle: post.title ?? '',
                                  postCaption: post.description ?? '',
                                  postImage: post.imageUrl ?? '',
                                  dateTime: post.createdate ?? '',
                                  viewcounts: post.pgcnt ?? 0,
                                  controller: controller,
                                  bookmarkId: post.id ?? 0,
                                  url: post.urlcomponent ?? '',
                                  type: post.type ?? '',
                                  manageBlogController: manageBlogController,
                                  manageNewsController: manageNewsController,
                                  clasifiedController: clasifiedController,
                                  companyController: companyController,
                                  editpostController: editPostController,
                                  questionAnswerController:
                                      questionAnswerController,
                                  likedbyuser: post.likedByUser ?? false,
                                  likedCount: post.totallike ?? 0,
                                  bookmarkedbyuser:
                                      post.bookmarkByUser ?? false,
                                );
                                break;
                              case 'post':
                                cardWidget = PostHomeCard(
                                  userImage: post.userData?.imagePath ?? '',
                                  userName: post.userData?.name ?? '',
                                  postTitle: post.title ?? '',
                                  postCaption: post.description ?? '',
                                  postImage: post.imageUrl ?? '',
                                  dateTime: post.createdate ?? '',
                                  viewcounts: post.pgcnt ?? 0,
                                  controller: controller,
                                  bookmarkId: post.id ?? 0,
                                  url: post.urlcomponent ?? '',
                                  type: post.type ?? '',
                                  manageBlogController: manageBlogController,
                                  manageNewsController: manageNewsController,
                                  clasifiedController: clasifiedController,
                                  companyController: companyController,
                                  editpostController: editPostController,
                                  questionAnswerController:
                                      questionAnswerController,
                                  likedbyuser: post.likedByUser ?? false,
                                  likecount: post.totallike ?? 0,
                                  commentcount: post.totalcomment ?? 0,
                                  likedCount: post.totallike ?? 0,
                                  bookmarkedbyuser:
                                      post.bookmarkByUser ?? false,
                                );
                                break;
                              default:
                                cardWidget = const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12, left: 16, right: 16),
                              child: GestureDetector(
                                onTap: () {
                                  _navigateToDetails(post);
                                },
                                child: cardWidget,
                              ),
                            );
                          },
                          childCount: controller.homeList.length +
                              (controller.isLoading.value ? 1 : 0),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: PopupMenuButton(
        elevation: 9,
        color: AppColors.white,
        key: _popupMenuButtonKey,
        itemBuilder: (_) => <PopupMenuEntry>[
          PopupMenuItem(
            value: 1,
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? apiToken = prefs.getString(Constants.accessToken);

              if (apiToken == null) {
                // ignore: use_build_context_synchronously
                showSignupDialog(context);
                return;
              }
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? apiToken = prefs.getString(Constants.accessToken);

              if (apiToken == null) {
                // ignore: use_build_context_synchronously
                showSignupDialog(context);
                return;
              }
              // ignore: use_build_context_synchronously
              var controller = CustomFloatingActionButtonController(context);
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
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? apiToken = prefs.getString(Constants.accessToken);

              if (apiToken == null) {
                // ignore: use_build_context_synchronously
                showSignupDialog(context);
                return;
              }
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? apiToken = prefs.getString(Constants.accessToken);

              if (apiToken == null) {
                // ignore: use_build_context_synchronously
                showSignupDialog(context);
                return;
              }
              // ignore: use_build_context_synchronously
              var controller = CustomFloatingActionButtonController(context);
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? apiToken = prefs.getString(Constants.accessToken);

              if (apiToken == null) {
                // ignore: use_build_context_synchronously
                showSignupDialog(context);
                return;
              }
              // ignore: use_build_context_synchronously
              var controller = CustomFloatingActionButtonController(context);
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
    );
  }

  Future<void> _navigateToDetails(post) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null) {
      // ignore: use_build_context_synchronously
      showSignupDialog(context);
      return;
    }

    switch (post.type) {
      case 'classified':
        if (kDebugMode) {
          print('classified');
        }
        Get.toNamed(Routes.mlmclassifieddetail, arguments: post);
        break;
      case 'company':
        if (kDebugMode) {
          print('company');
        }
        Get.toNamed(Routes.mlmcompaniesdetails, arguments: post);
        break;
      case 'blog':
        if (kDebugMode) {
          print('blog');
        }
        Get.toNamed(Routes.blogdetails, arguments: post);
        break;
      case 'news':
        if (kDebugMode) {
          print('news');
        }
        Get.toNamed(Routes.newsdetails, arguments: post);
        break;
      case 'video':
        if (kDebugMode) {
          print('video');
        }
        break;
      case 'database':
        if (kDebugMode) {
          print('database');
        }
        Get.toNamed(Routes.userprofilescreen, arguments: {'user_id': post.id});
        await userProfileController.fetchUserAllPost(1, post.id ?? 0);
        break;

      case 'question':
        if (kDebugMode) {
          print('question');
        }
        Get.toNamed(Routes.userquestion, arguments: post);
        break;
      case 'post':
        if (kDebugMode) {
          print('post');
        }
        Get.toNamed(Routes.postdetail, arguments: post);
        break;
      default:
        Get.toNamed(Routes.mainscreen, arguments: post);
        break;
    }
  }

  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignupDialog();
      },
    );
  }

  Widget sliderHome(List<GetBannerData> banners, BuildContext context) {
    PageController pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );

    // ValueNotifier to keep track of the current page
    ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

    // Timer to auto-slide every 3 seconds
    Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      int currentPage = currentPageNotifier.value;
      if (currentPage < banners.length - 1) {
        currentPageNotifier.value = currentPage + 1;
      } else {
        currentPageNotifier.value = 0;
      }

      // Ensure the PageController is attached to any PageView
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPageNotifier.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });

    return SizedBox(
      height: MediaQuery.of(context).size.width / 1.9,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? apiToken = prefs.getString(Constants.accessToken);

                  if (apiToken == null) {
                    // ignore: use_build_context_synchronously
                    showSignupDialog(context);
                    return;
                  }
                  if (banner.weblink == null || banner.weblink!.isEmpty) {
                    // ignore: use_build_context_synchronously
                    showToasterrorborder('No Any Url Found', context);
                  } else {
                    launchUrl(
                      Uri.parse(banner.weblink.toString()),
                      mode: LaunchMode.externalApplication,
                    );
                    // ignore: use_build_context_synchronously
                    controller.bannerClick(banner.id ?? 0, context);
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
            onPageChanged: (index) {
              currentPageNotifier.value = index;
            },
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: ValueListenableBuilder<int>(
              valueListenable: currentPageNotifier,
              builder: (context, currentPage, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(banners.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == index
                            ? AppColors.primaryColor
                            : Colors.white.withOpacity(0.5),
                      ),
                    );
                  }),
                );
              },
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
