import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class ClassifiedDetailNotification extends StatefulWidget {
  const ClassifiedDetailNotification({required Key key}) : super(key: key);

  @override
  State<ClassifiedDetailNotification> createState() =>
      _ClassidiedDetailsScreenCopyState();
}

class _ClassidiedDetailsScreenCopyState
    extends State<ClassifiedDetailNotification>
    with SingleTickerProviderStateMixin {
  final ClasifiedController controller = Get.put(ClasifiedController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          size: MediaQuery.of(context).size,
          titleText: 'MLM Classified',
          onTap: () {},
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CustomLottieAnimation(
                child: Lottie.asset(
                  Assets.lottieLottie,
                ),
              ),
            );
          }
          return PageView.builder(
            controller: pageController,
            itemCount: controller.classifiedList.length,
            onPageChanged: (index) {
              controller.selectedPostIndex.value = index;

              // Fetch more posts when reaching near the last item
              if (index == controller.classifiedList.length - 1 &&
                  !controller.isEndOfData.value) {
                controller.getTestClassified(controller.currentPage + 1);
              }
            },
            itemBuilder: (context, index) {
              final data = controller.classifiedList[index];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: InkWell(
                                onTap: () async {
                                  Get.toNamed(Routes.userprofilescreen,
                                      arguments: {'user_id': data.userId});
                                  await userProfileController.fetchUserAllPost(
                                      1, data.userId.toString());
                                },
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: data.userData!.imagePath!,
                                        height: 60.0,
                                        width: 60.0,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(Assets.imagesAdminlogo),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.userData!.name!,
                                          style: textStyleW700(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.043,
                                              AppColors.blackText),
                                        ),
                                        const SizedBox(width: 07),
                                        Text(
                                          postTimeFormatter.formatPostTime(
                                            DateTime.parse(data.createdate!)
                                                    .isAtSameMomentAs(
                                                        DateTime.parse(
                                                            data.datemodified!))
                                                ? data.createdate!
                                                : data.datemodified!,
                                          ),
                                          style: textStyleW400(
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                            AppColors.blackText
                                                // ignore: deprecated_member_use
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }));
  }
}
