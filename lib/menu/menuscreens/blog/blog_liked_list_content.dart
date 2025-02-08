import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class BlogLikedListContent extends StatefulWidget {
  final int blogId;

  const BlogLikedListContent({super.key, required this.blogId});

  @override
  State<BlogLikedListContent> createState() =>
      _ClassifiedLikedListContentState();
}

class _ClassifiedLikedListContentState extends State<BlogLikedListContent> {
  final ManageBlogController controller = Get.put(ManageBlogController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchLikeListBlog(widget.blogId, 1, context);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isEndOfBlogLikeListData.value &&
          !controller.isLoading.value) {
        int nextPage = (controller.blogLikeList.length ~/ 10) + 1;
        controller.fetchLikeListBlog(
          widget.blogId,
          nextPage,
          context,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value &&
                      controller.blogLikeList.isEmpty) {
                    return Center(
                      child: CustomLottieAnimation(
                        child: Lottie.asset(Assets.lottieLottie),
                      ),
                    );
                  }

                  if (controller.blogLikeList.isEmpty) {
                    return Center(
                      child: Text(
                        "No Data Found",
                        style: textStyleW500(
                            size.width * 0.04, AppColors.blackText),
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.blogLikeList.length +
                        (controller.isLoading.value ? 1 : 0),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == controller.blogLikeList.length) {
                        return Center(
                          child: CustomLottieAnimation(
                            child: Lottie.asset(
                              Assets.lottieLottie,
                            ),
                          ),
                        );
                      }
                      final post = controller.blogLikeList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: InkWell(
                            onTap: () async {
                              Get.toNamed(Routes.userprofilescreen, arguments: {
                                'user_id': post.userid ?? 0,
                              });
                              await userProfileController.fetchUserAllPost(
                                1,
                                post.userid.toString(),
                              );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      post.userData?.imagePath ?? ''),
                                ),
                                8.sbw,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.userData?.name ?? 'Unknown',
                                        style: textStyleW500(size.width * 0.034,
                                            AppColors.blackText),
                                      ),
                                      2.sbh,
                                      Text(
                                        'Ahemdabad, Gujarat, India',
                                        style: textStyleW500(
                                            size.width * 0.030,
                                            AppColors.blackText
                                                // ignore: deprecated_member_use
                                                .withOpacity(0.6)),
                                      ),
                                      2.sbh,
                                      Text(
                                        'Leader',
                                        style: textStyleW500(size.width * 0.030,
                                            AppColors.blackText),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          side: BorderSide(color: AppColors.redText),
                        ),
                        child: Text(
                          'Cancel',
                          style: textStyleW700(
                              size.width * 0.04, AppColors.redText),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
