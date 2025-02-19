import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class PostViewListContent extends StatefulWidget {
  final int postId;

  const PostViewListContent({super.key, required this.postId});

  @override
  State<PostViewListContent> createState() => _PostViewListContentState();
}

class _PostViewListContentState extends State<PostViewListContent> {
  final EditPostController controller = Get.put(EditPostController());

  final ScrollController scrollController = ScrollController();
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    controller.fetchViewListPost(widget.postId, 1, context);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isEndOfPostViewListData.value &&
          !controller.isLoading.value) {
        int nextPage = (controller.postviewList.length ~/ 10) + 1;
        controller.fetchViewListPost(widget.postId, nextPage, context);
      }
    });
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
                      controller.postviewList.isEmpty) {
                    return Center(
                      child: CustomLottieAnimation(
                        child: Lottie.asset(Assets.lottieLottie),
                      ),
                    );
                  }

                  if (controller.postviewList.isEmpty) {
                    return Center(
                      child: Text(
                        "No Data Found",
                        style: textStyleW500(
                            size.width * 0.04, AppColors.blackText),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.postviewList.length,
                    itemBuilder: (context, index) {
                      var item = controller.postviewList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: InkWell(
                          onTap: () async {
                            // Get.toNamed(Routes.userprofilescreen,
                            //     arguments: {
                            //       'user_id': item.userid ?? 0,
                            //     });
                            // await userProfileController.fetchUserAllPost(
                            //   1,
                            //   item.userid.toString(),
                            // );
                          },
                          child: Row(
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: item.userData?.imagePath ??
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.userData?.name ?? 'Unknown',
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
