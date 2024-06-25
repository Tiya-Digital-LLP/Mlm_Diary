import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class MessageDetailsScreen extends StatefulWidget {
  const MessageDetailsScreen({super.key});

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  final MessageController messageController = Get.put(MessageController());

  @override
  void initState() {
    super.initState();
    final post = Get.arguments;
    if (post != null && post.chatId != null) {
      messageController.fetchMyChatDetail(post.chatId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final post = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                Assets.svgBack,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    Assets.imagesIcon,
                    height: 40,
                  ),
                  10.sbw,
                  Text(
                    post.username ?? 'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.imagesBg,
              fit: BoxFit.cover,
            ),
          ),
          Obx(
            () => ListView.builder(
              itemCount: messageController.chatdetailsList.length,
              itemBuilder: (context, index) {
                final message = messageController.chatdetailsList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            message.msg ?? '',
                            style: TextStyle(
                              color: AppColors.blackText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      Assets.svgPlusIcon,
                      height: 40,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.searchbar,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: messageController.msg.value,
                            decoration: const InputDecoration(
                              hintText: 'Write your answer here',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              messageController.sendChat(
                                toId: post.toid.toString(),
                                chatId: post.chatId.toString(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      Assets.svgSend,
                    ),
                    onPressed: () {
                      messageController.sendChat(
                        toId: post.toid.toString(),
                        chatId: post.chatId.toString(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
