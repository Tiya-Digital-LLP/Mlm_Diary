import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/followers/controller/followers_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> with TickerProviderStateMixin {
  late TabController _tabController;
  final FollowersController controller = Get.put(FollowersController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _refreshFollowers();
    _refreshFollowing();
  }

  Future<void> _refreshFollowers() async {
    await controller.getFollowers(1);
  }

  Future<void> _refreshFollowing() async {
    await controller.getFollowing(1);
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
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Followers',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(42.26),
                  color: AppColors.primaryColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Obx(() => Tab(
                      text: 'Followers (${controller.followersCount.value})')),
                  Obx(() => Tab(
                      text: 'Following (${controller.followingCount.value})')),
                ],
              ),
            ),
            30.sbh,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFollowersTab(size),
                  _buildFollowingTab(size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowersTab(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomSearchInput(
            controller: controller.search,
            onSubmitted: (value) {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              _refreshFollowers();
            },
            onChanged: (value) {
              _refreshFollowers();
            },
          ),
        ),
        20.sbh,
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshFollowers,
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: CustomLottieAnimation(
                  child: Lottie.asset(
                    Assets.lottieLottie,
                  ),
                ));
              }
              if (controller.followers.isEmpty) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: CustomLottieAnimation(
                    child: Lottie.asset(Assets.lottieLottie),
                  ),
                );
              } else {
                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.followers.length +
                      (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.followers.length) {
                      return Center(
                          child: CustomLottieAnimation(
                        child: Lottie.asset(
                          Assets.lottieLottie,
                        ),
                      ));
                    }
                    final follower = controller.followers[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                await userProfileController.fetchUserAllPost(
                                  1,
                                  follower.id ?? 0,
                                );
                                Get.toNamed(
                                  Routes.userprofilescreencopy,
                                  arguments: follower,
                                );
                              },
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      follower.imageUrl ?? Assets.imagesIcon,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                  placeholder: (context, url) => Container(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            20.sbw,
                            Expanded(
                              child: Text(
                                follower.name ?? 'Unknown',
                                style: textStyleW700(
                                    size.width * 0.030, AppColors.blackText),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: follower.isFollowing ?? false
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  controller.toggleProfileFollow(
                                      follower.id ?? 0, context);
                                },
                                child: Text(
                                  follower.isFollowing ?? false
                                      ? 'Following'
                                      : 'Follow',
                                  style: textStyleW700(
                                      size.width * 0.030, AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFollowingTab(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomSearchInput(
            controller: controller.search,
            onSubmitted: (value) {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              _refreshFollowing();
            },
            onChanged: (value) {
              _refreshFollowing();
            },
          ),
        ),
        20.sbh,
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshFollowing,
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: CustomLottieAnimation(
                  child: Lottie.asset(
                    Assets.lottieLottie,
                  ),
                ));
              }
              if (controller.following.isEmpty &&
                  controller.isEndOfData.value) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'No following found.',
                    style:
                        textStyleW700(size.width * 0.030, AppColors.blackText),
                  ),
                );
              } else {
                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.following.length +
                      (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.following.length) {
                      return Center(
                          child: CustomLottieAnimation(
                        child: Lottie.asset(
                          Assets.lottieLottie,
                        ),
                      ));
                    }
                    final following = controller.following[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                Get.toNamed(
                                  Routes.userprofilescreencopy,
                                  arguments: following,
                                );
                                await userProfileController.fetchUserAllPost(
                                  1,
                                  following.id ?? 0,
                                );
                              },
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      following.imageUrl ?? Assets.imagesIcon,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                  placeholder: (context, url) => Container(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            20.sbw,
                            Expanded(
                              child: Text(
                                following.name ?? 'Unknown',
                                style: textStyleW700(
                                    size.width * 0.030, AppColors.blackText),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      following.isFollowing ?? false
                                          ? AppColors.primaryColor
                                          : Colors.grey,
                                ),
                                onPressed: () {
                                  controller.toggleProfileFollow(
                                      following.id ?? 0, context);
                                },
                                child: Text(
                                  following.isFollowing ?? false
                                      ? 'Following'
                                      : 'Follow',
                                  style: textStyleW700(
                                      size.width * 0.030, AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
