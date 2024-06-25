import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/home/notification/card/admin_notification_card.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});

  @override
  State<AdminNotification> createState() => _AllNotificationState();
}

class _AllNotificationState extends State<AdminNotification> {
  final NotificationController controller = Get.put(NotificationController());

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
                  return const Center(child: CircularProgressIndicator());
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
                      return const Center(child: CircularProgressIndicator());
                    }

                    final post = controller.notificationList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: GestureDetector(
                        onTap: () {},
                        child: AdminNotificationCard(
                          image: post.userimage ?? '',
                          dateTime: post.creatdate ?? '',
                          classifiedId: post.id ?? 0,
                          userName: post.name ?? '',
                          controller: controller,
                          type: 'admin',
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
