import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class CompanyLikeListContent extends StatefulWidget {
  final int companyId;

  const CompanyLikeListContent({super.key, required this.companyId});

  @override
  State<CompanyLikeListContent> createState() => _CompanyLikeListContentState();
}

class _CompanyLikeListContentState extends State<CompanyLikeListContent> {
  final CompanyController controller = Get.put(CompanyController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchLikeListCompany(widget.companyId, 1, context);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isEndOfCompanyLikeListData.value &&
          !controller.isLoading.value) {
        int nextPage = (controller.companyLikeList.length ~/ 10) + 1;
        controller.fetchLikeListCompany(
          widget.companyId,
          nextPage,
          context,
        );
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
                      controller.companyLikeList.isEmpty) {
                    return Center(
                      child: CustomLottieAnimation(
                        child: Lottie.asset(Assets.lottieLottie),
                      ),
                    );
                  }

                  if (controller.companyLikeList.isEmpty) {
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
                    itemCount: controller.companyLikeList.length +
                        (controller.isLoading.value ? 1 : 0),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == controller.companyLikeList.length) {
                        return Center(
                          child: CustomLottieAnimation(
                            child: Lottie.asset(
                              Assets.lottieLottie,
                            ),
                          ),
                        );
                      }
                      final item = controller.companyLikeList[index];
                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: InkWell(
                            onTap: () async {
                              Get.toNamed(Routes.userprofilescreen, arguments: {
                                'user_id': item.userid ?? 0,
                              });
                              await userProfileController.fetchUserAllPost(
                                1,
                                item.userid.toString(),
                              );
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (item.userData?.name?.isNotEmpty ??
                                                false)
                                            ? item.userData!.name!
                                            : 'Not Type Name',
                                        style: textStyleW700(size.width * 0.038,
                                            AppColors.blackText),
                                      ),
                                      2.sbh,
                                      Text(
                                        () {
                                          final addressParts = [
                                            item.userData?.city?.trim(),
                                            item.userData?.state?.trim(),
                                            item.userData?.country?.trim(),
                                          ]
                                              .where((e) =>
                                                  e != null && e.isNotEmpty)
                                              .toList();

                                          return addressParts.isNotEmpty
                                              ? addressParts.join(', ')
                                              : 'Not Type Address';
                                        }(),
                                        style: textStyleW400(size.width * 0.032,
                                            AppColors.blackText),
                                      ),
                                      2.sbh,
                                      Text(
                                        (item.userData?.immlm
                                                    ?.trim()
                                                    .isNotEmpty ??
                                                false)
                                            ? item.userData!.immlm!.trim()
                                            : 'Not Type IMMLM',
                                        style: textStyleW600(size.width * 0.032,
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
                            size.width * 0.04,
                            AppColors.redText,
                            isMetropolis: true,
                          ),
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
