import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/my_profile_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/profile_shimmer/axis_scroll_shimmer.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/profile_shimmer/personal_info_shimmer.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';
import 'dart:io' as io;

import 'package:url_launcher/url_launcher.dart';

class UserProfileScreenCopy extends StatefulWidget {
  final int userId;
  const UserProfileScreenCopy({super.key, required this.userId});

  @override
  State<UserProfileScreenCopy> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreenCopy>
    with SingleTickerProviderStateMixin {
  final ProfileController profileController = Get.put(ProfileController());
  final EditPostController editPostController = Get.put(EditPostController());
  final DatabaseController controller = Get.put(DatabaseController());

  late ScrollController _viewersScrollController;

  bool isFetchingViewrs = false;

  final RxBool showShimmer = true.obs;
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  Rx<io.File?> file = Rx<io.File?>(null);
  static List<io.File> imagesList = <io.File>[];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _viewersScrollController = ScrollController();

    Future.delayed(const Duration(seconds: 1), () {
      showShimmer.value = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserIdAndRefreshViews();
    });
  }

  Future<void> _fetchUserIdAndRefreshViews() async {
    _refreshViews();
    _viewersScrollController.addListener(() {
      if (_viewersScrollController.position.pixels ==
          _viewersScrollController.position.maxScrollExtent) {
        _loadMoreViewers();
      }
    });
  }

  Future<void> _loadMoreViewers() async {
    if (!isFetchingViewrs) {
      isFetchingViewrs = true;
      int nextPage = (userProfileController.views.length ~/ 10) +
          1; // Assuming 10 items per page
      await userProfileController.getViews(nextPage, widget.userId);
      isFetchingViewrs = false;
    }
  }

