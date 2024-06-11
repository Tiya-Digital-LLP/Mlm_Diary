import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/about_me.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/my_profile_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/social_button.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final userProfile = Get.arguments as GetUserProfileUserProfile;
  final EditPostController controller = Get.put(EditPostController());

  RxBool isFollowing = false.obs;

  void deletePost(int index) async {
    int newsId = controller.myPostList[index].id ?? 0;
    await controller.deletePost(newsId, index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Profile',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
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
                          imageUrl: userProfile.userimage ?? Assets.imagesIcon,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfile.name ?? 'N/A',
                          style: textStyleW700(
                              size.width * 0.045, AppColors.blackText),
                        ),
                        Text(
                          '${userProfile.city ?? 'N/A'}, ${userProfile.state ?? 'N/A'}, ${userProfile.country ?? 'N/A'}',
                          style: textStyleW500(
                            size.width * 0.035,
                            AppColors.blackText,
                          ),
                        ),
                        Text(
                          userProfile.company ?? 'N/A',
                          style: textStyleW500(
                              size.width * 0.035, AppColors.blackText),
                        ),
                        Text(
                          userProfile.plan ?? 'N/A',
                          style: textStyleW500(
                              size.width * 0.035, AppColors.blackText),
                        ),
                      ],
                    ),
                  ],
                ),
                20.sbh,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.accountsettingscreen);
                          },
                          child: Text(
                            'Edit',
                            style: textStyleW700(
                                size.width * 0.030, AppColors.white),
                          ),
                        ),
                      ),
                      20.sbw,
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '190',
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
                                '190',
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
                                userProfile.views.toString(),
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
                      const SocialButton(
                          icon: Assets.svgChat, label: 'Message'),
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
                Container(
                  color: AppColors.background,
                  child: Obx(() {
                    if (controller.isLoading.value &&
                        controller.myPostList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.myPostList.isEmpty) {
                      return Center(
                        child: Text(
                          controller.isLoading.value
                              ? 'Loading...'
                              : 'Data not found',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.myPostList.length,
                        itemBuilder: (context, index) {
                          final post = controller.myPostList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: GestureDetector(
                              onTap: () {},
                              child: MyProfileCard(
                                onDelete: () => deletePost(index),
                                userImage: post.userData!.imagePath ?? '',
                                userName: post.userData!.name ?? '',
                                postCaption: post.comments ?? '',
                                postImage: post.attachmentPath ?? '',
                                dateTime: post.createdate ?? '',
                                likedCount: post.totallike ?? 0,
                                postId: post.id ?? 0,
                                controller: controller,
                                bookmarkCount: post.totalbookmark ?? 0,
                              ),
                            ),
                          );
                        });
                  }),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Column(
                    children: [
                      AboutMeSection(size: size),
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
                    '${userProfile.userimage.toString()}?${DateTime.now().millisecondsSinceEpoch}',
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
