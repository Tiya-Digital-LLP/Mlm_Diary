import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/card/user_notification_card.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class UserNotification extends StatefulWidget {
  const UserNotification({super.key});

  @override
  State<UserNotification> createState() => _AllNotificationState();
}

class _AllNotificationState extends State<UserNotification> {
  final NotificationController controller = Get.put(NotificationController());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.notificationList.isEmpty) {
                  return Center(
                      child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ));
                }

                if (controller.notificationList.isEmpty) {
                  return const Center(
                    child: Text(
                      'Data not found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.notificationList.length +
                      (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.notificationList.length) {
                      return Center(
                          child: CustomLottieAnimation(
                        child: Lottie.asset(
                          Assets.lottieLottie,
                        ),
                      ));
                    }

                    final post = controller.notificationList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          switch (post.type) {
                            case 'classified':
                              Get.toNamed(Routes.mlmclassifieddetailcopy,
                                  arguments: {
                                    'id': post.id,
                                  });
                              clasifiedController.fetchClassifiedDetail(
                                  post.postid ?? 0, context);
                              break;
                            case 'admin':
                              if (post.postType == 'important') {
                                Get.toNamed('/admin_detail');
                              } else {
                                Get.toNamed('/default_detail');
                              }
                              break;
                            default:
                              Get.toNamed('/default_detail');
                              break;
                          }
                        },
                        child: UserNotificationCard(
                          key: ValueKey(post.id),
                          image: post.userimage ?? '',
                          dateTime: post.creatdate ?? '',
                          classifiedId: post.id ?? 0,
                          userName: post.title ?? '',
                          controller: controller,
                          userNametype: post.message ?? '',
                          type: 'user',
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
