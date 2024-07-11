import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class ChatCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postCaption;
  final String datetime;
  final int readStatus;

  final String chatId;
  final MessageController controller;
  const ChatCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postCaption,
    required this.datetime,
    required this.chatId,
    required this.controller,
    required this.readStatus,
  });

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late PostTimeFormatter postTimeFormatter;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dismissible(
      key: Key(widget.chatId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        // Perform delete operation
        widget.controller.deleteChat(chatId: widget.chatId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.userImage,
                height: 60.0,
                width: 60.0,
                fit: BoxFit.cover,
                placeholder: (context, url) => CustomLottieAnimation(
                  child: Lottie.asset(
                    Assets.lottieLottie,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            10.sbw,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.userName,
                          style: textStyleW700(
                              size.width * 0.035, AppColors.blackText),
                        ),
                        Row(
                          children: [
                            Text(
                              postTimeFormatter.formatPostTime(widget.datetime),
                              style: textStyleW400(size.width * 0.035,
                                  AppColors.blackText.withOpacity(0.5)),
                            ),
                            3.sbw,
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColors.grey,
                            )
                          ],
                        ),
                      ],
                    ),
                    3.sbh,
                    Text(
                      widget.postCaption,
                      maxLines: 2,
                      style: textStyleW700(
                        size.width * 0.035,
                        widget.readStatus == 0
                            ? AppColors.blackText
                            : AppColors.blackText.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
