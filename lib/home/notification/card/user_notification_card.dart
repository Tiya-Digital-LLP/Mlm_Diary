import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/home/notification/custom/custom_time.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';

class UserNotificationCard extends StatefulWidget {
  final String image;
  final String userName;
  final String dateTime;
  final String type;
  final String name;

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
    required this.name,
    required this.userNametype,
  });

  @override
  State<UserNotificationCard> createState() => _ClassifiedCardState();
}

class _ClassifiedCardState extends State<UserNotificationCard> {
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
        child: Column(
          children: [
            Row(children: [
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
              10.sbw,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.userName,
                        style: textStyleW700(
                          size.width * 0.038,
                          AppColors.blackText,
                          isMetropolis: true,
                        ),
                      ),
                      3.sbw,
                      Text(
                        postTimeFormatter.formatPostTime(widget.dateTime),
                        style: textStyleW400(
                          size.width * 0.028,
                          AppColors.blackText,
                          isMetropolis: true,
                        ),
                      ),
                    ],
                  ),
                  3.sbh,
                  Text(
                    widget.userNametype,
                    style: textStyleW700(
                      size.width * 0.028,
                      AppColors.blackText,
                      isMetropolis: true,
                    ),
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
                              size.width * 0.032,
                              AppColors.blackText,
                              isMetropolis: true,
                            ),
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
                            onPressed: () =>
                                LogoutDialog.show(context, () async {
                              widget.controller.deleteNotification(
                                  widget.classifiedId, context, widget.type);
                              widget.controller
                                  .fetchNotification(1, widget.type);
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ))
            ])
          ],
        ));
  }
}
