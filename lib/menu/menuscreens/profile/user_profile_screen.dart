import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/about_user.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/social_button.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/user_profie_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';

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
  final EditPostController controller = Get.put(EditPostController());
  final DatabaseController databaseController = Get.put(DatabaseController());
  final MessageController messageController = Get.put(MessageController());

  dynamic mlmDatabaseList;

  RxBool isFollowing = false.obs;
  RxBool isBookmarked = false.obs;

  void deletePost(int index) {
    setState(() {
      postList.removeAt(index);
    });
  }

  void _toggleFollow() async {
    final userId = mlmDatabaseList.id ?? 0;

    try {
      // Fetch current follow status
      bool followStatus = await _fetchFollowStatus(userId);

      // Defer the state update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isFollowing.value = !followStatus;
      });

      // Call the API to toggle the follow status
      // ignore: use_build_context_synchronously
      await controller.toggleProfileFollow(userId, context);
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
    final userId = mlmDatabaseList.id ?? 0;

    try {
      // Fetch current bookmark status
      bool bookmarkStatus = await _fetchBookmarkStatus(userId);

      // Defer the state update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isBookmarked.value = !bookmarkStatus;
      });

      // Call the API to toggle the bookmark status
      // ignore: use_build_context_synchronously
      await controller.toggleProfileBookMark(userId, context);
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
    mlmDatabaseList = Get.arguments;
    if (mlmDatabaseList != null && mlmDatabaseList.id != null) {
      databaseController.fetchUserPost(mlmDatabaseList.id!, context);
    }
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.countViewUserProfile(mlmDatabaseList.id ?? 0, context);
      RxBool bookmarkStatus = mlmDatabaseList.favStatus ?? false;
      isBookmarked.value = bookmarkStatus.value;
      bool followStatus = mlmDatabaseList.followStatus ?? false;
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
                          imageUrl:
                              mlmDatabaseList.imageUrl ?? Assets.imagesIcon,
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
                            mlmDatabaseList.title ?? 'N/A',
                            style: textStyleW700(
                                size.width * 0.045, AppColors.blackText),
                          ),
                          Text(
                            '${mlmDatabaseList.city ?? 'N/A'}, ${mlmDatabaseList.state ?? 'N/A'}, ${mlmDatabaseList.country ?? 'N/A'}',
                            style: textStyleW500(
                              size.width * 0.035,
                              AppColors.blackText,
                            ),
                          ),
                          Text(
                            mlmDatabaseList.company ?? 'N/A',
                            style: textStyleW500(
                                size.width * 0.035, AppColors.blackText),
                          ),
                          Text(
                            mlmDatabaseList.plan ?? 'N/A',
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
                              Text(
                                mlmDatabaseList.followersCount.toString(),
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
                                mlmDatabaseList.followingCount.toString(),
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
                                mlmDatabaseList.views.toString(),
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
                      const SocialButton(
                          icon: Assets.svgCalling, label: 'Call'),
                      10.sbw,
                      InkWell(
                        onTap: () async {
                          Get.toNamed(Routes.messagedetailscreen,
                              arguments: mlmDatabaseList);
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
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      final post = postList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: UserProfileCard(
                          onDelete: () => deletePost(index),
                          userImage: post.userImage,
                          userName: post.userName,
                          postCaption: post.postCaption,
                          postImage: post.postImage,
                        ),
                      );
                    },
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
    );
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
                    '${mlmDatabaseList.imageUrl.toString()}?${DateTime.now().millisecondsSinceEpoch}',
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
