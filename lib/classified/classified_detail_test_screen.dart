import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class ClassifiedDetailTestScreen extends StatefulWidget {
  final int classifiedId;

  const ClassifiedDetailTestScreen({super.key, required this.classifiedId});

  @override
  State<ClassifiedDetailTestScreen> createState() =>
      _ClassidiedDetailsScreenState();
}

class _ClassidiedDetailsScreenState extends State<ClassifiedDetailTestScreen> {
  final ClasifiedController controller = Get.put(ClasifiedController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  PostTimeFormatter postTimeFormatter = PostTimeFormatter();

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    // Fetch classified details once the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchClassifiedDetail(widget.classifiedId, context);
      controller.countViewClassified(widget.classifiedId, context);
    });
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
          itemCount: controller.classifiedDetailList.length,
          onPageChanged: (index) {
            if (kDebugMode) {
              print("Page changed to: $index");
            }
            if (index >= 0 && index < controller.classifiedDetailList.length) {
              // Fetch classified details for the current page's classified ID
              int classifiedId = controller.classifiedDetailList[index].id;
              controller.fetchClassifiedDetail(classifiedId, context);
            }
          },
          itemBuilder: (context, index) {
            final post = controller.classifiedDetailList[index];
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
                              onTap: () async {},
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: post.userData.imagePath,
                                      height: 60.0,
                                      width: 60.0,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(Assets.imagesAdminlogo),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      post.userData.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
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
      }),
    );
  }
}
