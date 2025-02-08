import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class ClassifiedViewListContent extends StatefulWidget {
  final int clasiifiedId;
  const ClassifiedViewListContent({super.key, required this.clasiifiedId});

  @override
  State<ClassifiedViewListContent> createState() =>
      _ClassifiedViewListContentState();
}

class _ClassifiedViewListContentState extends State<ClassifiedViewListContent> {
  final ClasifiedController controller = Get.put(ClasifiedController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchViewListClassified(widget.clasiifiedId, 1, context);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isEndOfClassifiedViewListData.value &&
          !controller.isLoading.value) {
        int nextPage = (controller.classifiedViewList.length ~/ 10) + 1;
        controller.fetchViewListClassified(
            widget.clasiifiedId, nextPage, context);
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
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.classifiedViewList.isEmpty) {
                  return Center(
                    child: CustomLottieAnimation(
                      child: Lottie.asset(Assets.lottieLottie),
                    ),
                  );
                }

                if (controller.classifiedViewList.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Found",
                      style:
                          textStyleW500(size.width * 0.04, AppColors.blackText),
                    ),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  itemCount: controller.classifiedViewList.length +
                      (controller.isLoading.value ? 1 : 0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == controller.classifiedViewList.length) {
                      return Center(
                        child: CustomLottieAnimation(
                          child: Lottie.asset(Assets.lottieLottie),
                        ),
                      );
                    }

                    final item = controller.classifiedViewList[index];
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: InkWell(
                          onTap: () async {
                            Get.toNamed(Routes.userprofilescreen, arguments: {
                              'user_id': item.userId ?? 0,
                            });
                            await userProfileController.fetchUserAllPost(
                                1, item.userId.toString());
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  item.userData?.imagePath ?? '',
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
                      ),
                    );
                  },
                );
              }),
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
