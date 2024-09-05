import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
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

  late TabController _tabController;

  RxBool isBookmarked = false.obs;
  late ScrollController _viewersScrollController;
  late ScrollController _followersScrollController;
  late ScrollController _followingScrollController;
  bool isFetchingViewrs = false;

  bool isFetchingFollowers = false;
  bool isFetchingFollowing = false;

  @override
  void initState() {
    super.initState();
    final int userId = Get.arguments['user_id'] as int;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserPost(userId, context);
      _refreshFollowers(userId);
      _refreshFollowing(userId);
      _refreshViews(userId);
    });

    _followersScrollController = ScrollController();
    _followingScrollController = ScrollController();
    _viewersScrollController = ScrollController();

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

    _tabController = TabController(length: 2, vsync: this);
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
      int nextPage = (userProfileController.followers.length ~/ 10) +
          1; // Assuming 10 items per page
      await userProfileController.getFollowers(nextPage, userId);
      isFetchingFollowers = false;
    }
  }

  Future<void> _loadMoreFollowing(int userId) async {
    if (!isFetchingFollowing) {
      isFetchingFollowing = true;
      int nextPage = (userProfileController.following.length ~/ 10) +
          1; // Assuming 10 items per page
      await userProfileController.getFollowing(nextPage, userId);
      isFetchingFollowing = false;
    }
  }

  Future<void> _loadMoreViewers(int userId) async {
    if (!isFetchingViewrs) {
      isFetchingViewrs = true;
      int nextPage = (userProfileController.views.length ~/ 10) +
          1; // Assuming 10 items per page
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
    final userProfile = profileController.userProfile.value.userProfile;

    return Scaffold(
      backgroundColor: AppColors.background,
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
                  isBookmarked.value
                      ? Assets.svgCheckBookmark
                      : Assets.svgSavePost,
                  height: size.height * 0.028,
                ),
                onPressed: () async {
                  final bookmark = controller.mlmDetailsDatabaseList[0];
                  final userId = bookmark.id ?? 0;

                  try {
                    // Fetch current bookmark status
                    bool bookmarkStatus = await _fetchBookmarkStatus(userId);

                    // Defer the state update
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      isBookmarked.value = !bookmarkStatus;
                    });

                    await editPostController.toggleProfileBookMark(
                        userId,
                        // ignore: use_build_context_synchronously
                        context);
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Error: $e",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: CustomLottieAnimation(
            child: Lottie.asset(
              Assets.lottieLottie,
            ),
          ));
        } else {
          final post = controller.mlmDetailsDatabaseList.isNotEmpty
              ? controller.mlmDetailsDatabaseList[0]
              : null;
          return post != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: InteractiveViewer(
                                                child: Image.network(
                                                  '${post.imageUrl.toString()}?${DateTime.now().millisecondsSinceEpoch}',
                                                  fit: BoxFit.contain,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 20,
                                              right: 20,
                                              child: IconButton(
                                                icon: const Icon(Icons.cancel,
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
                                    imageUrl:
                                        post.imageUrl ?? Assets.imagesAdminlogo,
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
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
                                      style: textStyleW700(size.width * 0.045,
                                          AppColors.blackText),
                                    ),
                                    Text(
                                      '${post.city ?? 'N/A'}, ${post.state ?? 'N/A'}, ${post.country ?? 'N/A'}',
                                      style: textStyleW500(
                                        size.width * 0.035,
                                        AppColors.blackText,
                                      ),
                                    ),
                                    Text(
                                      post.company ?? 'N/A',
                                      style: textStyleW500(size.width * 0.035,
                                          AppColors.blackText),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isExpanded.value = !isExpanded.value;
                                      },
                                      child: Obx(() => Text(
                                            post.plan ?? 'N/A',
                                            style: textStyleW500(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                            maxLines:
                                                isExpanded.value ? null : 10,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          20.sbh,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Obx(() {
                                  bool isFollowing = editPostController
                                          .followProfileStatusMap[post.id] ??
                                      false;
                                  return SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                      onPressed: () {
                                        editPostController.toggleProfileFollow(
                                            post.id ?? 0, context);
                                      },
                                      child: Text(
                                        isFollowing ? 'Unfollow' : 'Follow',
                                        style: textStyleW700(size.width * 0.030,
                                            AppColors.white),
                                      ),
                                    ),
                                  );
                                }),
                                20.sbw,
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                              child: buildTabBarView()),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            post.followersCount.toString(),
                                            style: textStyleW700(
                                                size.width * 0.045,
                                                AppColors.blackText),
                                          ),
                                          Text(
                                            'Followers',
                                            style: textStyleW500(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                          ),
                                        ],
                                      ),
                                    ),
                                    20.sbw,
                                    GestureDetector(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              buildTabBarView(),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            post.followingCount.toString(),
                                            style: textStyleW700(
                                                size.width * 0.045,
                                                AppColors.blackText),
                                          ),
                                          Text(
                                            'Following',
                                            style: textStyleW500(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                          ),
                                        ],
                                      ),
                                    ),
                                    20.sbw,
                                    GestureDetector(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              buildTabBarView(),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            post.views.toString(),
                                            style: textStyleW700(
                                                size.width * 0.045,
                                                AppColors.blackText),
                                          ),
                                          Text(
                                            'Profile Visits',
                                            style: textStyleW500(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          20.sbh,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (post.mobile == null ||
                                        post.mobile!.isEmpty) {
                                      showToasterrorborder(
                                          'No Any Url Found', context);
                                      if (kDebugMode) {
                                        print('tap without number');
                                      }
                                    } else {
                                      final Uri phoneUri =
                                          Uri(scheme: 'tel', path: post.mobile);
                                      launchUrl(phoneUri);
                                      if (kDebugMode) {
                                        print('tap with number');
                                      }
                                    }
                                  },
                                  child: const SocialButton(
                                      icon: Assets.svgCalling, label: 'Call'),
                                ),
                                10.sbw,
                                InkWell(
                                  onTap: () async {
                                    if (messageController.chatList.isNotEmpty) {
                                      final post =
                                          messageController.chatList[0];

                                      Get.toNamed(Routes.messagedetailscreen,
                                          arguments: post);
                                    } else {
                                      // If chat list is empty, navigate to screen with a dummy post or handle accordingly
                                      final dummyPost = {
                                        "chatId": null,
                                        "toid": post.id,
                                        "username": post.name,
                                        "imageUrl": post.imageUrl,
                                      };
                                      Get.toNamed(
                                          Routes.usermessagedetailscreen,
                                          arguments: dummyPost);
                                    }
                                  },
                                  child: const SocialButton(
                                    icon: Assets.svgChat,
                                    label: 'Message',
                                  ),
                                ),
                                10.sbw,
                                InkWell(
                                  onTap: () async {
                                    if (post.mobile != null) {
                                      final String phoneNumber = post.mobile!;
                                      final String name =
                                          userProfile!.name.toString();

                                      String message =
                                          "Hello, I am $name. I want to know regarding MLM Diary App.";
                                      final Uri whatsappUri = Uri.parse(
                                          "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

                                      if (await canLaunchUrl(whatsappUri)) {
                                        await launchUrl(whatsappUri);
                                        if (kDebugMode) {
                                          print('URL: $whatsappUri');
                                        }
                                      } else {
                                        if (kDebugMode) {
                                          print(
                                              'Could not launch $whatsappUri');
                                        }
                                        showToasterrorborder(
                                            "Could not launch WhatsApp",
                                            // ignore: use_build_context_synchronously
                                            context);
                                      }
                                    } else {
                                      showToasterrorborder(
                                          "No Any Url Found", context);
                                    }
                                  },
                                  child: const SocialButton(
                                      icon: Assets.svgWhatsappIcon,
                                      label: 'WhatsApp'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.black26, height: 2.0),
                    Container(
                      color: AppColors.white,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                        indicatorColor: AppColors.primaryColor,
                        indicatorWeight: 1.5,
                        labelColor: AppColors.primaryColor,
                        tabs: [
                          Tab(text: 'Posts (${post.followersCount})'),
                          const Tab(text: 'About Me'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 16, right: 16),
                            child: CustomScrollView(
                              slivers: [
                                Obx(() {
                                  if (controller.isLoading.value &&
                                      userProfileController
                                          .postallList.isEmpty) {
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
                                  if (userProfileController
                                      .postallList.isEmpty) {
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
                                        if (index ==
                                            userProfileController
                                                .postallList.length) {
                                          return Center(
                                            child: CustomLottieAnimation(
                                              child: Lottie.asset(
                                                Assets.lottieLottie,
                                              ),
                                            ),
                                          );
                                        }
                                        final post = userProfileController
                                            .postallList[index];
                                        Widget cardWidget;
                                        switch (post.type) {
                                          case 'classified':
                                            cardWidget = ClassifiedUserCard(
                                              userImage:
                                                  post.userData?.imagePath ??
                                                      '',
                                              userName:
                                                  post.userData?.name ?? '',
                                              postTitle: post.title ?? '',
                                              postCaption:
                                                  post.description ?? '',
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
                                              editpostController:
                                                  editPostController,
                                              questionAnswerController:
                                                  questionAnswerController,
                                              likedbyuser:
                                                  post.likedByUser ?? false,
                                              bookmarkedbyuser:
                                                  post.bookmarkByUser ?? false,
                                              likecount: post.totallike ?? 0,
                                              classifiedId: post.id ?? 0,
                                              commentcount:
                                                  post.totalcomment ?? 0,
                                              isPopular: post.popular == 'Y',
                                            );
                                            break;

                                          case 'blog':
                                            cardWidget = BlogUserCard(
                                              userImage:
                                                  post.userData?.imagePath ??
                                                      '',
                                              userName:
                                                  post.userData?.name ?? '',
                                              postTitle: post.title ?? '',
                                              postCaption:
                                                  post.description ?? '',
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
                                              editpostController:
                                                  editPostController,
                                              questionAnswerController:
                                                  questionAnswerController,
                                              likedbyuser:
                                                  post.likedByUser ?? false,
                                              likedCount: post.totallike ?? 0,
                                              commentcount:
                                                  post.totalcomment ?? 0,
                                              bookmarkedbyuser:
                                                  post.bookmarkByUser ?? false,
                                            );
                                            break;
                                          case 'news':
                                            cardWidget = NewsUserCard(
                                              userImage:
                                                  post.userData?.imagePath ??
                                                      '',
                                              userName:
                                                  post.userData?.name ?? '',
                                              postTitle: post.title ?? '',
                                              postCaption:
                                                  post.description ?? '',
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
                                              editpostController:
                                                  editPostController,
                                              questionAnswerController:
                                                  questionAnswerController,
                                              likedbyuser:
                                                  post.likedByUser ?? false,
                                              commentcount:
                                                  post.totalcomment ?? 0,
                                              likedCount: post.totallike ?? 0,
                                              bookmarkedbyuser:
                                                  post.bookmarkByUser ?? false,
                                            );
                                            break;

                                          case 'question':
                                            cardWidget = QuestionUserCard(
                                              userImage:
                                                  post.userData?.imagePath ??
                                                      '',
                                              userName:
                                                  post.userData?.name ?? '',
                                              postTitle: post.title ?? '',
                                              postCaption:
                                                  post.description ?? '',
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
                                              editpostController:
                                                  editPostController,
                                              questionAnswerController:
                                                  questionAnswerController,
                                              likedbyuser:
                                                  post.likedByUser ?? false,
                                              likedCount: post.totallike ?? 0,
                                              bookmarkedbyuser:
                                                  post.bookmarkByUser ?? false,
                                            );
                                            break;
                                          case 'post':
                                            cardWidget = PostUserCard(
                                              userImage:
                                                  post.userData?.imagePath ??
                                                      '',
                                              userName:
                                                  post.userData?.name ?? '',
                                              postTitle: post.title ?? '',
                                              postCaption:
                                                  post.description ?? '',
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
                                              editpostController:
                                                  editPostController,
                                              questionAnswerController:
                                                  questionAnswerController,
                                              likedbyuser:
                                                  post.likedByUser ?? false,
                                              likecount: post.totallike ?? 0,
                                              commentcount:
                                                  post.totalcomment ?? 0,
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
                                      childCount: userProfileController
                                              .postallList.length +
                                          (controller.isLoading.value ? 1 : 0),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(
                                top: 20, left: 16, right: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Follow me on',
                                                style: textStyleW400(
                                                    size.width * 0.035,
                                                    AppColors.grey)),
                                            15.sbh,
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    if (post.wplink == null ||
                                                        post.wplink!.isEmpty) {
                                                      showToasterrorborder(
                                                          'No Any Url Found',
                                                          context);
                                                    } else {
                                                      launchUrl(
                                                        Uri.parse(post.wplink
                                                            .toString()),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    Assets.svgLogosWhatsappIcon,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    if (post.fblink == null ||
                                                        post.fblink!.isEmpty) {
                                                      showToasterrorborder(
                                                          'No Any Url Found',
                                                          context);
                                                    } else {
                                                      launchUrl(
                                                        Uri.parse(post.fblink
                                                            .toString()),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    Assets.svgLogosFacebook,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    if (post.instalink ==
                                                            null ||
                                                        post.instalink!
                                                            .isEmpty) {
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
                                                  icon: SvgPicture.asset(
                                                    Assets.svgInstagram,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    if (post.lilink == null ||
                                                        post.lilink!.isEmpty) {
                                                      showToasterrorborder(
                                                          'No Any Url Found',
                                                          context);
                                                    } else {
                                                      launchUrl(
                                                        Uri.parse(post.lilink
                                                            .toString()),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    Assets.svgLogosLinkedinIcon,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    if (post.youlink == null ||
                                                        post.youlink!.isEmpty) {
                                                      showToasterrorborder(
                                                          'No Any Url Found',
                                                          context);
                                                    } else {
                                                      launchUrl(
                                                        Uri.parse(post.youlink
                                                            .toString()),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    Assets.svgYoutube,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    if (post.telink == null ||
                                                        post.telink!.isEmpty) {
                                                      showToasterrorborder(
                                                          'No Any Url Found',
                                                          context);
                                                    } else {
                                                      launchUrl(
                                                        Uri.parse(post.telink
                                                            .toString()),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    Assets.svgTelegram,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    if (post.twiterlink ==
                                                            null ||
                                                        post.twiterlink!
                                                            .isEmpty) {
                                                      showToasterrorborder(
                                                          'No Any Url Found',
                                                          context);
                                                    } else {
                                                      launchUrl(
                                                        Uri.parse(post
                                                            .twiterlink
                                                            .toString()),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    Assets.svgTwitter,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.sbh,
                                  const Divider(color: Colors.grey),
                                  10.sbh,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('About me',
                                            style: textStyleW400(
                                                size.width * 0.035,
                                                AppColors.grey)),
                                        Text(
                                          post.aboutyou ?? 'N/A',
                                          style: textStyleW500(
                                              size.width * 0.035,
                                              AppColors.blackText),
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.sbh,
                                  const Divider(color: Colors.grey),
                                  10.sbh,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('About Company',
                                            style: textStyleW400(
                                                size.width * 0.035,
                                                AppColors.grey)),
                                        Text(
                                          post.aboutcompany ?? 'N/A',
                                          style: textStyleW500(
                                              size.width * 0.035,
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
                    ),
                  ],
                )
              : const Center(child: Text('No data available'));
        }
      }),
    );
  }

  Widget buildTabBarView() {
    return DefaultTabController(
      length: 3,
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
                    controller:
                        _followersScrollController, // Set the controller here
                    itemCount: userProfileController.followers.length,
                    itemBuilder: (context, index) {
                      if (index == userProfileController.followers.length) {
                        // Show the loader at the bottom while loading more data
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
                                        width: 30,
                                        height: 30,
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
                                        width: 30,
                                        height: 30,
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
                            controller.fetchUserPost(viewers.id, context);
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
                                        width: 30,
                                        height: 30,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            // ignore: unnecessary_null_comparison
                                            image: viewers.userimageUrl != null
                                                ? NetworkImage(
                                                    viewers.userimageUrl
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
                                            viewers.name,
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontFamily:
                                                    'assets/fonst/Metropolis-Black.otf'),
                                          ),
                                          Text(
                                            viewers.immlm,
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

  Future<bool> _fetchBookmarkStatus(int userId) async {
    return false;
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