  void deletePost(int index) async {
    int postId = editPostController.myPostList[index].id ?? 0;
    await editPostController.deletePost(postId, index, context);
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
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    showShimmer.value
                        ? const PersonalInfoShimmer()
                        : personlaInfo(),
                    5.sbh,
                    showShimmer.value
                        ? AxisScrollShimmer(
                            width: size.width,
                          )
                        : axisScroll(),
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
                  Obx(() => Tab(text: 'Posts ${profileController.post}')),
                  const Tab(text: 'About Me'),
                ],
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        posts(),
                        8.sbh,
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
                                controller.isLoading.value
                                    ? 'Loading...'
                                    : 'Post not found',
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
                                final post =
                                    editPostController.myPostList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
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
                  SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: Column(
                      children: [
                        aboutMe(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget aboutMe() {
    final Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (profileController.userProfiles.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          final userProfile = profileController.userProfiles[index];

          return Container(
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
                        style:
                            textStyleW400(size.width * 0.035, AppColors.grey),
                      ),
                      10.sbh,
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (userProfile.website == null ||
                                    userProfile.website!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(userProfile.website.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.compWebsite == null ||
                                    userProfile.compWebsite!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(
                                        userProfile.compWebsite.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.wplink == null ||
                                    userProfile.wplink!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(userProfile.wplink.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.fblink == null ||
                                    userProfile.fblink!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(userProfile.fblink.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.instalink == null ||
                                    userProfile.instalink!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(userProfile.instalink.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.lilink == null ||
                                    userProfile.lilink!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(userProfile.lilink.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.youlink == null ||
                                    userProfile.youlink!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(userProfile.youlink.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.telink == null ||
                                    userProfile.telink!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(userProfile.telink.toString()),
                                    mode: LaunchMode.externalApplication,
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
                                if (userProfile.twiterlink == null ||
                                    userProfile.twiterlink!.isEmpty) {
                                  showToasterrorborder(
                                      'No Any Url Found', context);
                                } else {
                                  launchUrl(
                                    Uri.parse(
                                        userProfile.twiterlink.toString()),
                                    mode: LaunchMode.externalApplication,
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
                      Text(
                        userProfile.aboutyou ?? 'N/A',
                        style: textStyleW500(
                            size.width * 0.035, AppColors.blackText),
                      ),
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
                      Text(
                        userProfile.aboutcompany ?? 'N/A',
                        style: textStyleW500(
                            size.width * 0.035, AppColors.blackText),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.017),
              ],
            ),
          );
        },
      );
    });
  }

  Widget personlaInfo() {
    final Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (profileController.userProfiles.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          final post = profileController.userProfiles[index];

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
                                child: Image.network(
                                  '${post.imagePath.toString()}?${DateTime.now().millisecondsSinceEpoch}',
                                  fit: BoxFit.contain,
                                  width: MediaQuery.of(context).size.width,
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
                    imageUrl: post.imagePath ?? Assets.imagesAdminlogo,
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
      if (profileController.userProfiles.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, index) {
            final post = profileController.userProfiles[index];

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
                        style:
                            textStyleW700(size.width * 0.030, AppColors.white),
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
                              Get.toNamed(Routes.followers);
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
                            builder: (context) => buildTabBarView(),
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

  Future<void> _refreshViews() async {
    userProfileController.views.clear();
    await userProfileController.getViews(1, widget.userId);
  }

  Widget buildTabBarView() {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 80,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // ignore: deprecated_member_use
                color: AppColors.grey.withOpacity(0.5),
              ),
            ),
          ),
          3.sbh,
          Text(
            'Profile Visits',
            style: textStyleW700(size.width * 0.043, AppColors.blackText),
          ),
          3.sbh,
          Expanded(
            child: Obx(() {
              if (userProfileController.views.isEmpty) {
                return const Center(child: Text('No Views'));
              }

              return ListView.builder(
                controller: _viewersScrollController,
                itemCount: userProfileController.views.length,
                itemBuilder: (context, index) {
                  var viewers = userProfileController.views[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () async {
                        Get.toNamed(Routes.userprofilescreen, arguments: {
                          'user_id': viewers.id,
                        })!
                            .then((_) {
                          _refreshViews();
                        });

                        await userProfileController.fetchUserAllPost(
                          1,
                          viewers.id.toString(),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: viewers
                                                    .userimageUrl.isNotEmpty ==
                                                true
                                            ? NetworkImage(viewers.userimageUrl)
                                            : const AssetImage(
                                                    'assets/more.png')
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      shape: const OvalBorder(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
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
                                        ),
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
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget posts() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Obx(() {
                String text = editPostController.comments.value.text;
                Color borderColor =
                    text.isEmpty ? Colors.black26 : Colors.green;

                return TextField(
                  style: TextStyle(color: AppColors.blackText, fontSize: 14),
                  controller: editPostController.comments.value,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    editPostController.comments.refresh();
                  },
                  onSubmitted: (value) {
                    editPostController.comments.refresh();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              if (file.value == null) {
                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => bottomsheet(),
                                );
                              } else {
                                showToasterrorborder(
                                    'Select only one image', context);
                              }
                            },
                            child: file.value == null
                                ? SvgPicture.asset(
                                    Assets.svgImage,
                                    height: 30,
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          file.value!,
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: -2,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              imagesList.remove(file.value);
                                              file.value = null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: AppColors.redText,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          10.sbw,
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (editPostController
                                  .comments.value.text.isEmpty) {
                                showToasterrorborder(
                                    'Please First Write Something', context);
                                editPostController.comments.refresh();
                              } else {
                                editPostController.addPost(
                                  imageFile: file.value,
                                );
                                editPostController.comments.refresh();
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Post',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackText,
                                  ),
                                ),
                                const Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Write Something',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      // ignore: deprecated_member_use
                      color: AppColors.blackText.withOpacity(0.5),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 18.0, color: AppColors.blackText),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takephoto(
                      ImageSource.camera,
                    );
                  },
                  icon: Icon(Icons.camera, color: AppColors.primaryColor),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
              TextButton.icon(
                  onPressed: () {
                    takephoto(
                      ImageSource.gallery,
                    );
                  },
                  icon: Icon(Icons.image, color: AppColors.primaryColor),
                  label: Text(
                    'Gallary',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void takephoto(ImageSource imageSource) async {
    final pickedfile =
        await _picker.pickImage(source: imageSource, imageQuality: 100);
    if (pickedfile != null) {
      io.File imageFile = io.File(pickedfile.path);
      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInKB = fileSizeInBytes / 1024;

      if (kDebugMode) {
        print('Original image size: $fileSizeInKB KB');
      }

      if (fileSizeInKB > 5000) {
        // ignore: use_build_context_synchronously
        showToasterrorborder('Please Select an image below 5 MB', context);
        return;
      }

      io.File? processedFile = imageFile;

      if (fileSizeInKB > 250) {
        processedFile = await _cropImage(imageFile);
        if (processedFile == null) {
          // ignore: use_build_context_synchronously
          showToasterrorborder('Please select an image', context);
          if (kDebugMode) {
            print('failed to compress image');
          }
          return;
        }
        processedFile = await _compressImage(processedFile);
      }

      double processedFileSizeInKB = processedFile!.lengthSync() / 1024;
      if (kDebugMode) {
        print('Processed image size: $processedFileSizeInKB KB');
      }

      setState(() {
        file.value = processedFile;
      });

      if (file.value != null) {
        imagesList.add(file.value!);
      }

      Get.back();
    } else {
      // ignore: use_build_context_synchronously
      showToasterrorborder('Please select an image', context);
      return;
    }
  }

  Future<io.File?> _cropImage(io.File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      return io.File(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<io.File?> _compressImage(io.File imageFile) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.path}/temp.jpg';

    int quality = 90;
    io.File? compressedFile;
    while (true) {
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: quality,
      );

      if (result == null) {
        return null;
      }

      compressedFile = io.File(result.path);
      double fileSizeInKB = compressedFile.lengthSync() / 1024;

      if (fileSizeInKB <= 250 && fileSizeInKB >= 200) {
        break;
      }

      if (fileSizeInKB < 200) {
        quality += 5;
      } else {
        quality -= 5;
      }

      if (quality <= 0 || quality > 100) {
        break;
      }
    }

    return compressedFile;
  }
}
