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

class UserProfileScreenCopy extends StatefulWidget {
  const UserProfileScreenCopy({super.key});

  @override
  State<UserProfileScreenCopy> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreenCopy>
    with SingleTickerProviderStateMixin {
  dynamic post;
  final EditPostController editPostController = Get.put(EditPostController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

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

  final ProfileController profileController = Get.put(ProfileController());
  RxBool isExpanded = true.obs;

  late TabController _tabController;

  RxBool isFollowing = false.obs;
  RxBool isBookmarked = false.obs;

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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    post = Get.arguments;
    if (kDebugMode) {
      print('postargs: $post');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Check if post is null before accessing its properties
    if (post == null) {
      // Handle case where post is null, for example, show a loading indicator
      return Scaffold(
        body: Center(
          child: CustomLottieAnimation(
            child: Lottie.asset(
              Assets.lottieLottie,
            ),
          ),
        ),
      );
    }
    final userProfile = profileController.userProfile.value.userProfile;
    // Build UI with post data
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
                        _showFullScreenDialog(context);
                      },
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: post.imageUrl ?? Assets.imagesAdminlogo,
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                          errorWidget: (context, url, error) => Image.asset(
                            Assets.imagesAdminlogo,
                            fit: BoxFit
                                .cover, // Ensure the error image also uses BoxFit.cover
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
                          20.sbw,
                          Column(
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
                          20.sbw,
                          Column(
                            children: [
                              Text(
                                post.pgcnt.toString(),
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
                          if (post.mobile == null || post.mobile!.isEmpty) {
                            showToasterrorborder('No Any Url Found', context);
                            if (kDebugMode) {
                              print('tap without number');
                            }
                          } else {
                            final Uri phoneUri = Uri(
                                scheme: 'tel',
                                path: '+${post.countrycode1} ${post.mobile}');
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
                            final post = messageController.chatList[0];

                            Get.toNamed(Routes.messagedetailscreen,
                                arguments: post);
                          } else {
                            // If chat list is empty, navigate to screen with a dummy post or handle accordingly
                            final dummyPost = {
                              "chatId": null,
                              "toid": post.id,
                              "username": post.title,
                              "imageUrl": post.imageUrl,
                            };
                            Get.toNamed(Routes.usermessagedetailscreen,
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
                          if (post.mobile != null &&
                              post.countrycode1 != null) {
                            final String phoneNumber = post.mobile!;
                            final String countryCode =
                                post.countrycode1!.trim();

                            // Ensure the country code includes the '+' prefix
                            final String formattedCountryCode =
                                countryCode.startsWith('+')
                                    ? countryCode
                                    : '+$countryCode';
                            final String username = post.name.toString();
                            final String yourname =
                                userProfile!.name.toString();

                            String message =
                                "Hello $username, I’m $yourname. I saw your profile on MLM Diary and would love to know more about you. Looking forward to connecting!";
                            final Uri whatsappUri = Uri.parse(
                                "https://wa.me/${formattedCountryCode.replaceAll(' ', '')}$phoneNumber?text=${Uri.encodeComponent(message)}");

                            if (await canLaunchUrl(whatsappUri)) {
                              await launchUrl(whatsappUri);
                              if (kDebugMode) {
                                print('URL: $whatsappUri');
                              }
                            } else {
                              if (kDebugMode) {
                                print('Could not launch $whatsappUri');
                              }
                              showToasterrorborder(
                                  "Could not launch WhatsApp",
                                  // ignore: use_build_context_synchronously
                                  context);
                            }
                          } else {
                            showToasterrorborder(
                                "No valid phone number or country code found",
                                context);
                          }
                        },
                        child: const SocialButton(
                            icon: Assets.svgWhatsappIcon, label: 'WhatsApp'),
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
                Tab(text: 'Posts (${post.totalPost})'),
                const Tab(text: 'About Me'),
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
                        if (userProfileController.isLoading.value &&
                            userProfileController.postallList.isEmpty) {
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
                        if (userProfileController.postallList.isEmpty) {
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
                                  userProfileController.postallList.length) {
                                return Center(
                                  child: CustomLottieAnimation(
                                    child: Lottie.asset(
                                      Assets.lottieLottie,
                                    ),
                                  ),
                                );
                              }
                              final post =
                                  userProfileController.postallList[index];
                              Widget cardWidget;
                              switch (post.type) {
                                case 'classified':
                                  cardWidget = ClassifiedUserCard(
                                    updatedateTime: post.datemodified ?? '',
                                    userImage: post.userData?.imagePath ?? '',
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
                                    updatedateTime: post.datemodified ?? '',
                                    userImage: post.userData?.imagePath ?? '',
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
                                    updatedateTime: post.datemodified ?? '',
                                    userImage: post.userData?.imagePath ?? '',
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
                                    updatedateTime: post.datemodified ?? '',
                                    userImage: post.userData?.imagePath ?? '',
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
                                    updatedateTime: post.datemodified ?? '',
                                    userImage: post.userData?.imagePath ?? '',
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
                            childCount: userProfileController
                                    .postallList.length +
                                (userProfileController.isLoading.value ? 1 : 0),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Follow me on',
                                      style: textStyleW400(
                                          size.width * 0.035, AppColors.grey)),
                                  15.sbh,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          if (post.wplink == null ||
                                              post.wplink!.isEmpty) {
                                            showToasterrorborder(
                                                'No Any Url Found', context);
                                          } else {
                                            launchUrl(
                                              Uri.parse(post.wplink.toString()),
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
                                                'No Any Url Found', context);
                                          } else {
                                            launchUrl(
                                              Uri.parse(post.fblink.toString()),
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
                                          if (post.instalink == null ||
                                              post.instalink!.isEmpty) {
                                            showToasterrorborder(
                                                'No Any Url Found', context);
                                          } else {
                                            launchUrl(
                                              Uri.parse(
                                                  post.instalink.toString()),
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
                                                'No Any Url Found', context);
                                          } else {
                                            launchUrl(
                                              Uri.parse(post.lilink.toString()),
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
                                                'No Any Url Found', context);
                                          } else {
                                            launchUrl(
                                              Uri.parse(
                                                  post.youlink.toString()),
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
                                                'No Any Url Found', context);
                                          } else {
                                            launchUrl(
                                              Uri.parse(post.telink.toString()),
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
                                          if (post.twiterlink == null ||
                                              post.twiterlink!.isEmpty) {
                                            showToasterrorborder(
                                                'No Any Url Found', context);
                                          } else {
                                            launchUrl(
                                              Uri.parse(
                                                  post.twiterlink.toString()),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About me',
                                  style: textStyleW400(
                                      size.width * 0.035, AppColors.grey)),
                              // Text(
                              //   post.aboutyou ?? 'N/A',
                              //   style: textStyleW500(
                              //       size.width * 0.035, AppColors.blackText),
                              // ),
                            ],
                          ),
                        ),
                        10.sbh,
                        const Divider(color: Colors.grey),
                        10.sbh,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About Company',
                                  style: textStyleW400(
                                      size.width * 0.035, AppColors.grey)),
                              // Text(
                              //   post.aboutcompany ?? 'N/A',
                              //   style: textStyleW500(
                              //       size.width * 0.035, AppColors.blackText),
                              // ),
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
