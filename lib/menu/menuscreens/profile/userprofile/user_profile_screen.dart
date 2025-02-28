import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/social_button.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/blog_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/classified_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/news_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/post_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/question_user_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_classified.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/profile_shimmer/axis_scroll_shimmer.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/profile_shimmer/axis_scroll_social_shimmer.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/profile_shimmer/personal_info_shimmer.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  final DatabaseController controller = Get.put(DatabaseController());
  final EditPostController editPostController = Get.put(EditPostController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  final MessageController messageController = Get.put(MessageController());
  final ManageBlogController manageBlogController =
      Get.put(ManageBlogController());
  final ManageNewsController manageNewsController =
      Get.put(ManageNewsController());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());
  final QuestionAnswerController questionAnswerController =
      Get.put(QuestionAnswerController());

  final ProfileController profileController = Get.put(ProfileController());
  RxBool isExpanded = true.obs;

  late ScrollController _viewersScrollController;
  late ScrollController _followersScrollController;
  late ScrollController _followingScrollController;
  late ScrollController _scrollController;

  bool isFetchingViewrs = false;

  bool isFetchingFollowers = false;
  bool isFetchingFollowing = false;
  final RxBool showShimmer = true.obs;

  void _scrollListener(String userId) {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !controller.isEndOfData.value) {
      int nextPage = (userProfileController.postallList.length ~/ 10) + 1;
      userProfileController.fetchUserAllPost(nextPage, userId);
    }
  }

  Future<void> _refreshData(String userId) async {
    try {
      controller.isEndOfData.value = false;
      userProfileController.postallList.clear();
      await userProfileController.fetchUserAllPost(1, userId);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Home data: $error');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final int userId = Get.arguments['user_id'] as int;

    Future.delayed(const Duration(seconds: 3), () {
      showShimmer.value = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserPost(userId, context);
      _refreshFollowers(userId);
      _refreshFollowing(userId);
      _refreshViews(userId);
    });

    _followersScrollController = ScrollController();
    _followingScrollController = ScrollController();
    _viewersScrollController = ScrollController();
    _scrollController = ScrollController();

    _followersScrollController.addListener(() {
      if (_followersScrollController.position.pixels ==
          _followersScrollController.position.maxScrollExtent) {
        _loadMoreFollowers(userId);
      }
    });

    _followingScrollController.addListener(() {
      if (_followingScrollController.position.pixels ==
          _followingScrollController.position.maxScrollExtent) {
        _loadMoreFollowing(userId);
      }
    });

    _viewersScrollController.addListener(() {
      if (_viewersScrollController.position.pixels ==
          _viewersScrollController.position.maxScrollExtent) {
        _loadMoreViewers(userId);
      }
    });

    _scrollController.addListener(() => _scrollListener(userId.toString()));
  }

  void _toggleFollow(int userId) async {
    bool newBookmarkedValue = !controller.isFollowing.value;
    controller.isFollowing.value = newBookmarkedValue;

    await editPostController.toggleProfileFollow(userId, context);
  }

  Future<void> _refreshFollowers(int userId) async {
    userProfileController.followers.clear();
    await userProfileController.getFollowers(1, userId);
  }

  Future<void> _refreshFollowing(int userId) async {
    userProfileController.following.clear();
    await userProfileController.getFollowing(1, userId);
  }

  Future<void> _refreshViews(int userId) async {
    userProfileController.views.clear();
    await userProfileController.getViews(1, userId);
  }

  Future<void> _loadMoreFollowers(int userId) async {
    if (!isFetchingFollowers) {
      isFetchingFollowers = true;
      int nextPage = (userProfileController.followers.length ~/ 10) + 1;
      await userProfileController.getFollowers(nextPage, userId);
      isFetchingFollowers = false;
    }
  }

  Future<void> _loadMoreFollowing(int userId) async {
    if (!isFetchingFollowing) {
      isFetchingFollowing = true;
      int nextPage = (userProfileController.following.length ~/ 10) + 1;
      await userProfileController.getFollowing(nextPage, userId);
      isFetchingFollowing = false;
    }
  }

  Future<void> _loadMoreViewers(int userId) async {
    if (!isFetchingViewrs) {
      isFetchingViewrs = true;
      int nextPage = (userProfileController.views.length ~/ 10) + 1;
      await userProfileController.getViews(nextPage, userId);
      isFetchingViewrs = false;
    }
  }

  @override
  void dispose() {
    _followersScrollController.dispose();
    _followingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.all(size.height * 0.012),
            child: const Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
          ),
          elevation: 0,
          title: Text(
            'User Profile',
            style: textStyleW700(size.width * 0.048, AppColors.blackText),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => IconButton(
                  icon: SvgPicture.asset(
                    controller.isBookmarked.value
                        ? Assets.svgCheckBookmark
                        : Assets.svgSavePost,
                    height: size.height * 0.028,
                  ),
                  onPressed: () async {
                    final bookmark = controller.mlmDetailsDatabaseList[0];
                    final userId = bookmark.id ?? 0;

                    bool originalState = controller.isBookmarked.value;
                    controller.isBookmarked.value = !originalState;

                    try {
                      await editPostController.toggleProfileBookMark(
                        userId,
                        context,
                      );
                    } catch (e) {
                      controller.isBookmarked.value = originalState;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.white,
          onRefresh: () async {
            _refreshData(Get.arguments['user_id'].toString());
          },
          child: Obx(() {
            if (controller.isLoading.value) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: PersonalInfoShimmer(),
                    ),
                    15.sbh,
                    AxisScrollShimmer(
                      width: size.width,
                    ),
                    15.sbh,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AxisScrollSocialShimmer(
                              width: double.infinity,
                              height: 40,
                              margin: EdgeInsets.only(right: 10),
                            ),
                          ),
                          Expanded(
                            child: AxisScrollSocialShimmer(
                              width: double.infinity,
                              height: 40,
                              margin: EdgeInsets.only(right: 10),
                            ),
                          ),
                          Expanded(
                            child: AxisScrollSocialShimmer(
                              width: double.infinity,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.sbh,
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child:
                              CustomShimmerClassified(width: 175, height: 240),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            if (controller.mlmDetailsDatabaseList.isEmpty) {
              return const Center(child: Text("No data available"));
            }

            final post = controller.mlmDetailsDatabaseList.first;

            return SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        personlaInfo(),
                        5.sbh,
                        axisScroll(),
                        15.sbh,
                        axisScrollsocial(),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black26, height: 2.0),
                  ScrollableTab(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.primaryColor,
                    indicatorWeight: 1.5,
                    labelColor: AppColors.primaryColor,
                    dividerColor: Colors.grey,
                    onTap: (value) {
                      if (kDebugMode) {
                        print('index $value');
                      }
                    },
                    tabs: [
                      Tab(text: 'Posts (${post.totalPost})'),
                      const Tab(text: 'About Me'),
                    ],
                    children: [
                      Column(
                        children: [
                          10.sbh,
                          Obx(() {
                            if (controller.isLoading.value &&
                                userProfileController.postallList.isEmpty) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return const CustomShimmerClassified(
                                        width: 175, height: 240);
                                  },
                                ),
                              );
                            }
                            if (userProfileController.postallList.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Data not found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  userProfileController.postallList.length +
                                      (controller.isLoading.value ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index <
                                    userProfileController.postallList.length) {
                                  final post =
                                      userProfileController.postallList[index];
                                  Widget cardWidget;
                                  switch (post.type) {
                                    case 'classified':
                                      cardWidget = ClassifiedUserCard(
                                        updatedateTime: post.datemodified ?? '',
                                        userImage:
                                            post.userData?.imagePath ?? '',
                                        userName: post.userData?.name ?? '',
                                        postTitle: post.title ?? '',
                                        postCaption: post.description ?? '',
                                        postImage: post.imageUrl ?? '',
                                        dateTime: post.createdate ?? '',
                                        viewcounts: post.pgcnt ?? 0,
                                        userProfileController:
                                            userProfileController,
                                        bookmarkId: post.id ?? 0,
                                        url: post.urlcomponent ?? '',
                                        type: post.type ?? '',
                                        manageBlogController:
                                            manageBlogController,
                                        manageNewsController:
                                            manageNewsController,
                                        clasifiedController:
                                            clasifiedController,
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

                                    case 'blog':
                                      cardWidget = BlogUserCard(
                                        updatedateTime: post.datemodified ?? '',
                                        userImage:
                                            post.userData?.imagePath ?? '',
                                        userName: post.userData?.name ?? '',
                                        postTitle: post.title ?? '',
                                        postCaption: post.description ?? '',
                                        postImage: post.imageUrl ?? '',
                                        dateTime: post.createdate ?? '',
                                        viewcounts: post.pgcnt ?? 0,
                                        userProfileController:
                                            userProfileController,
                                        bookmarkId: post.id ?? 0,
                                        url: post.urlcomponent ?? '',
                                        type: post.type ?? '',
                                        manageBlogController:
                                            manageBlogController,
                                        manageNewsController:
                                            manageNewsController,
                                        clasifiedController:
                                            clasifiedController,
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
                                      cardWidget = NewsUserCard(
                                        updatedateTime: post.datemodified ?? '',
                                        userImage:
                                            post.userData?.imagePath ?? '',
                                        userName: post.userData?.name ?? '',
                                        postTitle: post.title ?? '',
                                        postCaption: post.description ?? '',
                                        postImage: post.imageUrl ?? '',
                                        dateTime: post.createdate ?? '',
                                        viewcounts: post.pgcnt ?? 0,
                                        userProfileController:
                                            userProfileController,
                                        bookmarkId: post.id ?? 0,
                                        url: post.urlcomponent ?? '',
                                        type: post.type ?? '',
                                        manageBlogController:
                                            manageBlogController,
                                        manageNewsController:
                                            manageNewsController,
                                        clasifiedController:
                                            clasifiedController,
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

                                    case 'question':
                                      cardWidget = QuestionUserCard(
                                        updatedateTime: post.datemodified ?? '',
                                        userImage:
                                            post.userData?.imagePath ?? '',
                                        userName: post.userData?.name ?? '',
                                        postTitle: post.title ?? '',
                                        postCaption: post.description ?? '',
                                        postImage: post.imageUrl ?? '',
                                        dateTime: post.createdate ?? '',
                                        viewcounts: post.pgcnt ?? 0,
                                        userProfileController:
                                            userProfileController,
                                        bookmarkId: post.id ?? 0,
                                        url: post.urlcomponent ?? '',
                                        type: post.type ?? '',
                                        manageBlogController:
                                            manageBlogController,
                                        manageNewsController:
                                            manageNewsController,
                                        clasifiedController:
                                            clasifiedController,
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
                                      cardWidget = PostUserCard(
                                        updatedateTime: post.datemodified ?? '',
                                        userImage:
                                            post.userData?.imagePath ?? '',
                                        userName: post.userData?.name ?? '',
                                        postTitle: post.title ?? '',
                                        postCaption: post.description ?? '',
                                        postImage: post.imageUrl ?? '',
                                        dateTime: post.createdate ?? '',
                                        viewcounts: post.pgcnt ?? 0,
                                        userProfileController:
                                            userProfileController,
                                        bookmarkId: post.id ?? 0,
                                        url: post.urlcomponent ?? '',
                                        type: post.type ?? '',
                                        manageBlogController:
                                            manageBlogController,
                                        manageNewsController:
                                            manageNewsController,
                                        clasifiedController:
                                            clasifiedController,
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
                                } else {
                                  return Center(
                                      child: CustomLottieAnimation(
                                    child: Lottie.asset(
                                      Assets.lottieLottie,
                                    ),
                                  ));
                                }
                              },
                            );
                          }),
                        ],
                      ),
                      SingleChildScrollView(
                        padding:
                            const EdgeInsets.only(top: 20, left: 16, right: 16),
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
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Follow me on',
                                      style: textStyleW400(
                                          size.width * 0.035, AppColors.grey),
                                    ),
                                    10.sbh,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.website == null ||
                                                  post.website!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(
                                                      post.website.toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgWebsite,
                                              height: 28,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.compWebsite == null ||
                                                  post.compWebsite!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(post.compWebsite
                                                      .toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgCompany,
                                              height: 28,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.wplink == null ||
                                                  post.wplink!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(
                                                      post.wplink.toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgLogosWhatsappIcon,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.fblink == null ||
                                                  post.fblink!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(
                                                      post.fblink.toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgLogosFacebook,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.instalink == null ||
                                                  post.instalink!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(post.instalink
                                                      .toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgInstagram,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.lilink == null ||
                                                  post.lilink!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(
                                                      post.lilink.toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgLogosLinkedinIcon,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.youlink == null ||
                                                  post.youlink!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(
                                                      post.youlink.toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgYoutube,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.telink == null ||
                                                  post.telink!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(
                                                      post.telink.toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgTelegram,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (post.twiterlink == null ||
                                                  post.twiterlink!.isEmpty) {
                                                showToasterrorborder(
                                                    'No Any Url Found',
                                                    context);
                                              } else {
                                                launchUrl(
                                                  Uri.parse(post.twiterlink
                                                      .toString()),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgTwitter,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              10.sbh,
                              const Divider(color: Colors.grey),
                              10.sbh,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('About me',
                                        style: textStyleW400(size.width * 0.035,
                                            AppColors.grey)),
                                    Text(
                                      post.aboutyou ?? 'N/A',
                                      style: textStyleW500(size.width * 0.035,
                                          AppColors.blackText),
                                    ),
                                  ],
                                ),
                              ),
                              10.sbh,
                              const Divider(color: Colors.grey),
                              10.sbh,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('About Company',
                                        style: textStyleW400(size.width * 0.035,
                                            AppColors.grey)),
                                    Text(
                                      post.aboutcompany ?? 'N/A',
                                      style: textStyleW500(size.width * 0.035,
                                          AppColors.blackText),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.017),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ));
  }

  Widget personlaInfo() {
    final Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (controller.mlmDetailsDatabaseList.isEmpty) {
        return Center(
          child: Text(
            'No data available',
            style: textStyleW500(size.width * 0.04, AppColors.blackText),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.mlmDetailsDatabaseList.length,
        itemBuilder: (context, index) {
          final post = controller.mlmDetailsDatabaseList[index];

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: InteractiveViewer(
                                child: CachedNetworkImage(
                                  imageUrl: post.imageUrl.toString(),
                                  fit: BoxFit.contain,
                                  width: MediaQuery.of(context).size.width,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Assets.imagesAdminlogo),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: IconButton(
                                icon: const Icon(Icons.clear,
                                    color: Colors.black),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl ?? Assets.imagesAdminlogo,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.imagesAdminlogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              30.sbw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name ?? 'N/A',
                      style: textStyleW700(
                          size.width * 0.045, AppColors.blackText),
                    ),
                    Text(
                      post.immlm ?? 'N/A',
                      style: textStyleW500(
                          size.width * 0.035, AppColors.blackText),
                    ),
                    Text(
                      post.company ?? 'N/A',
                      style: textStyleW500(
                          size.width * 0.035, AppColors.blackText),
                    ),
                    GestureDetector(
                      onTap: () {
                        isExpanded.value = !isExpanded.value;
                      },
                      child: Obx(() => Text(
                            post.plan ?? 'N/A',
                            style: textStyleW500(
                                size.width * 0.035, AppColors.blackText),
                            maxLines: isExpanded.value ? null : 10,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                    Text(
                      '${post.city ?? 'N/A'}, ${post.state ?? 'N/A'}, ${post.country ?? 'N/A'}',
                      style: textStyleW500(
                        size.width * 0.035,
                        AppColors.blackText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget axisScroll() {
    final Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (controller.mlmDetailsDatabaseList.isEmpty) {
        return Center(
          child: Text(
            'No data available',
            style: textStyleW500(size.width * 0.04, AppColors.blackText),
          ),
        );
      }

      return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.mlmDetailsDatabaseList.length,
          itemBuilder: (context, index) {
            final post = controller.mlmDetailsDatabaseList[index];

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          _toggleFollow(post.id ?? 0);
                        },
                        child: Text(
                          controller.isFollowing.value ? 'Unfollow' : 'Follow',
                          style: textStyleW700(
                              size.width * 0.035, AppColors.white),
                        ),
                      ),
                    ),
                  ),
                  20.sbw,
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    buildTabBarView(initialIndex: 0),
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  post.followersCount.toString(),
                                  style: textStyleW700(
                                      size.width * 0.045, AppColors.blackText),
                                ),
                                Text(
                                  'Followers',
                                  style: textStyleW500(
                                      size.width * 0.035, AppColors.blackText),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      20.sbw,
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    buildTabBarView(initialIndex: 1),
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  post.followingCount.toString(),
                                  style: textStyleW700(
                                      size.width * 0.045, AppColors.blackText),
                                ),
                                Text(
                                  'Following',
                                  style: textStyleW500(
                                      size.width * 0.035, AppColors.blackText),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      20.sbw,
                      InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                buildTabBarView(initialIndex: 2),
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              post.views.toString(),
                              style: textStyleW700(
                                  size.width * 0.045, AppColors.blackText),
                            ),
                            Text(
                              'Profile Visits',
                              style: textStyleW500(
                                  size.width * 0.035, AppColors.blackText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }

  Widget axisScrollsocial() {
    final Size size = MediaQuery.of(context).size;
    final userProfile = profileController.userProfile.value.userProfile;

    return Obx(() {
      if (controller.mlmDetailsDatabaseList.isEmpty) {
        return Center(
          child: Text(
            'No data available',
            style: textStyleW500(size.width * 0.04, AppColors.blackText),
          ),
        );
      }

      if (controller.isLoading.value) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AxisScrollSocialShimmer(
                      width: double.infinity,
                      height: 40,
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                  Expanded(
                    child: AxisScrollSocialShimmer(
                      width: double.infinity,
                      height: 40,
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                  Expanded(
                    child: AxisScrollSocialShimmer(
                      width: double.infinity,
                      height: 40,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }

      // Main ListView
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: controller.mlmDetailsDatabaseList.length,
        itemBuilder: (context, index) {
          final post = controller.mlmDetailsDatabaseList[index];

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (post.mobile == null || post.mobile!.isEmpty) {
                      showToasterrorborder('No Any Url Found', context);
                    } else {
                      final Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: '+${post.countrycode1} ${post.mobile}');
                      launchUrl(phoneUri);
                    }
                  },
                  child: const SocialButton(
                      icon: Assets.svgCalling, label: 'Call'),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    final arguments = {
                      'chatId': post.chatId,
                      'toId': post.id.toString(),
                      'userName': post.name,
                      'userImage': post.imageUrl,
                    };

                    if (kDebugMode) {
                      print("Arguments: $arguments");
                    }

                    Get.toNamed(
                      Routes.messagedetailscreen,
                      arguments: arguments,
                    );

                    messageController.fetchMyChatDetail(post.chatId.toString());
                  },
                  child: const SocialButton(
                      icon: Assets.svgChat, label: 'Message'),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    if (post.mobile != null && post.countrycode1 != null) {
                      final String phoneNumber = post.mobile!;
                      final String countryCode = post.countrycode1!.trim();
                      final String formattedCountryCode =
                          countryCode.startsWith('+')
                              ? countryCode
                              : '+$countryCode';

                      if (userProfile != null && userProfile.name != null) {
                        final String username = post.name.toString();

                        final String yourname = userProfile.name.toString();
                        String message =
                            "Hello $username, I’m $yourname. I saw your profile on MLM Diary and would love to know more about you. Looking forward to connecting!";

                        final Uri whatsappUri = Uri.parse(
                            "https://wa.me/${formattedCountryCode.replaceAll(' ', '')}$phoneNumber?text=${Uri.encodeComponent(message)}");

                        if (await canLaunchUrl(whatsappUri)) {
                          await launchUrl(whatsappUri);
                        } else {
                          showToasterrorborder(
                              "Could not launch WhatsApp",
                              // ignore: use_build_context_synchronously
                              context);
                        }
                      } else {
                        showToasterrorborder(
                            "User profile or name is null", context);
                      }
                    } else {
                      showToasterrorborder(
                          "No valid phone number or country code found",
                          context);
                    }
                  },
                  child: const SocialButton(
                    icon: Assets.svgWhatsappIcon,
                    label: 'WhatsApp',
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget buildTabBarView({int initialIndex = 0}) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const TabBar(
            tabs: [
              Tab(text: 'Followers'),
              Tab(text: 'Following'),
              Tab(text: 'Views'),
            ],
          ),
        ),
        body: TabBarView(
          key: UniqueKey(),
          children: [
            Obx(() => userProfileController.followers.isEmpty
                ? const Center(child: Text('No followers'))
                : ListView.builder(
                    controller: _followersScrollController,
                    itemCount: userProfileController.followers.length,
                    itemBuilder: (context, index) {
                      if (index == userProfileController.followers.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      var follower = userProfileController.followers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () async {
                            _refreshFollowers(follower.id ?? 0);
                            _refreshFollowing(follower.id ?? 0);
                            _refreshViews(follower.id ?? 0);

                            controller.fetchUserPost(follower.id ?? 0, context);
                            await userProfileController.fetchUserAllPost(
                              1,
                              follower.id.toString(),
                            );
                            Get.back();
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 9,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: follower.imageUrl != null
                                                ? NetworkImage(
                                                    follower.imageUrl
                                                        .toString(),
                                                  )
                                                : const AssetImage(
                                                        'assets/more.png')
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      8.sbw,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            follower.name ?? "Unknown",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontFamily:
                                                    'assets/fonst/Metropolis-Black.otf'),
                                          ),
                                          2.sbh,
                                          Text(
                                            () {
                                              final addressParts = [
                                                follower.city?.trim(),
                                                follower.state?.trim(),
                                                follower.country?.trim(),
                                              ]
                                                  .where((e) =>
                                                      e != null && e.isNotEmpty)
                                                  .toList();

                                              return addressParts.isNotEmpty
                                                  ? addressParts.join(', ')
                                                  : 'Not Type Address';
                                            }(),
                                            style: TextStyle(
                                              color: AppColors.blackText,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          2.sbh,
                                          Text(
                                            follower.immlm ?? "Unknown",
                                            style: TextStyle(
                                              color: AppColors.blackText,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            Obx(() => userProfileController.following.isEmpty
                ? const Center(child: Text('No following'))
                : ListView.builder(
                    controller:
                        _followingScrollController, // Set the controller here
                    itemCount: userProfileController.following.length,
                    itemBuilder: (context, index) {
                      if (index == userProfileController.following.length) {
                        // Show the loader at the bottom while loading more data
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      var follow = userProfileController.following[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () async {
                            _refreshFollowers(follow.id ?? 0);
                            _refreshFollowing(follow.id ?? 0);
                            _refreshViews(follow.id ?? 0);

                            controller.fetchUserPost(follow.id ?? 0, context);
                            await userProfileController.fetchUserAllPost(
                              1,
                              follow.id.toString(),
                            );
                            Get.back();
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 9,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: follow.imageUrl != null
                                                ? NetworkImage(
                                                    follow.imageUrl.toString(),
                                                  )
                                                : const AssetImage(
                                                        'assets/more.png')
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      8.sbw,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            follow.name ?? "Unknown",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontFamily:
                                                    'assets/fonst/Metropolis-Black.otf'),
                                          ),
                                          2.sbh,
                                          Text(
                                            () {
                                              final addressParts = [
                                                follow.city?.trim(),
                                                follow.state?.trim(),
                                                follow.country?.trim(),
                                              ]
                                                  .where((e) =>
                                                      e != null && e.isNotEmpty)
                                                  .toList();

                                              return addressParts.isNotEmpty
                                                  ? addressParts.join(', ')
                                                  : 'Not Type Address';
                                            }(),
                                            style: TextStyle(
                                              color: AppColors.blackText,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          2.sbh,
                                          Text(
                                            follow.immlm ?? "Unknown",
                                            style: TextStyle(
                                              color: AppColors.blackText,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            Obx(() => userProfileController.views.isEmpty
                ? const Center(child: Text('No Views'))
                : ListView.builder(
                    controller:
                        _viewersScrollController, // Set the controller here
                    itemCount: userProfileController.views.length,
                    itemBuilder: (context, index) {
                      if (index == userProfileController.views.length) {
                        // Show the loader at the bottom while loading more data
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      var viewers = userProfileController.views[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () async {
                            _refreshFollowers(viewers.id!);
                            _refreshFollowing(viewers.id!);
                            _refreshViews(viewers.id!);
                            controller.fetchUserPost(viewers.id!, context);
                            await userProfileController.fetchUserAllPost(
                              1,
                              viewers.id.toString(),
                            );
                            Get.back();
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 9,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image:
                                                viewers.userimageUrl!.isNotEmpty
                                                    ? NetworkImage(viewers
                                                        .userimageUrl
                                                        .toString())
                                                    : const AssetImage(
                                                            'assets/more.png')
                                                        as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      8.sbw,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            viewers.name!,
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontFamily:
                                                    'assets/fonst/Metropolis-Black.otf'),
                                          ),
                                          2.sbh,
                                          Text(
                                            () {
                                              final addressParts = [
                                                viewers.city!.trim(),
                                                viewers.state!.trim(),
                                                viewers.country!.trim(),
                                              ]
                                                  .where((e) => e.isNotEmpty)
                                                  .toList();

                                              return addressParts.isNotEmpty
                                                  ? addressParts.join(', ')
                                                  : 'Not Type Address';
                                            }(),
                                            style: TextStyle(
                                              color: AppColors.blackText,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          2.sbh,
                                          Text(
                                            viewers.immlm!,
                                            style: TextStyle(
                                              color: AppColors.blackText,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToDetails(post) async {
    switch (post.type) {
      case 'classified':
        if (kDebugMode) {
          print('classified');
        }

        Get.toNamed(Routes.mlmclassifieddetail, arguments: post);
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
}
