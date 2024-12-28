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
  const BlogLikedListContent({super.key});

  @override
  State<BlogLikedListContent> createState() =>
      _ClassifiedLikedListContentState();
}

class _ClassifiedLikedListContentState extends State<BlogLikedListContent> {
  final ManageBlogController controller = Get.put(ManageBlogController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            ))
          : Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Center(
                      child: Text(
                        'Like Views',
                        style: textStyleW700(
                            size.width * 0.043, AppColors.blackText),
                      ),
                    ),
                    10.sbh,
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.blogLikeList.length,
                        itemBuilder: (context, index) {
                          var item = controller.blogLikeList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: InkWell(
                              onTap: () async {
                                Get.toNamed(Routes.userprofilescreen,
                                    arguments: {
                                      'user_id': item.userid ?? 0,
                                    });
                                await userProfileController.fetchUserAllPost(
                                  1,
                                  item.userid.toString(),
                                );
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        item.userData?.imagePath ?? ''),
                                  ),
                                  8.sbw,
                                  Expanded(
                                    child: Text(
                                      item.userData?.name ?? 'Unknown',
                                      style: textStyleW500(size.width * 0.032,
                                          AppColors.blackText),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
            ),
    );
  }
}
