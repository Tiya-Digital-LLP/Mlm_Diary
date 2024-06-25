import 'package:flutter/material.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class ChatCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String postCaption;
  final String chatId;
  final MessageController controller;

  const ChatCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postCaption,
    required this.chatId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dismissible(
      key: Key(chatId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        // Perform delete operation
        controller.deleteChat(chatId: chatId);
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
            CircleAvatar(
              backgroundColor: const Color(0XFFCCC9C9),
              radius: size.width * 0.07,
              child: ClipOval(
                child: Image.asset(
                  userImage,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
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
                          userName,
                          style: textStyleW700(
                              size.width * 0.035, AppColors.blackText),
                        ),
                        Row(
                          children: [
                            Text(
                              "9:41 AM",
                              style: textStyleW400(
                                size.width * 0.030,
                                AppColors.blackText.withOpacity(0.5),
                              ),
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
                      postCaption,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackText,
                        fontSize: size.width * 0.030,
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
