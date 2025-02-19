import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/home/notification/custom/custom_time.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';

class AdminNotificationCard extends StatefulWidget {
  final String image;
  final String userName;
  final String dateTime;
  final int classifiedId;
  final NotificationController controller;
  final String userNametype;

  final String type;
  final String name;

  const AdminNotificationCard({
    super.key,
    required this.image,
    required this.userName,
    required this.dateTime,
    required this.classifiedId,
    required this.controller,
    required this.type,
    required this.userNametype,
    required this.name,
  });

  @override
  State<AdminNotificationCard> createState() => _ClassifiedCardState();
}

class _ClassifiedCardState extends State<AdminNotificationCard> {
  late CustomTime postTimeFormatter;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = CustomTime();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035, vertical: size.height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: widget.image,
            fit: BoxFit.cover,
            height: 75,
            width: 75,
            errorWidget: (context, url, error) => Image.asset(
              Assets.imagesAdminlogo,
              fit: BoxFit.cover,
            ),
          ),
        ),
        16.sbw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.userNametype,
                    style:
                        textStyleW700(size.width * 0.034, AppColors.blackText),
                    maxLines: 2,
                  ),
                  Text(
                    postTimeFormatter.formatPostTime(widget.dateTime),
                    style:
                        textStyleW500(size.width * 0.030, AppColors.blackText),
                  ),
                ],
              ),
              3.sbh,
              Text(
                widget.userName,
                style: textStyleW700(size.width * 0.034, AppColors.blackText),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      Assets.imagesAdminlogo,
                      height: 30,
                      width: 30,
                    ),
                    3.sbw,
                    SizedBox(
                      width: size.width * 0.30,
                      child: Text(
                        widget.name,
                        style: textStyleW700(
                            size.width * 0.032, AppColors.blackText),
                        maxLines: 1,
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.redText,
                        ),
                        onPressed: () => LogoutDialog.show(context, () async {
                          widget.controller.deleteNotification(
                              widget.classifiedId, context, widget.type);
                          widget.controller.fetchNotification(1, widget.type);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
