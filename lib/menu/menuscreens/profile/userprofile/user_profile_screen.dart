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
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/about_user.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/social_button.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/blog_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/classified_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/news_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/post_user_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/custom/question_user_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final EditPostController editPostController = Get.put(EditPostController());
  final UserProfileController controller = Get.put(UserProfileController());

  final DatabaseController databaseController = Get.put(DatabaseController());
  final MessageController messageController = Get.put(MessageController());
  final ManageBlogController manageBlogController =
      Get.put(ManageBlogController());
  final ManageNewsController manageNewsController =
      Get.put(ManageNewsController());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());
  final QuestionAnswerController questionAnswerController =
      Get.put(QuestionAnswerController());
  dynamic post;

  RxBool isFollowing = false.obs;
  RxBool isBookmarked = false.obs;

  void deletePost(int index) {
    setState(() {
      postList.removeAt(index);
    });
  }

  void _toggleFollow() async {
    final userId = post.id ?? 0;

    try {
      // Fetch current follow status
      bool followStatus = await _fetchFollowStatus(userId);

      // Defer the state update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isFollowing.value = !followStatus;
      });

      // Call the API to toggle the follow status
      // ignore: use_build_context_synchronously
      await editPostController.toggleProfileFollow(userId, context);
    } catch (e) {
      // Handle API errors
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<bool> _fetchFollowStatus(int userId) async {
    return false;
  }

  void _toggleBookmark() async {
    final userId = post.id ?? 0;

    try {
      // Fetch current bookmark status
      bool bookmarkStatus = await _fetchBookmarkStatus(userId);

      // Defer the state update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isBookmarked.value = !bookmarkStatus;
      });

      // Call the API to toggle the bookmark status
      // ignore: use_build_context_synchronously
      await editPostController.toggleProfileBookMark(userId, context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<bool> _fetchBookmarkStatus(int userId) async {
    return false;
  }

  @override
  void initState() {
    super.initState();

    post = Get.arguments;
    if (post != null && post.id != null) {
      databaseController.fetchUserPost(post.id!, context);
    }

    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.fetchUserAllPost(
        1,
        post.id ?? 0,
      );
      editPostController.countViewUserProfile(post.id ?? 0, context);
      bool bookmarkStatus = post.favStatus ?? false;
      isBookmarked.value = bookmarkStatus;
      bool followStatus = post.followStatus ?? false;
      isFollowing.value = followStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: const Align(
              alignment: Alignment.topLeft, child: CustomBackButton()),
        ),
        elevation: 0,
        title: Text(
          'User Profile',
          style: textStyleW700(size.width * 0.048, AppColors.blackText),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() => IconButton(
                  icon: SvgPicture.asset(
                    isBookmarked.value
                        ? Assets.svgCheckBookmark
                        : Assets.svgSavePost,
                    height: size.height * 0.028,
                  ),
                  onPressed: _toggleBookmark,
                )),
          ),
        ],
      ),
      body: Column(
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
                        _showFullScreenDialog(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: CachedNetworkImage(
                          imageUrl: post.imageUrl ?? Assets.imagesIcon,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    30.sbw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title ?? 'N/A',
                            style: textStyleW700(
                                size.width * 0.045, AppColors.blackText),
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
                            style: textStyleW500(
                                size.width * 0.035, AppColors.blackText),
                          ),
                          Text(
                            post.plan ?? 'N/A',
                            style: textStyleW500(
                                size.width * 0.035, AppColors.blackText),
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
                    children: [
                      Obx(
                        () => SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                            ),
                            onPressed: _toggleFollow,
                            child: Text(
                              isFollowing.value ? 'Unfollow' : 'Follow',
                              style: textStyleW700(
                                  size.width * 0.030, AppColors.white),
                            ),
                          ),
                        ),
                      ),
                      20.sbw,
                      Row(
                        children: [
                          Column(
                            children: [
                              // Text(
                              //   mlmDatabaseList.followersCount.toString(),
                              //   style: textStyleW700(
                              //       size.width * 0.045, AppColors.blackText),
                              // ),
                              Text(
                                'Followers',
                                style: textStyleW500(
                                    size.width * 0.035, AppColors.blackText),
                              ),
                            ],
                          ),
                          20.sbw,
                          Column(
                            children: [
                              // Text(
                              //   mlmDatabaseList.followingCount.toString(),
                              //   style: textStyleW700(
                              //       size.width * 0.045, AppColors.blackText),
                              // ),
                              Text(
                                'Following',
                                style: textStyleW500(
                                    size.width * 0.035, AppColors.blackText),
                              ),
                            ],
                          ),
                          20.sbw,
                          Column(
                            children: [
                              // Text(
                              //   post.views.toString(),
                              //   style: textStyleW700(
                              //       size.width * 0.045, AppColors.blackText),
                              // ),
                              Text(
                                'Profile Visits',
                                style: textStyleW500(
                                    size.width * 0.035, AppColors.blackText),
                              ),
                            ],
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
                      const SocialButton(
                          icon: Assets.svgCalling, label: 'Call'),
                      10.sbw,
                      InkWell(
                        onTap: () async {
                          final post =
                              databaseController.mlmDetailsDatabaseList[0];

                          await messageController
                              .fetchMyChatDetail(post.chatId.toString());
                          Get.toNamed(
                            Routes.messagedetailscreen,
                            arguments: post,
                          );
                        },
                        child: const SocialButton(
                          icon: Assets.svgChat,
                          label: 'Message',
                        ),
                      ),
                      10.sbw,
                      const SocialButton(
                          icon: Assets.svgWhatsappIcon, label: 'WhatsApp'),
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
              tabs: const [
                Tab(text: 'Posts (22)'),
                Tab(text: 'About Me'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: CustomScrollView(
                    slivers: [
                      Obx(() {
                        if (controller.isLoading.value &&
                            controller.postallList.isEmpty) {
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
                        if (controller.postallList.isEmpty) {
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
                              if (index == controller.postallList.length) {
                                return Center(
                                  child: CustomLottieAnimation(
                                    child: Lottie.asset(
                                      Assets.lottieLottie,
                                    ),
                                  ),
                                );
                              }
                              final post = controller.postallList[index];
                              Widget cardWidget;
                              switch (post.type) {
                                case 'classified':
                                  cardWidget = ClassifiedUserCard(
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
                            childCount: controller.postallList.length +
                                (controller.isLoading.value ? 1 : 0),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Column(
                    children: [
                      AboutUserSection(size: size),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: NormalButton(
      //   onPressed: () async {
      //     await controller.fetchUserAllPost(
      //       1,
      //       databaseController.mlmDatabaseList[0].id ?? 0,
      //     );
      //   },
      //   text: 'refresh',
      // ),
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

  void _showFullScreenDialog(BuildContext context) {
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
                  child: Image.network(
                    '${post.imageUrl.toString()}?${DateTime.now().millisecondsSinceEpoch}',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.black),
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
  }
}
