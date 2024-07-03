import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/card/all_notification_card.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class AllNotification extends StatefulWidget {
  const AllNotification({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllNotificationState createState() => _AllNotificationState();
}

class _AllNotificationState extends State<AllNotification> {
  final NotificationController controller = Get.put(NotificationController());

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
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: AllNotificationCard(
                        key: ValueKey(post.id),
                        image: post.userimage ?? '',
                        dateTime: post.creatdate ?? '',
                        classifiedId: post.id ?? 0,
                        userName: post.name ?? '',
                        controller: controller,
                        type: 'all',
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
