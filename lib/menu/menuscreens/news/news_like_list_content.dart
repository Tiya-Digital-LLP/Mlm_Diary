import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class NewsLikeListContent extends StatefulWidget {
  final int newsId;

  const NewsLikeListContent({super.key, required this.newsId});

  @override
  State<NewsLikeListContent> createState() =>
      _ClassifiedLikedListContentState();
}

class _ClassifiedLikedListContentState extends State<NewsLikeListContent> {
  final ManageNewsController controller = Get.put(ManageNewsController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchLikeListNews(widget.newsId, 1, context);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isEndOfNewsLikeListData.value &&
          !controller.isLoading.value) {
        int nextPage = (controller.newsLikeList.length ~/ 10) + 1;
        controller.fetchLikeListNews(
          widget.newsId,
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
                      controller.newsLikeList.isEmpty) {
                    return Center(
                      child: CustomLottieAnimation(
                        child: Lottie.asset(Assets.lottieLottie),
                      ),
                    );
                  }

                  if (controller.newsLikeList.isEmpty) {
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
                    itemCount: controller.newsLikeList.length +
                        (controller.isLoading.value ? 1 : 0),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == controller.newsLikeList.length) {
                        return Center(
                          child: CustomLottieAnimation(
                            child: Lottie.asset(
                              Assets.lottieLottie,
                            ),
                          ),
                        );
                      }
                      final post = controller.newsLikeList[index];
                      return Card(
                        color: Colors.white,
                        elevation: 4,
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
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: post.userData?.imagePath ??
                                        Assets.imagesAdminlogo,
                                    fit: BoxFit.cover,
                                    height: 50,
                                    width: 50,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      Assets.imagesAdminlogo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                8.sbw,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (post.userData?.name?.isNotEmpty ??
                                                false)
                                            ? post.userData!.name!
                                            : 'Not Type Name',
                                        style: textStyleW500(size.width * 0.034,
                                            AppColors.blackText),
                                      ),
                                      2.sbh,
                                      Text(
                                        () {
                                          final addressParts = [
                                            post.userData?.city?.trim(),
                                            post.userData?.state?.trim(),
                                            post.userData?.country?.trim(),
                                          ]
                                              .where((e) =>
                                                  e != null && e.isNotEmpty)
                                              .toList();

                                          return addressParts.isNotEmpty
                                              ? addressParts.join(', ')
                                              : 'Not Type Address';
                                        }(),
                                        style: textStyleW500(
                                          size.width * 0.030,
                                          // ignore: deprecated_member_use
                                          AppColors.blackText.withOpacity(0.6),
                                        ),
                                      ),
                                      2.sbh,
                                      Text(
                                        (post.userData?.immlm
                                                    ?.trim()
                                                    .isNotEmpty ??
                                                false)
                                            ? post.userData!.immlm!.trim()
                                            : 'Not Type IMMLM',
                                        style: textStyleW500(
                                          size.width * 0.030,
                                          AppColors.blackText,
                                        ),
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
