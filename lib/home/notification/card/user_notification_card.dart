import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/home/notification/custom/custom_time.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class UserNotificationCard extends StatefulWidget {
  final String image;
  final String userName;
  final String dateTime;
  final String type;
  final String userNametype;

  final int classifiedId;
  final NotificationController controller;

  const UserNotificationCard({
    super.key,
    required this.image,
    required this.userName,
    required this.dateTime,
    required this.classifiedId,
    required this.controller,
    required this.type,
    required this.userNametype,
  });

  @override
  State<UserNotificationCard> createState() => _ClassifiedCardState();
}

class _ClassifiedCardState extends State<UserNotificationCard> {
  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;

  late CustomTime postTimeFormatter;

  bool showCommentBox = false;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = CustomTime();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Dismissible(
      key: Key(widget.classifiedId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        // Perform delete operation
        if (kDebugMode) {
          print('Deleting notification with ID: ${widget.classifiedId}');
        }
        widget.controller
            .deleteNotification(widget.classifiedId, context, widget.type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.035, vertical: size.height * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: widget.image.isEmpty ? const Icon(Icons.person) : null,
                ),
                10.sbw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.userName,
                          style: textStyleW700(
                              size.width * 0.036, AppColors.blackText),
                        ),
                        10.sbw,
                        Text(
                          widget.userNametype,
                          style: textStyleW700(
                              size.width * 0.036, AppColors.blackText),
                        ),
                      ],
                    ),
                    2.sbh,
                    Text(
                      postTimeFormatter.formatPostTime(widget.dateTime),
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
                            size.width * 0.032,
                            AppColors.blackText,
                          ),
                        ),
                      ],
                    ),
                  ],
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
          ],
        ),
      ),
    );
  }
}
