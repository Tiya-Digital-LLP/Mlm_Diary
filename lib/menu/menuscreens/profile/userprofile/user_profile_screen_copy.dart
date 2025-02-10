import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';

import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/my_profile_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/social_button.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/profile_shimmer/personal_info_shimmer.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';

class UserProfileScreenCopy extends StatefulWidget {
  const UserProfileScreenCopy({super.key});

  @override
  State<UserProfileScreenCopy> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreenCopy>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final ProfileController profileController = Get.put(ProfileController());
  final EditPostController editPostController = Get.put(EditPostController());

  RxList<GetUserProfileUserProfile> getUserProfile =
      <GetUserProfileUserProfile>[].obs;
  final RxBool showShimmer = true.obs;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      showShimmer.value = false;
    });
    controller = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.fetchUserProfile();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void deletePost(int index) async {
    int newsId = editPostController.myPostList[index].id ?? 0;
    await editPostController.deletePost(newsId, index, context);
  }

  @override
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => Column(
                  children: [
                    showShimmer.value
                        ? const PersonalInfoShimmer()
                        : ListView.builder(
                            itemCount: getUserProfile.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return personalInfo(context, index);
                            },
                          ),
                    20.sbh,
                  ],
                ),
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
              tabs: const [
                Tab(text: 'Posts'),
                Tab(text: 'About Me'),
              ],
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        if (editPostController.isLoading.value &&
                            editPostController.myPostList.isEmpty) {
                          return Center(
                              child: CustomLottieAnimation(
                            child: Lottie.asset(
                              Assets.lottieLottie,
                            ),
                          ));
                        }

                        if (editPostController.myPostList.isEmpty) {
                          return Center(
                            child: Text(
                              editPostController.isLoading.value
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: editPostController.myPostList.length,
                            itemBuilder: (context, index) {
                              final post = editPostController.myPostList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.mypostdetails,
                                      arguments: post,
                                    );
                                  },
                                  child: MyProfileCard(
                                    updatedateTime: post.datemodified ?? '',
                                    onDelete: () => deletePost(index),
                                    userImage: post.userData!.imagePath ?? '',
                                    userName: post.userData!.name ?? '',
                                    postCaption: post.comments ?? '',
                                    postImage: post.attachmentPath ?? '',
                                    dateTime: post.createdate ?? '',
                                    likedCount: post.totallike ?? 0,
                                    postId: post.id ?? 0,
                                    controller: editPostController,
                                    bookmarkCount: post.totalbookmark ?? 0,
                                    commentcount: post.totalcomment ?? 0,
                                    viewCount: post.pgcnt ?? 0,
                                  ),
                                ),
                              );
                            });
                      }),
                    ],
                  ),
                ),
                const SingleChildScrollView(
                  padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Column(
                    children: [Text('About Me')],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(30)),
        width: 130,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.messagescreen);
          },
          child: const SocialButton(icon: Assets.svgChat, label: 'Message'),
        ),
      ),
    );
  }

  Widget personalInfo(BuildContext context, int index) {
    final Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (getUserProfile.isEmpty ||
          index < 0 ||
          index >= getUserProfile.length) {
        return const SizedBox();
      }
      final userProfile = getUserProfile[index];

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (userProfile.imagePath?.isNotEmpty == true &&
              Uri.tryParse(userProfile.imagePath!)?.hasAbsolutePath == true)
            InkWell(
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipOval(
                  child: Image.network(
                    '${userProfile.imagePath}?${DateTime.now().millisecondsSinceEpoch}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        Assets.imagesAdminlogo,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoText(userProfile.name, size, isBold: true),
              _infoText(userProfile.immlm, size),
              _infoText(userProfile.company, size),
              _infoText(userProfile.plan, size),
              _infoText(
                '${userProfile.city ?? 'N/A'}, ${userProfile.state ?? 'N/A'}, ${userProfile.country ?? 'N/A'}',
                size,
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _infoText(String? text, Size size, {bool isBold = false}) {
    return Text(
      text ?? 'N/A',
      style: isBold
          ? textStyleW700(size.width * 0.045, AppColors.blackText)
          : textStyleW500(size.width * 0.035, AppColors.blackText),
    );
  }

  Widget axisScroll(int index) {
    final Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (getUserProfile.isEmpty ||
          index < 0 ||
          index >= getUserProfile.length) {
        return const SizedBox(); // Return empty if index is out of bounds
      }
      final userProfile = getUserProfile[index];

      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                    'Edit Profile',
                    style: textStyleW700(size.width * 0.030, AppColors.white),
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
                          Get.toNamed(Routes.followers);
                        },
                        child: Column(
                          children: [
                            Text(
                              userProfile.followersCount.toString(),
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
                          Get.toNamed(Routes.followers);
                        },
                        child: Column(
                          children: [
                            Text(
                              userProfile.followingCount.toString(),
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
                    onTap: () async {},
                    child: Column(
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
                  ),
                ],
              ),
            ],
          ));
    });
  }
}
