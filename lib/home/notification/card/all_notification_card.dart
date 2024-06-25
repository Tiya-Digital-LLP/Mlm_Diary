import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class AllNotificationCard extends StatelessWidget {
  final String image;
  final String userName;
  final String dateTime;
  final int classifiedId;
  final NotificationController controller;
  final String type;

  const AllNotificationCard({
    super.key,
    required this.image,
    required this.userName,
    required this.dateTime,
    required this.classifiedId,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Dismissible(
      key: Key(classifiedId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        // Perform delete operation
        controller.deleteNotification(classifiedId, context, type);
      },
      child: GestureDetector(
        onTap: () {
          // Handle tap if needed
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: image.isEmpty ? const Icon(Icons.person) : null,
              ),
              10.sbw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: textStyleW700(
                          size.width * 0.036, AppColors.blackText),
                    ),
                    2.sbh,
                    Text(
                      dateTime,
                      style: textStyleW500(
                          size.width * 0.032, AppColors.blackText),
                    ),
                    4.sbh,
                    Row(
                      children: [
                        Image.asset(
                          Assets.imagesAdminlogo,
                          height: 30,
                          width: 30,
                        ),
                        3.sbw,
                        Text(
                          'Admin',
                          style: textStyleW700(
                              size.width * 0.032, AppColors.blackText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
